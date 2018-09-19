//
//  HgHeadlinesRequest.h
//  News
//
//  Created by CZG on 18/5/8.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseNetwork.h"

@interface HgHeadlinesRequest : HgBaseNetwork

/**
 * 获取新闻列表
 *
 *
 */
+(void)getNewsListWithPage:(NSString *)page block:(void (^)(NSString * msg,id responseData))complete;

+(void)getWangYiNewsListBlock:(void (^)(id responseData))complete;

@end
