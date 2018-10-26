//
//  HgMusicListViewController.m
//  News
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicListViewController.h"
#import "HgMusicRequest.h"
#import "HgMusicInfoModel.h"
#import "HgMusicCell.h"
#import "HgMusicPlayerManager.h"
#import "HgSongInfo.h"

@interface HgMusicListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView * tableView;

@property (strong , nonatomic) NSMutableArray * arrayList;

@property (strong , nonatomic) NSIndexPath * oldIndexPath;

@end

@implementation HgMusicListViewController

#pragma mark - ZJScrollPageViewChildVcDelegate
-(void)zj_viewDidLoadForIndex:(NSInteger)index{
    
    [HgSongInfo.shared addObserver:self forKeyPath:@"playSongIndex" options:NSKeyValueObservingOptionOld
     |NSKeyValueObservingOptionNew context:nil];
}

- (void)zj_viewWillAppearForIndex:(NSInteger)index{
    if (self.oldIndexPath) {
        HgMusicInfoModel * model = self.arrayList[self.oldIndexPath.row];
        if (![model.title isEqualToString:HgSongInfo.shared.title]) {
            model.isPlay = NO;
            [self.tableView reloadRowsAtIndexPaths:@[self.oldIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath  isEqual: @"playSongIndex"]) {
        [self changeIndex:change];
    }

}

-(void)changeIndex:(NSDictionary<NSKeyValueChangeKey,id> *)change{
    
    NSInteger num = [change[@"new"] integerValue];
    HgMusicInfoModel * oldmodel = self.arrayList[self.oldIndexPath.row];
    oldmodel.isPlay = NO;
    HgMusicInfoModel * model = self.arrayList[num];
    if ([model.title isEqualToString:HgSongInfo.shared.title]) {
        model.isPlay = YES;
    }
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:num inSection:0];
    self.oldIndexPath = [NSIndexPath indexPathForRow:[change[@"old"] integerValue] inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath,self.oldIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    HgSongInfo.shared.lrcIndex = 0;
    self.oldIndexPath = indexPath;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    [self loadData];
}

-(void)loadData{
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        StrongVar(strongSelf, weakSelf);
        if (strongSelf) {
            [strongSelf requestData];
        }
    }];
    [self.tableView.mj_header beginRefreshing];
}

-(void)requestData{
    uint8_t type;
    if ([self.channelTitle  isEqual: @"新歌"]) {
        type = NEW_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"热歌"]) {
        type = HOT_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"经典"]) {
        type = OLD_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"情歌"]) {
        type = LOVE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"网络"]) {
        type = INTERNET_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"影视"]) {
        type = MOVIE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"欧美"]) {
        type = EUROPE_SONG_LIST;
    }else if ([self.channelTitle  isEqual: @"Bill"]) {
        type = BILLBOARD_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"摇滚"]) {
        type = ROCK_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"爵士"]) {
        type = JAZZ_MUSIC_LIST;
    }else if ([self.channelTitle  isEqual: @"流行"]) {
        type = POP_MUSIC_LIST;
    }else {
        return;
    }
    WEAKSELF;
    [self.arrayList removeAllObjects];
    [HgMusicRequest getMusicListWithType:type WithOffset:0  block:^(id responseData) {
        NSDictionary * data = responseData;
        StrongVar(sself, weakSelf);
        if ([data containsObject:@"song_list"]) {
            NSArray * song_list = [data objectForKey:@"song_list"];
            for (NSDictionary * dict in song_list) {
                HgMusicInfoModel * model = [[HgMusicInfoModel alloc] initWithDict:dict];
                [sself.arrayList addObject:model];
            }
            HgSongInfo.shared.isDataRequestFinish = YES;
            
            if (sself.oldIndexPath) {
                HgMusicInfoModel * model = sself.arrayList[sself.oldIndexPath.row];
                model.isPlay = YES;
            }
            
            [sself.tableView reloadData];
        }else{
            [MBProgressHUD showHUDMsg:@"网络错误~"];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)creatUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH -NaviBarHeight -44 -45 - kBottomMargin ) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HgMusicInfoModel * model = self.arrayList[indexPath.row];
    HgMusicCell * cell = [HgMusicCell initMusicViewCellWithTableView:tableView];
    cell.model = model;
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HgSongInfo.shared.OMSongs = self.arrayList;
    HgMusicInfoModel * model = self.arrayList[indexPath.row];
    model.isPlay = YES;
    if (self.oldIndexPath) {
        if (self.oldIndexPath != indexPath) {
            HgMusicInfoModel * oldmodel = self.arrayList[self.oldIndexPath.row];
            oldmodel.isPlay = NO;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath,self.oldIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            self.oldIndexPath = indexPath;
            HgSongInfo.shared.lrcIndex = 0;
            [HgSongInfo.shared setSongInfo:model];
            [HgSongInfo.shared getSelectedSong:model.song_id index:indexPath.row];
        }
        
    } else {
        self.oldIndexPath = indexPath;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        HgSongInfo.shared.lrcIndex = 0;
        [HgSongInfo.shared setSongInfo:model];
        [HgSongInfo.shared getSelectedSong:model.song_id index:indexPath.row];
    }
    [self.detailController refreshBgImage:HgSongInfo.shared.pic_big];
    [self presentViewController:self.detailController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)arrayList{
    if (_arrayList == nil) {
        _arrayList = [NSMutableArray new];
    }
    return _arrayList;
}

@end
