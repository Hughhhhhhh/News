//
//  NSDictionary+Hg.m
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "NSDictionary+Hg.h"

@implementation NSDictionary (Hg)

- (BOOL)containsObject:(NSString*)key
{
    if ([[self allKeys]containsObject:key]) {
        return YES;
    }
    return NO;
}

@end
