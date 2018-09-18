//
//  HgMusicPlayerManager.h
//  News
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface HgMusicPlayerManager : NSObject

typedef enum : NSUInteger {
    RepeatPlayMode,
    RepeatOnlyOnePlayMode,
    ShufflePlayMode,
} ShuffleAndRepeatState;

@property (nonatomic,strong) AVPlayer *play;
@property (nonatomic,strong) AVPlayerItem *playItems;
@property (nonatomic,assign) ShuffleAndRepeatState shuffleAndRepeatState;
@property (nonatomic,assign) NSInteger playingIndex;
//@property (nonatomic, strong) id playerTimeObserver;

Create_Singleton_Def();

-(void) setPlayItem: (NSString *)songURL;
-(void) setPlay;
-(void) startPlay;
-(void) stopPlay;
-(void) play: (NSString *)songURL;

@end
