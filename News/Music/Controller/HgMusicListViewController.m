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

//锁屏图片视图,用来绘制带歌词的image
@property (nonatomic, strong) UIImageView * lrcImageView;
@property (nonatomic, strong) UIImage * lastImage;//最后一次锁屏之后的歌词海报

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
    model.isPlay = YES;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:num inSection:0];
    self.oldIndexPath = [NSIndexPath indexPathForRow:[change[@"old"] integerValue] inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath,self.oldIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    HgSongInfo.shared.lrcIndex = 0;
    self.oldIndexPath = indexPath;

}

//-(void)playSongSetting{
//    
//    if (HgMusicPlayerManager.shared.playerTimeObserver != nil) {
//        
//        [HgMusicPlayerManager.shared.play removeTimeObserver:HgMusicPlayerManager.shared.playerTimeObserver];
//        HgMusicPlayerManager.shared.playerTimeObserver = nil;
//        
//        [HgMusicPlayerManager.shared.play.currentItem cancelPendingSeeks];
//        [HgMusicPlayerManager.shared.play.currentItem.asset cancelLoading];
//        
//    }
//    
//    // detail页面控制界面信息设置
//    self.detailController.topView.songTitleLabel.scrollTitle = HgSongInfo.shared.title;
//    self.detailController.topView.singerNameLabel.text = [[@"- " stringByAppendingString:HgSongInfo.shared.author] stringByAppendingString:@" -"];
//    [self.detailController.midView.midIconView setAlbumImage:HgSongInfo.shared.pic_big];
//    [self.detailController.midView.midLrcView AnalysisLRC:HgSongInfo.shared.lrcString];
//    
//    [HgMusicPlayerManager.shared setPlayItem:HgSongInfo.shared.file_link];
//    [HgMusicPlayerManager.shared setPlay];
//    [HgMusicPlayerManager.shared startPlay];
//    
//    // 歌词index清零
//    HgSongInfo.shared.lrcIndex = 0;
//    
//    // 控制界面设置
//    [self.detailController playStateRecover];
//    
//    // 播放结束通知
//    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(finishedPlaying) name:AVPlayerItemDidPlayToEndTimeNotification object:HgMusicPlayerManager.shared.play.currentItem];
//    // 设置Observer更新播放进度
//    WEAKSELF;
//    HgMusicPlayerManager.shared.playerTimeObserver = [HgMusicPlayerManager.shared.play addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        
//        CGFloat currentTime = CMTimeGetSeconds(time);
//        CMTime total = HgMusicPlayerManager.shared.play.currentItem.duration;
//        CGFloat totalTime = CMTimeGetSeconds(total);
//        // 当前播放时间
//        weakSelf.detailController.bottomView.currentTimeLabel.text = [HgSongInfo.shared intToString:(int)currentTime];
//        // 总时间
//        weakSelf.detailController.bottomView.durationTimeLabel.text =[HgSongInfo.shared intToString:(int)totalTime];
//        
//        weakSelf.detailController.bottomView.songSlider.value = (float) ( currentTime / totalTime );
//        
//        // 更新歌词
//        if (HgSongInfo.shared.isLrcExistFlg == true) {
//            
//            if (!weakSelf.detailController.midView.midLrcView.isDragging) {
//                
//                if (HgSongInfo.shared.lrcIndex <= HgSongInfo.shared.mLRCDictinary.count - 1) {
//                    
//                    if ((int)currentTime >= [HgSongInfo.shared stringToInt:HgSongInfo.shared.mTimeArray[HgSongInfo.shared.lrcIndex]]) {
//                        
//                        weakSelf.detailController.midView.midLrcView.currentRow = HgSongInfo.shared.lrcIndex;
//                        
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            
//                            [weakSelf.detailController.midView.midLrcView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.detailController.midView.midLrcView.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//                            
//                        });
//                        
//                        // 刷新歌词列表
//                        [weakSelf.detailController.midView.midLrcView.tableView reloadData];
//                        
//                        HgSongInfo.shared.lrcIndex = HgSongInfo.shared.lrcIndex + 1;
//                        
//                    } else {
//                        
//                        if (HgSongInfo.shared.lrcIndex != 0) {
//                            
//                            if (((int)currentTime >= [HgSongInfo.shared stringToInt:HgSongInfo.shared.mTimeArray[HgSongInfo.shared.lrcIndex - 1]]) && ((int)currentTime < [HgSongInfo.shared stringToInt:HgSongInfo.shared.mTimeArray[HgSongInfo.shared.lrcIndex]])) {
//                                
//                                weakSelf.detailController.midView.midLrcView.currentRow = HgSongInfo.shared.lrcIndex - 1;
//                                
//                                dispatch_async(dispatch_get_main_queue(), ^{
//                                    [weakSelf.detailController.midView.midLrcView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.detailController.midView.midLrcView.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//                                });
//                                
//                                // 刷新歌词列表
//                                [weakSelf.detailController.midView.midLrcView.tableView reloadData];
//                            }
//                        }
//                        
//                    }
//                    
//                }
//            }
//        }
//        
//        
//        //监听锁屏状态 lock=1则为锁屏状态
//        uint64_t locked;
//        __block int token = 0;
//        notify_register_dispatch("com.apple.springboard.lockstate",&token,dispatch_get_main_queue(),^(int t){
//        });
//        notify_get_state(token, &locked);
//        
//        //监听屏幕点亮状态 screenLight = 1则为变暗关闭状态
//        uint64_t screenLight;
//        __block int lightToken = 0;
//        notify_register_dispatch("com.apple.springboard.hasBlankedScreen",&lightToken,dispatch_get_main_queue(),^(int t){
//        });
//        notify_get_state(lightToken, &screenLight);
//        
//        BOOL isShowLyricsPoster = NO;
//        // NSLog(@"screenLight=%llu locked=%llu",screenLight,locked);
//        if (screenLight == 0 && locked == 1) {
//            //点亮且锁屏时
//            isShowLyricsPoster = YES;
//        }else if(screenLight){
//            return;
//        }
//        
//        //展示锁屏歌曲信息，上面监听屏幕锁屏和点亮状态的目的是为了提高效率
//        [weakSelf showLockScreenTotaltime:totalTime andCurrentTime:currentTime andLyricsPoster:isShowLyricsPoster];
//    }];
//    
//}

