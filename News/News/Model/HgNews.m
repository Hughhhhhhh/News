//
//  HgNews.m
//  News
//
//  Created by CZG on 18/2/8.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgNews.h"

@implementation HgNews

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.icon = dict[@"image"];
        self.title = dict[@"title"];
        self.desc = dict[@"desc"];
    }
    return self;
}

+ (void)requestData:(NSString *)num success:(void (^)(NSArray *group))success{
    
    NSDictionary *parameters = @{@"page" : num};
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"application/json"];
    
    manager.requestSerializer.timeoutInterval=5.0f;
    
    [manager GET:@"http://interview.jbangit.com/news" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        NSArray *included = responseObject[@"data"];
        
        NSString * total_count = responseObject[@"total_count"];
        
        [NSObject saveObj:total_count withKey:@"total_count"];
        
        for (NSDictionary *dict in included){
            HgNews * model = [[HgNews alloc] initWithDict:dict];
            [arrayM addObject:model];
        }
        success(arrayM.copy);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
}

@end
