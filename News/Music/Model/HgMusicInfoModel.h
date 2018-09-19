//
//  HgMusicInfoModel.h
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HgMusicInfoModel : NSObject

@property (nonatomic,strong) NSString *pic_big;
@property (nonatomic,strong) NSString *lrclink;
@property (nonatomic,strong) NSString *pic_small;
@property (nonatomic,strong) NSString *song_id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *album_title;
@property (nonatomic,strong) NSString *file_duration;
@property (assign , nonatomic) BOOL isPlay;



- (instancetype) initWithDict:(NSDictionary *)dict;

@end
