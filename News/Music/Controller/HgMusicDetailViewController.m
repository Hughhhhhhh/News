//
//  HgMusicDetailViewController.m
//  News
//
//  Created by admin on 2018/9/13.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicDetailViewController.h"

@implementation HgMusicDetailViewController

int lrcIndex = 0;

-(instancetype) init {
    self = [super init];
    if (self) {
        // 初始化SubView
        [self configSubView];
    }
    
    return self;
}

-(void)configSubView{
    
    // top view初始化
    _topView = [[HgMusicTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 5)];
    [_topView.backBtn addTarget:self action:@selector(backAction) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:_topView];
    
    // mid view 初始化
    _midView = [[HgMusicMidView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 5, self.view.frame.size.width, self.view.frame.size.height / 5 * 3)];
    [self.view addSubview:_midView];
    
    // bottom view 初始化
    _bottomView = [[HgMusicBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 5 * 4, self.view.frame.size.width, self.view.frame.size.height / 5)];
    [self.view addSubview:_bottomView];
    
    // 添加playOrPauseButton响应事件
    [_bottomView.playOrPauseButton addTarget:self action:@selector(playOrPauseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加nextSongButton响应事件
    [_bottomView.nextSongButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加preButton响应事件
    [_bottomView.preSongButtton addTarget:self action:@selector(preButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加shuffleAndRepeat响应事件
    [_bottomView.playModeButton addTarget:self action:@selector(shuffleAndRepeat) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加songListButton响应事件
    [_bottomView.songListButton addTarget:self action:@selector(songListButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    // 播放进度条添加响应事件
    [_bottomView.songSlider addTarget:self //事件委托对象
                               action:@selector(playbackSliderValueChanged) //处理事件的方法
                     forControlEvents:UIControlEventValueChanged//具体事件
     ];
    [_bottomView.songSlider addTarget:self //事件委托对象
                               action:@selector(playbackSliderValueChangedFinish) //处理事件的方法
                     forControlEvents:UIControlEventTouchUpInside//具体事件
     ];
    
    [self setBackgroundImage:[UIImage imageNamed:@"backgroundImage3"]];
}

-(void) viewWillAppear:(BOOL)animated {
    [self playStateRecover];
}

#pragma - mark 设置detail控制界面背景图片
-(void) setBackgroundImage: (UIImage *)image {
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-UIScreen.mainScreen.bounds.size.width / 2, -UIScreen.mainScreen.bounds.size.height / 2, UIScreen.mainScreen.bounds.size.width * 2, UIScreen.mainScreen.bounds.size.height * 2)];
    _backgroundImageView.image = image;
    _backgroundImageView.clipsToBounds = true;
    [self.view addSubview:_backgroundImageView];
    [self.view sendSubviewToBack:_backgroundImageView];
    
    // 毛玻璃效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualView.alpha = 1.0;
    visualView.frame = CGRectMake(-UIScreen.mainScreen.bounds.size.width / 2, -UIScreen.mainScreen.bounds.size.height / 2, UIScreen.mainScreen.bounds.size.width * 2, UIScreen.mainScreen.bounds.size.height * 2);
    visualView.clipsToBounds = true;
    [_backgroundImageView addSubview:visualView];
    
}

-(void)refreshBgImage:(NSString *)image{
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getShuffleAndRepeatState];
}


#pragma - mark 获取保存的播放模式
- (void)getShuffleAndRepeatState
{

    NSNumber *repeatAndShuffleNumber = (NSNumber *)[NSObject readObjforKey:@"SHFFLEANDREPEATSTATE"];
    if (repeatAndShuffleNumber == nil)
    {
        HgMusicPlayerManager.shared.shuffleAndRepeatState = RepeatPlayMode;
    }
    else
    {
        HgMusicPlayerManager.shared.shuffleAndRepeatState = (ShuffleAndRepeatState)[repeatAndShuffleNumber integerValue];
    }
    
    switch (HgMusicPlayerManager.shared.shuffleAndRepeatState)
    {
        case RepeatPlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"随机播放"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"随机播放（高亮）"] forState:UIControlStateHighlighted];
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"单曲循环"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"单曲循环（高亮）"] forState:UIControlStateHighlighted];
        }
            break;
        case ShufflePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"列表播放"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"列表播放（高亮）"] forState:UIControlStateHighlighted];
            break;
        default:
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backAction {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma - mark 播放或暂停
-(void) playOrPauseButtonAction {
    if (HgMusicPlayerManager.shared.play.rate == 0) {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView resumeRotate];
        [HgMusicPlayerManager.shared startPlay];
        
    } else {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放（高亮）"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView stopRotating];
        [HgMusicPlayerManager.shared stopPlay];
    }
}

