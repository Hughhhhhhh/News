//
//  HgLrcTableView.m
//  News
//
//  Created by admin on 2018/9/14.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgLrcTableView.h"
#import "HgSongInfo.h"
#import "HgLrcTableViewCell.h"

@interface HgLrcTableView ()

@end

@implementation HgLrcTableView

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

-(void) SetUpLrcTableViewFrame: (CGRect)frame {
    self.view.frame = frame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return HgSongInfo.shared.mLRCDictinary.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HgLrcTableViewCell * cell = [HgLrcTableViewCell HgLrcCellForRowWithTableVieW:tableView];
    
    cell.textLabel.text = HgSongInfo.shared.mLRCDictinary[HgSongInfo.shared.mTimeArray[indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16.0]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_currentRow == indexPath.row) {
        cell.textLabel.textColor = [UIColor whiteColor];
    }else{
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

-(void) AnalysisLRC: (NSString *)lrcStr{
    NSString* contentStr = lrcStr;
    
    NSArray *lrcArray = [contentStr componentsSeparatedByString:@"\n"];
    
    [HgSongInfo.shared.mLRCDictinary removeAllObjects];
    [HgSongInfo.shared.mTimeArray removeAllObjects];
    
    for (NSString *line in lrcArray) {
        
        // 首先处理歌词中无用的东西
        // [ti:][ar:][al:]这类的直接跳过
        if ([line containsString:@"[0"] || [line containsString:@"[1"] || [line containsString:@"[2"] || [line containsString:@"[3"] || [line containsString:@"[4"] || [line containsString:@"[5"]) {
            NSArray *lineArr = [line componentsSeparatedByString:@"]"];
            NSString *str1 = [line substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [line substringWithRange:NSMakeRange(6, 1)];
            
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString *lrcStr = lineArr[1];
                NSString *timeStr = [lineArr[0] substringWithRange:NSMakeRange(1, 5)];
                [HgSongInfo.shared.mLRCDictinary setObject:lrcStr forKey:timeStr];
                [HgSongInfo.shared.mTimeArray addObject:timeStr];
            }
        } else {
            continue;
        }
        
    }
    if (HgSongInfo.shared.mTimeArray.count <= 0) {
        contentStr = @"[00:00.00]获取歌词出错!";
        
        NSArray *lineArr = [contentStr componentsSeparatedByString:@"]"];
        NSString *str1 = [contentStr substringWithRange:NSMakeRange(3, 1)];
        NSString *str2 = [contentStr substringWithRange:NSMakeRange(6, 1)];
        
        if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
            NSString *lrcStr = lineArr[1];
            NSString *timeStr = [lineArr[0] substringWithRange:NSMakeRange(1, 5)];
            [HgSongInfo.shared.mLRCDictinary setObject:lrcStr forKey:timeStr];
            [HgSongInfo.shared.mTimeArray addObject:timeStr];
        }
        
    }
    [self.tableView reloadData];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDragging = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isDragging = NO;
}


@end
