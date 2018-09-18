//
//  HgMusicBottomView.m
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicBottomView.h"

@implementation HgMusicBottomView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 上一曲按键设置
        _preSongButtton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 5, frame.size.height / 2.3, frame.size.width * 0.2, frame.size.width * 0.2)];
        [_preSongButtton setImage:[UIImage imageNamed:@"上一首"] forState:UIControlStateNormal];
        [_preSongButtton setImage:[UIImage imageNamed:@"上一首（高亮）"] forState:UIControlStateHighlighted];
        [self addSubview:_preSongButtton];
        
        // 播放或暂停按键设置
        _playOrPauseButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 2 - frame.size.width * 0.1, frame.size.height / 2.3, frame.size.width * 0.2, frame.size.width * 0.2)];
        [_playOrPauseButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_playOrPauseButton setImage:[UIImage imageNamed:@"播放（高亮）"] forState:UIControlStateHighlighted];
        [self addSubview:_playOrPauseButton];
        
        // 下一曲按键设置
        _nextSongButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 5 * 4 - frame.size.width * 0.2, frame.size.height / 2.3, frame.size.width * 0.2, frame.size.width * 0.2)];
        [_nextSongButton setImage:[UIImage imageNamed:@"下一首"] forState:UIControlStateNormal];
        [_nextSongButton setImage:[UIImage imageNamed:@"下一首（高亮）"] forState:UIControlStateHighlighted];
        [self addSubview:_nextSongButton];
        
        // 播放模式按键设置
        _playModeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.size.height / 2.3, frame.size.width * 0.2, frame.size.width * 0.2)];
        [_playModeButton setImage:[UIImage imageNamed:@"随机播放"] forState:UIControlStateNormal];
        [_playModeButton setImage:[UIImage imageNamed:@"随机播放（高亮）"] forState:UIControlStateHighlighted];
        [self addSubview:_playModeButton];
        
        // 歌曲列表按键设置
        _songListButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width * 4 / 5, frame.size.height / 2.3, frame.size.width * 0.2, frame.size.width * 0.2)];
        [_songListButton setImage:[UIImage imageNamed:@"歌曲列表"] forState:UIControlStateNormal];
        [_songListButton setImage:[UIImage imageNamed:@"歌曲列表（高亮）"] forState:UIControlStateHighlighted];
        [self addSubview:_songListButton];
        
        // 播放进度条
        _songSlider = [[UISlider alloc] initWithFrame:CGRectMake(frame.size.width / 6, frame.size.height / 4, frame.size.width * 2 / 3 , frame.size.height* 0.2)];
        [_songSlider setThumbImage:[UIImage imageNamed:@"进度条按钮"] forState:UIControlStateNormal];
        [_songSlider setThumbImage:[UIImage imageNamed:@"进度条按钮（高亮）"] forState:UIControlStateHighlighted];
        _songSlider.tintColor = [UIColor whiteColor];
        [self addSubview:_songSlider];
        
        
        // 当前播放时间
        _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, frame.size.height / 4,  frame.size.width / 6 - 10, frame.size.height* 0.2)];
        [_currentTimeLabel setTextColor:[UIColor whiteColor]];
        [_currentTimeLabel setText:@"00:00"];
        [_currentTimeLabel setFont:[UIFont systemFontOfSize:15.0]];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_currentTimeLabel];
        
        // 整歌时间
        _durationTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 5 / 6 + 5, frame.size.height / 4,  frame.size.width / 6 - 10, frame.size.height* 0.2)];
        [_durationTimeLabel setTextColor:[UIColor whiteColor]];
        [_durationTimeLabel setText:@"00:00"];
        [_durationTimeLabel setFont:[UIFont systemFontOfSize:15.0]];
        _durationTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_durationTimeLabel];
    }
    return self;
}

@end