#pragma - mark 下一曲
-(void) nextButtonAction {
    HgMusicPlayerManager.shared.playingIndex = HgSongInfo.shared.playSongIndex;
    switch (HgMusicPlayerManager.shared.shuffleAndRepeatState) {
        case RepeatPlayMode:
        {
            HgMusicPlayerManager.shared.playingIndex ++ ;
            if (HgMusicPlayerManager.shared.playingIndex >= HgSongInfo.shared.OMSongs.count) {
                HgMusicPlayerManager.shared.playingIndex = 0 ;
            }
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            
        }
            break;
        case ShufflePlayMode:
        {
            if (HgMusicPlayerManager.shared.playingIndex == HgSongInfo.shared.OMSongs.count - 1) {
                HgMusicPlayerManager.shared.playingIndex = [self getRandomNumber:0 with:(HgSongInfo.shared.OMSongs.count - 2)];
            }else{
                HgMusicPlayerManager.shared.playingIndex = [self getRandomNumber:(HgMusicPlayerManager.shared.playingIndex + 1) with:(HgSongInfo.shared.OMSongs.count - 1)];
            }
        }
            break;
            
        default:
            break;
    }
    if (HgMusicPlayerManager.shared.playingIndex != HgSongInfo.shared.playSongIndex) {
        if (HgMusicPlayerManager.shared.playingIndex < HgSongInfo.shared.OMSongs.count) {
            HgMusicInfoModel * model = HgSongInfo.shared.OMSongs[HgMusicPlayerManager.shared.playingIndex + 1];
            [HgSongInfo.shared setSongInfo:model];
            [HgSongInfo.shared getSelectedSong:model.song_id index:HgSongInfo.shared.playSongIndex + 1];
        }
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatPlay" object:self];
    }
}

#pragma - mark 上一曲
-(void) preButtonAction {
}

#pragma - mark 播放模式按键action
-(void) shuffleAndRepeat {
    switch (HgMusicPlayerManager.shared.shuffleAndRepeatState)
    {
        case RepeatPlayMode:
        {
            
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"单曲循环"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"单曲循环（高亮）"] forState:UIControlStateHighlighted];
            HgMusicPlayerManager.shared.shuffleAndRepeatState = RepeatOnlyOnePlayMode;  //单曲循环
            [MBProgressHUD showHUDMsg:@"单曲循环"];
        }
            break;
        case RepeatOnlyOnePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"列表播放"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"列表播放（高亮）"] forState:UIControlStateHighlighted];
            HgMusicPlayerManager.shared.shuffleAndRepeatState = ShufflePlayMode;
            [MBProgressHUD showHUDMsg:@"列表播放"];
        }
            break;
        case ShufflePlayMode:
        {
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"随机播放"] forState:UIControlStateNormal];
            [_bottomView.playModeButton setImage:[UIImage imageNamed:@"随机播放（高亮）"] forState:UIControlStateHighlighted];
            HgMusicPlayerManager.shared.shuffleAndRepeatState = RepeatPlayMode;
            [MBProgressHUD showHUDMsg:@"随机播放"];
        }
            break;
        default:
            break;
    }
    
    [NSObject saveObj:[NSNumber numberWithInteger:HgMusicPlayerManager.shared.shuffleAndRepeatState] withKey:@"SHFFLEANDREPEATSTATE"];//存储路径
}

#pragma - mark 歌曲列表
-(void) songListButtonAction {
    
}

#pragma - mark 进度条改变值时触发
//拖动进度条改变值时触发
-(void) playbackSliderValueChanged {
    // 更新播放时间
    [self updateTime];
    
    //如果当前时暂停状态，则自动播放
    if (HgMusicPlayerManager.shared.play.rate == 0) {
        
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView resumeRotate];
        [HgMusicPlayerManager.shared startPlay];
    }
}

#pragma - mark 进度条改变值结束时触发
-(void) playbackSliderValueChangedFinish {
    
    // 更新播放时间
    [self updateTime];
    
    //如果当前时暂停状态，则自动播放
    if (HgMusicPlayerManager.shared.play.rate == 0) {
        
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView resumeRotate];
        [HgMusicPlayerManager.shared startPlay];
    }
}

#pragma mark - 状态恢复
-(void) playStateRecover {
    
    [_midView.midIconView.imageView startRotating];
    
    if (HgMusicPlayerManager.shared.play.rate == 1) {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"暂停（高亮）"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView resumeRotate];
        
    } else {
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_bottomView.playOrPauseButton setImage:[UIImage imageNamed:@"播放（高亮）"] forState:UIControlStateHighlighted];
        [_midView.midIconView.imageView stopRotating];
    }
    
}

#pragma - mark 更新播放时间
-(void) updateTime {
    
    CMTime duration = HgMusicPlayerManager.shared.play.currentItem.asset.duration;
    
    // 歌曲总时间和当前时间
    Float64 completeTime = CMTimeGetSeconds(duration);
    Float64 currentTime = (Float64)(_bottomView.songSlider.value) * completeTime;
    
    //播放器定位到对应的位置
    CMTime targetTime = CMTimeMake((int64_t)(currentTime), 1);
    [HgMusicPlayerManager.shared.play seekToTime:targetTime];
    
    int index = 0;
    for (NSString *indexStr in HgSongInfo.shared.mTimeArray) {
        if ((int)currentTime < [HgSongInfo.shared stringToInt:indexStr]) {
            HgSongInfo.shared.lrcIndex = index;
        } else {
            index = index + 1;
        }
    }
}

#pragma - mark 获取随机数 用于随机播放
-(NSUInteger) getRandomNumber:(NSUInteger)from with:(NSUInteger)to//包括两边边界
{
    NSUInteger res =  from + (arc4random() % (to - from + 1));
    return res;
}

@end
