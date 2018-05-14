//
//  HgMineItemViewCell.h
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HgItemModel.h"

@interface HgMineItemViewCell : UITableViewCell
// 数据源属性

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)HgItemModel *item;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
