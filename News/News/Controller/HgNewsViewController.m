//
//  HgNewsViewController.m
//  News
//
//  Created by CZG on 18/2/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgNewsViewController.h"
#import "HgNews.h"
#import "HgNewsViewCell.h"
#import "HgNewsUserViewController.h"

@interface HgNewsViewController ()<UITableViewDelegate,UITableViewDataSource,clickNameDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, strong) NSMutableArray * data;

@property (nonatomic, strong) NSString * num;

@property (nonatomic, assign) NSInteger page;

@end

@implementation HgNewsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.data.count==0) {
        self.page = 1;
        self.num = [NSString stringWithFormat:@"%ld",self.page];
        [HgNews requestData:self.num success:^(NSArray *group) {
            self.groups = group;
            self.data = [NSMutableArray arrayWithArray:self.groups];
            [self.tableView reloadData];
        }];
        self.page ++;
        [self setupRefresh];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
    [self.tableView setSeparatorColor:[UIColor clearColor ]];
    
    self.page = 2;
    
}

- (void) setupRefresh{
    WEAKSELF;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        StrongVar(strongSelf, weakSelf);
        if (strongSelf) {
            strongSelf.num = [NSString stringWithFormat:@"%ld",strongSelf.page];
            
            NSString * total_count = (NSString *)[NSObject readObjforKey:@"total_count"];
            
            int intString = ([total_count intValue])/10;
            
            [HgNews requestData:strongSelf.num success:^(NSArray *group) {
                strongSelf.groups = group;
                for (HgNews * model in strongSelf.groups) {
                    [strongSelf.data addObject:model];
                }
                [strongSelf.tableView reloadData];
                
                if (strongSelf.page == intString) {
                    [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [strongSelf.tableView.mj_footer endRefreshing];
                }
                strongSelf.page ++ ;
            }];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HgNews * model = self.data[indexPath.section];
    
    HgNewsViewCell * cell = [HgNewsViewCell cellWithTableView:tableView];
    
    cell.news = model;
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void) clickName{
    HgNewsUserViewController * vc = [[HgNewsUserViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
