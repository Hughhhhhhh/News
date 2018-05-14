//
//  HgMineInfoViewCell.h
//  网易新闻
//
//  Created by CZG on 18/2/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HgMineInfoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *number;


+ (instancetype)informationCell;
+ (instancetype)informationCell2;
+ (instancetype)informationCell3;

@end
