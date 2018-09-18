//
//  HgIconView.h
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HgImageView.h"

@interface HgIconView : UIView

@property(nonatomic, strong) HgImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame;
-(void) setAlbumImage: (NSString *)image;

@end
