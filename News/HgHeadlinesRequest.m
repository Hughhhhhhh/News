//
//  HgHeadlinesRequest.m
//  News
//
//  Created by CZG on 18/5/8.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgHeadlinesRequest.h"

@implementation HgHeadlinesRequest

+(void)getCategoryTitles :(void (^)(NSString* msg,id responseData))complete
{
    NSDictionary *rootPram=@{@"version_code":TTVersion_Code,@"app_name":@"news_article",@"vid":TTVid,@"device_id":TTDriveID,@"channel":@"pp",@"openudid":TTOpenudid,@"idfv":TTIdfv};
    
    [self getURL:TTCategoryTitlesURL parameters:rootPram completionHandler:^(id responseObject) {
        
        if(complete){
            complete([self resultMessage:responseObject],[self resultData:responseObject]);
            NSLog(@"%@",responseObject);
        }
    }];
}

@end
