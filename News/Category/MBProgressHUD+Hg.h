//
//  MBProgressHUD+Hg.h
//  News
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Hg)

/** 只显示菊花 **/
+ (void)showLoadHUD;

/** 显示菊花+文字 **/
+(void)showLoadHUDMsg:(NSString *)message;

/** 显示文字-->几秒钟后消失 **/
+(void)showHUDMsg:(NSString *)message;

/** 环形进度条 + 文字 **/
+(void)showCircularHUDProgress;

/** 水平进度条 + 文字 **/
+(void)showBarHUDProgress;

/** 更新progress进度 **/
+(MBProgressHUD *)getHUDProgress;

/** 自定义图片 + 文字 **/
+(void)showCustomViewHUD:(NSString *)msg imageName:(NSString *)imageName;

+(void)showCustomGifHUD:(NSString *)msg imageName:(NSString *)imageName;
//隐藏HUD
+(void)hideHUD;

@end
