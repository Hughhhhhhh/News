//
//  HgHeadOfMineView.h
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HgHeadOfMineView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

+ (instancetype)headOfMineViewWithNib;
@end
