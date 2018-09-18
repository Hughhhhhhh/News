//
//  HgMusicMidView.h
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HgIconView.h"
#import "HgLrcTableView.h"

@interface HgMusicMidView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) HgIconView* midIconView;
@property (nonatomic, strong) HgLrcTableView *midLrcView;

@end
