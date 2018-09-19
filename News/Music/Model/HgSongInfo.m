//
//  HgSongInfo.m
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgSongInfo.h"
#import "HgMusicRequest.h"

@implementation HgSongInfo
Create_Singleton_Imp(HgSongInfo)

#pragma mark - 获取歌曲url
-(void)getSelectedSong: (NSString *)songID index: (long)index {
    WEAKSELF;
    [HgMusicRequest getMusicSelectedSongWithSongID:songID block:^(id responseData) {
        StrongVar(sself, weakSelf);
        NSDictionary * data = responseData;
        if ([data containsObject:@"bitrate"]) {
            NSDictionary * bitrate = [data objectForKey:@"bitrate"];
            sself.file_link = [bitrate objectForKey:@"file_link"];
            sself.file_size = [bitrate objectForKey:@"file_size"];
            sself.file_duration = [bitrate objectForKey:@"file_duration"];
            sself.playSongIndex = index;
        }
    }];
}

#pragma mark - 设置歌曲的所有信息
-(void) setSongInfo: (HgMusicInfoModel *)info {
    
    self.title = info.title;
    self.author = info.author;
    self.album_title = info.author;
    self.lrclink = info.lrclink;
    self.pic_small = info.pic_small;
    self.pic_big = info.pic_big;
    
    NSString * path = info.lrclink;
    if (![path isEqualToString:@""] && path != nil)
    {
        NSURL *url = [NSURL URLWithString:path];
        
        @try {
            NSData *lrcData = [NSData dataWithContentsOfURL:url];
            NSString *lrcStr = [[NSString alloc] initWithData:lrcData encoding:NSUTF8StringEncoding];
            
            if (![lrcStr isEqualToString:@""] && lrcStr != nil) {
                self.lrcString = lrcStr;
            } else {
                NSLog(@"获取歌词出错!");
                self.lrcString = @"[00:00.00]获取歌词出错!";
            }
            
        } @catch (NSException *exception) {
            NSLog(@"获取歌词出错!");
            self.lrcString = @"[00:00.00]获取歌词出错!";
        }
        
    }
    else
    {
        NSLog(@"歌词不存在！");
        self.lrcString = @"[00:00.00]歌词不存在！";
    }
}

#pragma mark - int转NSString
-(NSString *)intToString: (int)needTransformInteger {
    
    //实现00：00这种格式播放时间
    int wholeTime = needTransformInteger;
    
    int min  = wholeTime / 60;
    
    int sec = wholeTime % 60;
    
    NSString *str = [NSString stringWithFormat:@"%02d:%02d", min , sec];
    
    return str;
}

#pragma mark - NSString转int
-(int) stringToInt: (NSString *)timeString {
    
    NSArray *strTemp = [timeString componentsSeparatedByString:@":"];
    
    int time = [strTemp.firstObject intValue] * 60 + [strTemp.lastObject intValue];
    
    return time;
    
}

-(NSMutableDictionary *)mLRCDictinary{
    if (_mLRCDictinary == nil) {
        _mLRCDictinary = [[NSMutableDictionary alloc] init];
    }
    return _mLRCDictinary;
}

-(NSMutableArray *)mTimeArray{
    if (_mTimeArray == nil) {
        _mTimeArray = [[NSMutableArray alloc] init];
    }
    return _mTimeArray;
}

@end
