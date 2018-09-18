//
//  HgMusicDetailViewController.h
//  News
//
//  Created by admin on 2018/9/13.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseViewController.h"
#import "HgMusicPlayerManager.h"
#import "HgSongInfo.h"
#import "HgMusicTopView.h"
#import "HgMusicMidView.h"
#import "HgMusicBottomView.h"

@interface HgMusicDetailViewController : HgBaseViewController

@property(nonatomic, strong) HgMusicTopView *topView;
@property(nonatomic, strong) HgMusicMidView *midView;
@property(nonatomic, strong) HgMusicBottomView *bottomView;
@property(nonatomic, strong) UIImageView *backgroundImageView;

-(void) setBackgroundImage: (UIImage *)image;
-(void) playStateRecover ;
-(void)refreshBgImage:(NSString *)image;

@end
