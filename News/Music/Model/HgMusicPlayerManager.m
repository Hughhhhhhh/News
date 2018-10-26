//
//  HgMusicPlayerManager.m
//  News
//
//  Created by admin on 2018/8/22.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicPlayerManager.h"

@implementation HgMusicPlayerManager

Create_Singleton_Imp(HgMusicPlayerManager)

-(void) setPlayItem: (NSString *)songURL {
    NSURL * url  = [NSURL URLWithString:songURL];
    _playItems = [[AVPlayerItem alloc] initWithURL:url];
}

-(void) setPlay {
    _play = [[AVPlayer alloc] initWithPlayerItem:_playItems];
}

-(void) startPlay {
    [_play play];
}

-(void) stopPlay {
    [_play pause];
}

-(void) play: (NSString *)songURL {
    [self setPlayItem:songURL];
    [self setPlay];
    [self startPlay];
}

@end
