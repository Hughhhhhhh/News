//
//  AppDelegate.m
//  News
//
//  Created by CZG on 18/2/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <notify.h>
#import "HgRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [NSThread sleepForTimeInterval:3.0];//设置启动延长时间
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[HgRootViewController alloc] init];
    [self.window makeKeyAndVisible];

    [NSObject makeHgLaunchImageAdView:^(HgLaunchImageAdView *imgAdView) {
        
        //设置广告的类型
        imgAdView.getHgLaunchImageAdViewType(LogoAdType);
        
        //设置本地启动图片
        //imgAdView.localAdImgName = @"";
        imgAdView.imgUrl = @"http://img.zcool.cn/community/01316b5854df84a8012060c8033d89.gif";
        //自定义跳过按钮
        imgAdView.skipBtn.backgroundColor = [UIColor colorWithDisplayP3Red:0 green:0 blue:0 alpha:0.3];
        imgAdView.adTime = 3;
        imgAdView.isSkipBtn = YES;
        //各种点击事件的回调
        imgAdView.clickBlock = ^(ClickType type){
            switch (type) {
                case clickAdType:
                    NSLog(@"点击广告回调");
                    break;
                case skipAdType:
                    NSLog(@"点击跳过回调");
                    break;
                case overtimeAdType:
                    NSLog(@"倒计时完成后的回调");
                    break;
                default:
                    break;
            }
        };
        
    }];
    
    // 后台播放音频设置,需要在Capabilities->Background Modes中勾选Audio,Airplay,and Picture in Picture
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 设置接受远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
