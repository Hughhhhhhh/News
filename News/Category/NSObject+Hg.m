//
//  NSObject+Hg.m
//  网易新闻
//
//  Created by CZG on 18/1/30.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "NSObject+Hg.h"

@implementation NSObject (Hg)

+ (void)saveObj:(NSObject *)obj withKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults]setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (NSObject *)readObjforKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

+ (void)removeObjforKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


+(BOOL)isLogin
{
    NSString * islogin = (NSString *)[self readObjforKey:@"isLogin"];
    
    if ([islogin isEqualToString:@"1"]) {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (void)makeHgLaunchImageAdView:(void(^)(HgLaunchImageAdView *))block{
    
    HgLaunchImageAdView *imgAdView = [[HgLaunchImageAdView alloc]init];
    block(imgAdView);
}

@end
