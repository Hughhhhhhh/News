//
//  Macros.h
//  News
//
//  Created by CZG on 18/2/28.
//  Copyright © 2018年 xbull. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//NSLog
#ifdef DEBUG
//#define NSLog(...) NSLog(@"%s 第%d行: %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREENbounds [UIScreen mainScreen].bounds

// 创建一个weak变量
#define WEAKSELF __weak typeof(self) weakSelf = self;

// 创建一个strong变量
#define StrongVar(strongVar,var) __strong __typeof(var) strongVar = var

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

/*****************  屏幕适配  ******************/
#define iphoneX (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 375*812)?YES:NO)
#define iphone6p (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 414*736)?YES:NO)
#define iphone6 (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 375*667)?YES:NO)
#define iphone5 (([[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] bounds].size.width <= 320*568)?YES:NO)

//导航栏的高度
#define NaviBarHeight  SCREENH == 812 ? 88 : 64

#endif /* Macros_h */
