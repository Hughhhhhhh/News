//
//  HgMineRequest.h
//  News
//
//  Created by CZG on 18/5/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseNetwork.h"

@interface HgMineRequest : HgBaseNetwork

/**
 *修改昵称
 *
 */
+(void)userWithNickname:(NSString *)nickname block:(void (^)(NSString* msg,id responseData))complete;

@end
