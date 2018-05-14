//
//  HgMineRequest.m
//  News
//
//  Created by CZG on 18/5/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMineRequest.h"

@implementation HgMineRequest

+(void)userWithNickname:(NSString *)nickname block:(void (^)(NSString* msg,id responseData))complete{
    NSDictionary *parameters = @{@"nickname" : nickname};
    [self postURL:HgUserNickName parameters:parameters completionHandler:^(id responseObject) {
        if(complete){
            complete([self resultCode:responseObject],[self resultData:responseObject]);
            NSLog(@"%@",responseObject);
        }
    }];
}

@end
