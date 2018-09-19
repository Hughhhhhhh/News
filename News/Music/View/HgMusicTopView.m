//
//  HgMusicTopView.m
//  News
//
//  Created by admin on 2018/9/13.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicTopView.h"

@implementation HgMusicTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.backBtn];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(30);
            make.width.height.mas_equalTo(40);
        }];
        [self.backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"返回（高亮）"] forState:UIControlStateHighlighted];
        
        self.songTitleLabel = [TXScrollLabelView scrollWithTitle:nil type:TXScrollLabelViewTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut];
        [self addSubview:self.songTitleLabel];
        [self.songTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backBtn.mas_right).offset(5);
            make.height.mas_equalTo(frame.size.height/2);
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-50);
        }];
        self.songTitleLabel.scrollSpace = 10;
        self.songTitleLabel.font = [UIFont systemFontOfSize:20.0];
        self.songTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.songTitleLabel.backgroundColor = [UIColor clearColor];
        self.songTitleLabel.scrollTitleColor = [UIColor whiteColor];
        self.songTitleLabel.scrollVelocity = 5.0;
        
        self.singerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height / 2 - 15, frame.size.width - 20, frame.size.height / 2 - 30)];
        [self.singerNameLabel setFont:[UIFont systemFontOfSize:15.0]];
        [self.singerNameLabel setTextColor:[UIColor whiteColor]];
        [self.singerNameLabel setText:@""];
        self.singerNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: self.singerNameLabel];
    }
    return self;
}

@end
