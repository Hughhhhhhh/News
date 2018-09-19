//
//  HgBaseNetwork.h
//  News
//
//  Created by CZG on 18/3/6.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HgBaseNetwork : NSObject

+ (AFHTTPSessionManager *)sharedManager;

+ (void)getURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete;

+ (void)getNotMainURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete;

+ (void)getMusicURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete;

+ (void)postURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete;


+ (NSString *)resultMessage:(id)responseObject;
+ (id)resultData:(id)responseObject;
+ (NSString *)resultCode:(id)responseObject;
+ (id)resultAllData:(id)responseObject;

@end
