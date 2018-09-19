//
//  HgBaseNetwork.m
//  News
//
//  Created by CZG on 18/3/6.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseNetwork.h"

@implementation HgBaseNetwork

static AFHTTPSessionManager *manager = nil;
+ (AFHTTPSessionManager *)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer  serializer];
        manager.requestSerializer.timeoutInterval = 10.0;
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/JavaScript", @"text/json", @"text/html", nil];
    });
    return manager;
}

+ (void)getURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete {
    
    NSString *url = [HgMainURL stringByAppendingPathComponent:subURL];
    NSString *mainUrl=[NSString stringWithFormat:@"%@",url];
    [[self sharedManager] GET:mainUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (complete) {
            complete(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(complete)
            complete(nil);
    }];
}

+ (void)getNotMainURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete {
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",subURL];
    [[self sharedManager] GET:mainUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (complete) {
            complete(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(complete)
            complete(nil);
    }];
}

+ (void)getMusicURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete {
    
    NSString *url = [HgMusicMainURL stringByAppendingString:subURL];
    NSString *mainUrl=[NSString stringWithFormat:@"%@",url];
    [[self sharedManager] GET:mainUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (complete) {
            complete(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(complete)
            complete(nil);
    }];
}

+ (void)postURL:(NSString *)subURL parameters:(NSDictionary *)parameters completionHandler:(void (^)(id responseObject))complete {
    
    NSString *url = [HgMainURL stringByAppendingPathComponent:subURL];
    
//    NSString *mainUrl=[NSString stringWithFormat:@"%@/",url];

    [[self sharedManager] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (complete) {

            complete(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(complete)
            complete(nil);
        
    }];
}

+ (id)resultData:(id)responseObject{
    NSDictionary *dic = responseObject;
    
    id obj = dic[@"data"];
    if ([obj isKindOfClass:[NSNull class]]) return nil;
    
    return obj;
}

+ (id)resultAllData:(id)responseObject{
    NSDictionary *dic = responseObject;
    
    id obj = dic;
    if ([obj isKindOfClass:[NSNull class]]) return nil;
    
    return obj;
}



+ (NSString *)resultMessage:(id)responseObject{
    NSDictionary *dic = nil;
    if (![responseObject isKindOfClass:[NSDictionary class]]) return @"";
    dic = responseObject;
    
    id obj = dic[@"message"];
    if (nil == obj) return @"";
    if (![obj isKindOfClass:[NSString class]]) return @"";
    
    return (NSString *)obj;
}

+ (NSString *)resultCode:(id)responseObject{
    NSDictionary *dic = nil;
    if (![responseObject isKindOfClass:[NSDictionary class]]) return @"";
    dic = responseObject;
    
    id obj = dic[@"code"];
    if (nil == obj) return @"";
    NSString * objc = [NSString stringWithFormat:@"%@",obj];
    
    return objc;
}

@end
