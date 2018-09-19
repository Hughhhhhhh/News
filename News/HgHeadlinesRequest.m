//
//  HgHeadlinesRequest.m
//  News
//
//  Created by CZG on 18/5/8.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgHeadlinesRequest.h"

@implementation HgHeadlinesRequest

+(void)getNewsListWithPage:(NSString *)page block:(void (^)(NSString * msg,id responseData))complete{
    NSDictionary *parameters = @{@"page" : page};
    [self getURL:HgNewsList parameters:parameters completionHandler:^(id responseObject) {
        if (complete) {
            complete([self resultCode:responseObject],[self resultAllData:responseObject]);
        }
    }];
}

+(void)getWangYiNewsListBlock:(void (^)(id responseData))complete{
    [self getNotMainURL:@"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html" parameters:nil completionHandler:^(id responseObject) {
        if (complete) {
            complete([self resultAllData:responseObject]);
        }
    }];
}

@end
