//
//  HgMusicBottomView.h
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HgMusicBottomView : UIView

@property (nonatomic, strong) UIButton *preSongButtton;
@property (nonatomic, strong) UIButton *nextSongButton;
@property (nonatomic, strong) UIButton *playOrPauseButton;
@property (nonatomic, strong) UIButton *playModeButton;
@property (nonatomic, strong) UIButton *songListButton;
@property (nonatomic, strong) UISlider *songSlider;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *durationTimeLabel;

@end
