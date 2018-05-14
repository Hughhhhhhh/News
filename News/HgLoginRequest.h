//
//  HgLoginRequest.h
//  News
//
//  Created by CZG on 18/5/3.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseNetwork.h"

@interface HgLoginRequest : HgBaseNetwork
/**
 *用户登录
 *
 */
+(void)userLoginWithUsername:(NSString *)username withPassword:(NSString *)password block:(void (^)(NSString* msg,id responseData))complete;

@end
