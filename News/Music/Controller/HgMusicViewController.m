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

@property (nonatomic, strong) UIImageView * lrcImageView;

@property (nonatomic, strong) UIImage * lastImage;//最后一次锁屏之后的歌词海报

@end

@implementation HgMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [HgSongInfo.shared addObserver:self forKeyPath:@"playSongIndex" options:NSKeyValueObservingOptionOld
     |NSKeyValueObservingOptionNew context:nil];
    [HgSongInfo.shared addObserver:self forKeyPath:@"isDataRequestFinish" options:NSKeyValueObservingOptionOld
     |NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(playSongSetting)
                                                 name: @"repeatPlay"
                                               object: nil];
    
    // 锁屏播放设置
    [self createRemoteCommandCenter];
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
        //监听锁屏状态 lock=1则为锁屏状态
        uint64_t locked;
        __block int token = 0;
        notify_register_dispatch("com.apple.springboard.lockstate",&token,dispatch_get_main_queue(),^(int t){
        });
        notify_get_state(token, &locked);
        
        //监听屏幕点亮状态 screenLight = 1则为变暗关闭状态
        uint64_t screenLight;
        __block int lightToken = 0;
        notify_register_dispatch("com.apple.springboard.hasBlankedScreen",&lightToken,dispatch_get_main_queue(),^(int t){
        });
        notify_get_state(lightToken, &screenLight);
        
        BOOL isShowLyricsPoster = NO;
        // NSLog(@"screenLight=%llu locked=%llu",screenLight,locked);
        if (screenLight == 0 && locked == 1) {
            //点亮且锁屏时
            isShowLyricsPoster = YES;
        }else if(screenLight){
            return;
        }
        
        //展示锁屏歌曲信息，上面监听屏幕锁屏和点亮状态的目的是为了提高效率
        [weakSelf showLockScreenTotaltime:totalTime andCurrentTime:currentTime andLyricsPoster:isShowLyricsPoster];
    }];
    
}

#pragma mark - 锁屏播放设置
//展示锁屏歌曲信息：图片、歌词、进度、演唱者
- (void)showLockScreenTotaltime:(float)totalTime andCurrentTime:(float)currentTime andLyricsPoster:(BOOL)isShow{
    
        NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
        //设置歌曲题目
        [songDict setObject:HgSongInfo.shared.title forKey:MPMediaItemPropertyTitle];
        //设置歌手名
        [songDict setObject:HgSongInfo.shared.author forKey:MPMediaItemPropertyArtist];
        //设置专辑名
        [songDict setObject:HgSongInfo.shared.album_title forKey:MPMediaItemPropertyAlbumTitle];
        //设置歌曲时长
        [songDict setObject:[NSNumber numberWithDouble:totalTime]  forKey:MPMediaItemPropertyPlaybackDuration];
        //设置已经播放时长
        [songDict setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
        NSString * lrcImage = HgSongInfo.shared.pic_big;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:lrcImage] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                if (isShow) {
                    
                    //制作带歌词的海报
                    if (!_lrcImageView) {
                        _lrcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480,800)];
                    }
                    
                    
                    //主要为了把歌词绘制到图片上，已达到更新歌词的目的
                    _lrcImageView.image = image;
                    _lrcImageView.backgroundColor = [UIColor blackColor];
                    
                    //获取添加了歌词数据的海报图片
                    UIGraphicsBeginImageContextWithOptions(_lrcImageView.frame.size, NO, 0.0);
                    CGContextRef context = UIGraphicsGetCurrentContext();
                    [_lrcImageView.layer renderInContext:context];
                    _lrcImageView.image = UIGraphicsGetImageFromCurrentImageContext();
                    _lastImage = image;
                    UIGraphicsEndImageContext();
                    
                }else{
                    if (_lastImage) {
                        _lrcImageView.image = _lastImage;
                    }
                }
                //设置显示的海报图片
                [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:image]
                             forKey:MPMediaItemPropertyArtwork];
                
            }
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
        }];
}

#pragma mark - 锁屏界面开启和监控远程控制事件
//锁屏界面开启和监控远程控制事件
- (void)createRemoteCommandCenter{
    
    // 远程控制命令中心 iOS 7.1 之后  详情看官方文档：https://developer.apple.com/documentation/mediaplayer/mpremotecommandcenter
    
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    // 远程控制播放
    [commandCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [HgMusicPlayerManager.shared.play pause];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    // 远程控制暂停
    [commandCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [HgMusicPlayerManager.shared.play play];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    // 远程控制上一曲
    [commandCenter.previousTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"上一曲");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    // 远程控制下一曲
    [commandCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"下一曲");
        [self nextButtonAction:nil];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    
    //在控制台拖动进度条调节进度（仿QQ音乐的效果）
    [commandCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        CMTime totlaTime = HgMusicPlayerManager.shared.play.currentItem.duration;
        MPChangePlaybackPositionCommandEvent * playbackPositionEvent = (MPChangePlaybackPositionCommandEvent *)event;
        [HgMusicPlayerManager.shared.play seekToTime:CMTimeMake(totlaTime.value*playbackPositionEvent.positionTime/CMTimeGetSeconds(totlaTime), totlaTime.timescale) completionHandler:^(BOOL finished) {
        }];
        return MPRemoteCommandHandlerStatusSuccess;
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
