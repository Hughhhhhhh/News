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
 *  获取我的分类标题
 *
 *
 */
+(void)getCategoryTitles :(void (^)(NSString* msg,id responseData))complete;



@end
