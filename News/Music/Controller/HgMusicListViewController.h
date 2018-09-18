//
//  HgMusicListViewController.h
//  News
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseViewController.h"
#import "ZJScrollPageViewDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import <notify.h>
#import "HgMusicDetailViewController.h"

@interface HgMusicListViewController : HgBaseViewController<ZJScrollPageViewChildVcDelegate>

@property (copy , nonatomic) NSString *channelTitle;

@property (nonatomic, strong) HgMusicDetailViewController *detailController;

@end
