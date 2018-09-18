//
//  HgLrcTableView.h
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HgLrcTableViewCell;
@interface HgLrcTableView : UITableViewController

@property (nonatomic, assign) HgLrcTableViewCell *currentCell;
@property (nonatomic, assign) HgLrcTableViewCell *lrcOldCell;

@property (nonatomic,assign)  NSInteger currentRow;
@property (nonatomic, assign) BOOL isDragging;

-(instancetype)initWithStyle:(UITableViewStyle)style;
-(void) SetUpLrcTableViewFrame: (CGRect)frame ;
-(void) AnalysisLRC: (NSString *)lrcStr;

@end
