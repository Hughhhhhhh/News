//
//  HgNewsViewCell.h
//  News
//
//  Created by CZG on 18/2/9.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol clickNameDelegate <NSObject>

-(void) clickName;

@end

@class HgNews;
@interface HgNewsViewCell : UITableViewCell

@property (nonatomic, strong) HgNews * news;
@property (nonatomic,weak)id<clickNameDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
