//
//  HgMusicRequest.m
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicRequest.h"

@implementation HgMusicRequest

+(void)getMusicListWithType:(uint8_t )type WithOffset:(NSInteger)offset block:(void (^)(id responseData))complete{
    NSString * str = [NSString stringWithFormat:@"&method=baidu.ting.billboard.billList&format=json&type=%d&offset=%lu&size=20",type,(unsigned long)offset];
    [self getMusicURL:str parameters:nil completionHandler:^(id responseObject) {
        if (complete) {
            complete([self resultAllData:responseObject]);
        }
    }];
}

+(void)getMusicSelectedSongWithSongID:(NSString *)songID block:(void (^)(id responseData))complete{
    NSString * str = [NSString stringWithFormat:@"&method=baidu.ting.song.play&songid=%@",songID];
    [self getMusicURL:str parameters:nil completionHandler:^(id responseObject) {
        if (complete) {
            complete([self resultAllData:responseObject]);
        }
    }];
}

@end
