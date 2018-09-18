//
//  HgMusicViewController.m
//  News
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicViewController.h"
#import "HgMusicListViewController.h"
#import "ZJScrollPageView.h"
#import "HgMusicDetailViewController.h"
#import "HgSongInfo.h"
#import "HgMusicPlayerManager.h"

@interface HgMusicViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic , strong) NSArray * titles;

@property (nonatomic, strong) HgMusicDetailViewController *detailController;

@property (nonatomic, strong) id playerTimeObserver;

@end

@implementation HgMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [HgSongInfo.shared addObserver:self forKeyPath:@"playSongIndex" options:NSKeyValueObservingOptionOld
     |NSKeyValueObservingOptionNew context:nil];
    [HgSongInfo.shared addObserver:self forKeyPath:@"isDataRequestFinish" options:NSKeyValueObservingOptionOld
     |NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath  isEqual: @"playSongIndex"]) {
        [self playSongSetting];
    }
    
    if ([keyPath isEqual:@"isDataRequestFinish"]) {
        if (HgSongInfo.shared.isDataRequestFinish == YES) {
            HgSongInfo.shared.isDataRequestFinish = NO;
            //            [self.detailController.songListView.tableView reloadData];
        }
    }
    
}

-(void)playSongSetting{
    dispatch_async(dispatch_get_main_queue(), ^{

        [self.detailController.midView.midLrcView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

    });

    [self.detailController.midView.midLrcView.tableView reloadData];
    
    if (self.playerTimeObserver != nil) {
        
        [HgMusicPlayerManager.shared.play removeTimeObserver:self.playerTimeObserver];
        self.playerTimeObserver = nil;
        
        [HgMusicPlayerManager.shared.play.currentItem cancelPendingSeeks];
        [HgMusicPlayerManager.shared.play.currentItem.asset cancelLoading];
        
    }
    
    // detail页面控制界面信息设置
    self.detailController.topView.songTitleLabel.scrollTitle = HgSongInfo.shared.title;
    self.detailController.topView.singerNameLabel.text = [[@"- " stringByAppendingString:HgSongInfo.shared.author] stringByAppendingString:@" -"];
    [self.detailController.midView.midIconView setAlbumImage:HgSongInfo.shared.pic_big];
    [self.detailController.midView.midLrcView AnalysisLRC:HgSongInfo.shared.lrcString];
    
    [HgMusicPlayerManager.shared setPlayItem:HgSongInfo.shared.file_link];
    [HgMusicPlayerManager.shared setPlay];
    [HgMusicPlayerManager.shared startPlay];
    
    // 歌词index清零
    HgSongInfo.shared.lrcIndex = 0;
    
    // 控制界面设置
    [self.detailController playStateRecover];
    
    // 播放结束通知
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(finishedPlaying) name:AVPlayerItemDidPlayToEndTimeNotification object:HgMusicPlayerManager.shared.play.currentItem];
    // 设置Observer更新播放进度
    WEAKSELF;
    self.playerTimeObserver = [HgMusicPlayerManager.shared.play addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        CGFloat currentTime = CMTimeGetSeconds(time);
        CMTime total = HgMusicPlayerManager.shared.play.currentItem.duration;
        CGFloat totalTime = CMTimeGetSeconds(total);
        // 当前播放时间
        weakSelf.detailController.bottomView.currentTimeLabel.text = [HgSongInfo.shared intToString:(int)currentTime];
        // 总时间
        weakSelf.detailController.bottomView.durationTimeLabel.text =[HgSongInfo.shared intToString:(int)totalTime];
        
        weakSelf.detailController.bottomView.songSlider.value = (float) ( currentTime / totalTime );
        
        // 更新歌词
        if (!weakSelf.detailController.midView.midLrcView.isDragging) {
            
            if (HgSongInfo.shared.lrcIndex <= HgSongInfo.shared.mLRCDictinary.count - 1) {
                
                if ((int)currentTime >= [HgSongInfo.shared stringToInt:HgSongInfo.shared.mTimeArray[HgSongInfo.shared.lrcIndex]]) {
                    
                    weakSelf.detailController.midView.midLrcView.currentRow = HgSongInfo.shared.lrcIndex;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [weakSelf.detailController.midView.midLrcView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.detailController.midView.midLrcView.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                        
                    });
                    
                    // 刷新歌词列表
                    [weakSelf.detailController.midView.midLrcView.tableView reloadData];
                    
                    HgSongInfo.shared.lrcIndex = HgSongInfo.shared.lrcIndex + 1;
                    
                } else {
                    
                    if (HgSongInfo.shared.lrcIndex != 0) {
                        
                        if (((int)currentTime >= [HgSongInfo.shared stringToInt:HgSongInfo.shared.mTimeArray[HgSongInfo.shared.lrcIndex - 1]]) && ((int)currentTime < [HgSongInfo.shared stringToInt:HgSongInfo.shared.mTimeArray[HgSongInfo.shared.lrcIndex]])) {
                            
                            weakSelf.detailController.midView.midLrcView.currentRow = HgSongInfo.shared.lrcIndex - 1;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.detailController.midView.midLrcView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.detailController.midView.midLrcView.currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                            });
                            
                            // 刷新歌词列表
                            [weakSelf.detailController.midView.midLrcView.tableView reloadData];
                        }
                    }
                    
                }
                
            }
        }
    }];
    
}

-(void)creatUI{
    self.view.backgroundColor=[UIColor whiteColor];
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.scrollTitle = YES;
    style.segmentViewBounces = YES;
    style.scrollLineColor=Theme_Color;
    style.scrollLineHeight=2;
    style.normalTitleColor=RGBA(100, 100, 100, 1);
    style.selectedTitleColor=Theme_Color;
    style.gradualChangeTitleColor = YES;
    style.titleFont=[UIFont boldSystemFontOfSize:16];
    
    self.titles  = @[@"新歌", @"热歌", @"经典", @"情歌", @"网络", @"影视", @"欧美",@"Bill", @"摇滚", @"爵士", @"流行"];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:scrollPageView];
    
    self.detailController = [[HgMusicDetailViewController alloc] init];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        HgMusicListViewController *VC = [[HgMusicListViewController alloc] init];
        VC.channelTitle = self.titles[index];
        VC.detailController = self.detailController;
        childVc=VC;
    }
    
    return childVc;
}

#pragma mark - 歌曲播放结束操作
-(void) finishedPlaying {
    
    NSLog(@"本歌曲播放结束，准备播放下一首歌曲！");
    [self nextButtonAction:nil];
}

#pragma mark - 下一曲
-(void) nextButtonAction: (UIButton *)sender {
    
    if (HgSongInfo.shared.playSongIndex < HgSongInfo.shared.OMSongs.count - 1) {
        HgMusicInfoModel *info = HgSongInfo.shared.OMSongs[HgSongInfo.shared.playSongIndex + 1];
        NSLog(@"即将播放下一首歌曲: 《%@》", info.title);
        [HgSongInfo.shared setSongInfo:info];
        [HgSongInfo.shared getSelectedSong:info.song_id index:HgSongInfo.shared.playSongIndex + 1];
        
        
    } else {
        HgMusicInfoModel *info = HgSongInfo.shared.OMSongs[0];
        NSLog(@"即将播放下一首歌曲: 《%@》", info.title);
        [HgSongInfo.shared setSongInfo:info];
        [HgSongInfo.shared getSelectedSong:info.song_id index:0];
    }
    [self.detailController refreshBgImage:HgSongInfo.shared.pic_big];
}

@end
