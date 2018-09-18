//
//  HgLrcTableViewCell.m
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgLrcTableViewCell.h"
#import "HgSongInfo.h"

extern HgSongInfo *songInfo;

@implementation HgLrcTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype) HgLrcCellForRowWithTableVieW: (UITableView *) tableView{
    NSString *cellID = @"lrccellID";
    HgLrcTableViewCell *cell = (HgLrcTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[HgLrcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    return cell;
}

@end
