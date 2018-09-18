//
//  HgMusicCell.h
//  News
//
//  Created by admin on 2018/9/12.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HgMusicInfoModel;
@interface HgMusicCell : UITableViewCell

@property (strong , nonatomic) HgMusicInfoModel * model;

+(instancetype) initMusicViewCellWithTableView:(UITableView *)tableView;

@end
