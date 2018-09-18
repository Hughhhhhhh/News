//
//  HgMusicMidView.m
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMusicMidView.h"

@implementation HgMusicMidView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.delegate = self;
    
    self.showsHorizontalScrollIndicator = false;
    
    self.pagingEnabled = true;
    
    self.contentSize = CGSizeMake(SCREENW * 2, 0);
    
    // 专辑图片视图配置
    _midIconView = [[HgIconView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, frame.size.height)];
    [self addSubview:_midIconView];
    
    // 歌词视图配置
    _midLrcView = [[HgLrcTableView alloc] initWithStyle:UITableViewStylePlain];
    [_midLrcView SetUpLrcTableViewFrame:CGRectMake(SCREENW, 0, frame.size.width, frame.size.height)];
    _midLrcView.tableView.allowsSelection = false;
    _midLrcView.tableView.backgroundColor = [UIColor clearColor];
    _midLrcView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _midLrcView.tableView.showsVerticalScrollIndicator = false;
    _midLrcView.tableView.contentInset = UIEdgeInsetsMake(frame.size.height / 2, 0, frame.size.height / 2, 0);
    [self addSubview:_midLrcView.view];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

-(void) scrollViewDidScroll: (UIScrollView *)scrollView {
    
    double spread = self.contentOffset.x / SCREENW;
    
    _midIconView.alpha =  1.0 - spread;
    
    _midLrcView.tableView.alpha = spread;
    
}

@end
