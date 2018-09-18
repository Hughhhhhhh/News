//
//  HgMusicRequest.h
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseNetwork.h"

@interface HgMusicRequest : HgBaseNetwork


+(void)getMusicListWithType:(uint8_t)type WithOffset:(NSInteger)offset block:(void (^)(id responseData))complete;

+(void)getMusicSelectedSongWithSongID:(NSString *)songID block:(void (^)(id responseData))complete;

@end
