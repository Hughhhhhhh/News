//
//  HgTabBar.h
//  网易新闻
//
//  Created by CZG on 18/1/26.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HgTabBar;

@protocol HgTabBarDelegate <UITabBarDelegate>

- (void)tabBarDidClickPlusButton:(HgTabBar *)tabBar;

@end

@interface HgTabBar : UITabBar

@property (nonatomic, strong) UIButton *centerBtn; //中间按钮

@property (nonatomic, weak) id<HgTabBarDelegate> myDelegate;

@end