#pragma mark - 锁屏播放设置
//展示锁屏歌曲信息：图片、歌词、进度、演唱者
- (void)showLockScreenTotaltime:(float)totalTime andCurrentTime:(float)currentTime andLyricsPoster:(BOOL)isShow{
    
//    NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
//    //设置歌曲题目
//    [songDict setObject:songInfo.title forKey:MPMediaItemPropertyTitle];
//    //设置歌手名
//    [songDict setObject:songInfo.author forKey:MPMediaItemPropertyArtist];
//    //设置专辑名
//    [songDict setObject:songInfo.album_title forKey:MPMediaItemPropertyAlbumTitle];
//    //设置歌曲时长
//    [songDict setObject:[NSNumber numberWithDouble:totalTime]  forKey:MPMediaItemPropertyPlaybackDuration];
//    //设置已经播放时长
//    [songDict setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
//    
//    UIImage * lrcImage = songInfo.pic_big;
//    if (isShow) {
//        
//        //制作带歌词的海报
//        if (!_lrcImageView) {
//            _lrcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480,800)];
//        }
//        
//        //主要为了把歌词绘制到图片上，已达到更新歌词的目的
//        [_lrcImageView addSubview:self.detailController.midView.midLrcView.lockScreenTableView];
//        _lrcImageView.image = lrcImage;
//        _lrcImageView.backgroundColor = [UIColor blackColor];
//        
//        //获取添加了歌词数据的海报图片
//        UIGraphicsBeginImageContextWithOptions(_lrcImageView.frame.size, NO, 0.0);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        [_lrcImageView.layer renderInContext:context];
//        lrcImage = UIGraphicsGetImageFromCurrentImageContext();
//        _lastImage = lrcImage;
//        UIGraphicsEndImageContext();
//        
//    }else{
//        if (_lastImage) {
//            lrcImage = _lastImage;
//        }
//    }
//    //设置显示的海报图片
//    [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:lrcImage]
//                 forKey:MPMediaItemPropertyArtwork];
//    
//    
//    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
    
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
            HgSongInfo.shared.OMSongs = self.arrayList;
            [sself.tableView reloadData];
        }else{
            [MBProgressHUD showHUDMsg:@"网络错误~"];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)creatUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH -64 -45 -45 ) style:UITableViewStylePlain];
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

#pragma mark - 歌曲播放结束操作
-(void) finishedPlaying {
    
    NSLog(@"本歌曲播放结束，准备播放下一首歌曲！");
    NSLog(@"%@",self.oldIndexPath);
    [self nextButtonAction:nil];
}

#pragma mark - 下一曲
-(void) nextButtonAction: (UIButton *)sender {
    
    HgSongInfo.shared.lrcIndex = 0;
    NSIndexPath * indexPath = self.oldIndexPath;
    HgMusicInfoModel * oldmodel = self.arrayList[indexPath.row];
    oldmodel.isPlay = NO;
    if (HgSongInfo.shared.playSongIndex < HgSongInfo.shared.OMSongs.count - 1) {
        HgMusicInfoModel *info = HgSongInfo.shared.OMSongs[HgSongInfo.shared.playSongIndex + 1];
        NSLog(@"即将播放下一首歌曲: 《%@》", info.title);
        [HgSongInfo.shared setSongInfo:info];
        [HgSongInfo.shared getSelectedSong:info.song_id index:HgSongInfo.shared.playSongIndex + 1];
        
        self.oldIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        HgMusicInfoModel * model = self.arrayList[self.oldIndexPath.row];
        model.isPlay = YES;
        
    } else {
        HgMusicInfoModel *info = HgSongInfo.shared.OMSongs[0];
        NSLog(@"即将播放下一首歌曲: 《%@》", info.title);
        [HgSongInfo.shared setSongInfo:info];
        [HgSongInfo.shared getSelectedSong:info.song_id index:0];
        self.oldIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        HgMusicInfoModel * model = self.arrayList[self.oldIndexPath.row];
        model.isPlay = YES;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath,self.oldIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(NSMutableArray *)arrayList{
    if (_arrayList == nil) {
        _arrayList = [NSMutableArray new];
    }
    return _arrayList;
}

@end
