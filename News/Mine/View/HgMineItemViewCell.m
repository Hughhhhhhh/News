//
//  HgMineItemViewCell.m
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMineItemViewCell.h"

@implementation HgMineItemViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSBundle *bundle = [NSBundle mainBundle];
    HgMineItemViewCell *cell = [[bundle loadNibNamed:@"HgMineItemViewCell" owner:nil options:nil] lastObject];
    
    return cell;
}

- (void)setItem:(HgItemModel *)item{
    _item = item;
    // 赋值
    [self setDate];
}

// 设置数据
- (void)setDate{
    self.icon.image = [UIImage imageNamed:self.item.icon];
    self.name.text = self.item.name;
    self.name.textColor = [UIColor blackColor];
}


@end
