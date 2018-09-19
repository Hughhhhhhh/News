//
//  HgIconView.m
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgIconView.h"

@implementation HgIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void) setAlbumImage: (NSString *)image {
    _imageView = [[HgImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.1, self.frame.size.height / 2 - self.frame.size.width * 0.4 , self.frame.size.width * 0.8, self.frame.size.width * 0.8)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
    _imageView.clipsToBounds = true;
    _imageView.layer.cornerRadius = self.frame.size.width * 0.4;
    [self addSubview:_imageView];
}

@end
