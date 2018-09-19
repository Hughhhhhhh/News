//
//  HgNews.m
//  News
//
//  Created by CZG on 18/2/8.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgNews.h"
#import "HgHeadlinesRequest.h"

@implementation HgNews

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
//        self.icon = dict[@"image"];
//        self.title = dict[@"title"];
//        self.desc = dict[@"desc"];
    }
    return self;
}

+ (void)requestData:(NSString *)num success:(void (^)(NSArray *group))success{
    
    [HgHeadlinesRequest getNewsListWithPage:num block:^(NSString *msg, id responseData) {
        if ([msg isEqualToString:@"0"]) {
            NSMutableArray *arrayM = [NSMutableArray array];
            
            NSArray *included = responseData[@"data"];
            
            NSString * total_count = responseData[@"total_count"];
            
            [NSObject saveObj:total_count withKey:@"total_count"];
            
            for (NSDictionary *dict in included){
                HgNews * model = [[HgNews alloc] initWithDict:dict];
                [arrayM addObject:model];
            }
            success(arrayM.copy);
        }
    }];
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
