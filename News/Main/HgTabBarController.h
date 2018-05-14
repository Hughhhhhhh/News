//
//  HgTabBarController.h
//  网易新闻
//
//  Created by CZG on 18/1/26.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HgTabBarController : UITabBarController

- (void)addParentController:(UIViewController *)viewController;

-(void)removeParent;
@end
