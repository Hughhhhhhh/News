//
//  HgSongInfo.h
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HgMusicInfoModel.h"

@interface HgSongInfo : NSObject

Create_Singleton_Def();

@property (nonatomic,strong) NSString *pic_big;
@property (nonatomic,strong) NSString *pic_small;
@property (nonatomic,strong) NSString *song_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *album_title;
@property (nonatomic,strong) NSString *file_duration;
@property (nonatomic,strong) NSString *file_link;
@property (nonatomic,strong) NSString *file_size;
@property (nonatomic,strong) NSString *lrclink;
@property (nonatomic,strong) NSString *lrcString;
@property (nonatomic,strong) NSMutableDictionary *mLRCDictinary;
@property (nonatomic,strong) NSMutableArray *mTimeArray;
@property (nonatomic,assign) int lrcIndex;
@property (nonatomic,assign) long playSongIndex;
@property (nonatomic,assign) BOOL isDataRequestFinish;
@property (nonatomic,strong) NSArray *OMSongs;

-(void)getSelectedSong: (NSString *)songID index: (long)index;
-(void) setSongInfo: (HgMusicInfoModel *)info;
-(NSString *)intToString: (int)needTransformInteger;
-(int) stringToInt: (NSString *)timeString;

@end
