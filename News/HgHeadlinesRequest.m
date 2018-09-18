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

@end
