//
//  HgMineInfoViewCell.m
//  网易新闻
//
//  Created by CZG on 18/2/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMineInfoViewCell.h"

@implementation HgMineInfoViewCell

+ (instancetype)informationCell{
    NSBundle *bundle = [NSBundle mainBundle];
    HgMineInfoViewCell *cell = [[bundle loadNibNamed:@"HgMineInfoViewCell1" owner:nil options:nil] lastObject];
    
    return cell;
}

+ (instancetype)informationCell2{
    NSBundle *bundle = [NSBundle mainBundle];
    HgMineInfoViewCell *cell = [[bundle loadNibNamed:@"HgMineInfoViewCell2" owner:nil options:nil] lastObject];
    
    return cell;
}

+ (instancetype)informationCell3{
    NSBundle *bundle = [NSBundle mainBundle];
    HgMineInfoViewCell *cell = [[bundle loadNibNamed:@"HgMineInfoViewCell3" owner:nil options:nil] lastObject];
    
    return cell;
}

@end
