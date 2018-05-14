//
//  HgHeadlinesRequest.m
//  News
//
//  Created by CZG on 18/5/3.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgLoginRequest.h"

@implementation HgLoginRequest

+(void)userLoginWithUsername:(NSString *)username withPassword:(NSString *)password block:(void (^)(NSString* msg,id responseData))complete{
    NSDictionary *parameters = @{@"username" : username,
                                 @"password" : password};
    [self postURL:HgUserLogin parameters:parameters completionHandler:^(id responseObject) {
        if(complete){
            complete([self resultCode:responseObject],[self resultData:responseObject]);
            NSLog(@"%@",responseObject);
        }
    }];
}

@end
