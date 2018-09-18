//
//  HgMusicInfoModel.m
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicInfoModel.h"

@implementation HgMusicInfoModel

- (instancetype) initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"idNum"];
        
    }
    else
    {
        [super setValue:value forKey:key];
    }
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
