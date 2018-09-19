//
//  Macros.h
//  News
//
//  Created by CZG on 18/2/28.
//  Copyright © 2018年 xbull. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

// 主题颜色
#define Theme_Color [UIColor colorWithHex:@"236EF5"]

//NSLog
#ifdef DEBUG
//#define NSLog(...) NSLog(@"%s 第%d行: %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%d\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
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
#define iphoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(\
CGSizeEqualToSize(CGSizeMake(375, 812),[UIScreen mainScreen].bounds.size)\
||\
CGSizeEqualToSize(CGSizeMake(414, 896),[UIScreen mainScreen].bounds.size)\
)\
:\
NO)

//导航栏的高度
#define NaviBarHeight  (iphoneX ? 88 : 64 )
//状态栏 的高度
#define kTopMargin (iphoneX ? 24 : 0)
#define kBottomMargin (iphoneX ? 34 : 0)

// 声明一个单例
#define Create_Singleton_Def() + (instancetype)shared

// 实现一个单例
#define Create_Singleton_Imp(cls) \
+ (instancetype)shared \
{ \
static cls *_gs_cls = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
if (!_gs_cls) { \
_gs_cls = [cls new]; \
} \
}); \
return _gs_cls; \
} \

// Music const
#define NEW_SONG_LIST           1
#define HOT_SONG_LIST           2
#define OLD_SONG_LIST           22
#define LOVE_SONG_LIST          23
#define INTERNET_SONG_LIST      25
#define MOVIE_SONG_LIST         24
#define EUROPE_SONG_LIST        21
#define BILLBOARD_MUSIC_LIST    8
#define ROCK_MUSIC_LIST         11
#define JAZZ_MUSIC_LIST         12
#define POP_MUSIC_LIST          16

#endif /* Macros_h */
