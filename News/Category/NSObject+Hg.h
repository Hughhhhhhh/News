//
//  NSObject+Hg.h
//  网易新闻
//
//  Created by CZG on 18/1/30.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HgLaunchImageAdView.h"

@interface NSObject (Hg)

//存取删NSUserDefaults内数据
+ (void)saveObj:(NSObject *)obj withKey:(NSString *)key;
+ (NSObject *)readObjforKey:(NSString *)key;
+ (void)removeObjforKey:(NSString *)key;

+(BOOL)isLogin;

+ (void)makeHgLaunchImageAdView:(void(^)(HgLaunchImageAdView *))block;

@end
