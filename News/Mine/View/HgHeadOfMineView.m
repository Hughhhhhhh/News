//
//  HgHeadOfMineView.m
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgHeadOfMineView.h"

@implementation HgHeadOfMineView

+ (instancetype)headOfMineViewWithNib{
    NSBundle *bundle = [NSBundle mainBundle];
    HgHeadOfMineView *view = [[bundle loadNibNamed:@"HgHeadOfMineView" owner:nil options:nil] lastObject];
    return view;
}

- (void)setIcon:(UIImageView *)icon{
    _icon = icon;
    
    _icon.layer.masksToBounds = YES;
    
    _icon.layer.cornerRadius = _icon.bounds.size.width * 0.5;
}

- (void)setName:(UILabel *)name{
    _name = name;
    
    _name.font = [UIFont systemFontOfSize:16];
}

@end
