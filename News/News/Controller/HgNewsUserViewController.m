//
//  HgNewsUserViewController.m
//  News
//
//  Created by CZG on 18/2/9.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgNewsUserViewController.h"
#import "HgNews.h"
#import "HgNewsViewCell.h"
#import "HgNewsUserViewController.h"

@interface HgNewsUserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, strong) NSArray * data;

@end

@implementation HgNewsUserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [HgNews requestData:@"1" success:^(NSArray *group) {
        self.groups = group;
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeadView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)setHeadView{
    UIColor *Color1= RGBA(41,121,246,1);
    self.bgView.backgroundColor = Color1;
    self.name.text = (NSString *)[NSObject readObjforKey:@"nickname"];
    NSString *headImg = (NSString *)[NSObject readObjforKey:@"avatar"];
    NSURL *url = [NSURL URLWithString:headImg];
    [self.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = self.icon.bounds.size.width * 0.5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HgNews * model = self.groups[indexPath.section];
    
    HgNewsViewCell * cell = [HgNewsViewCell cellWithTableView:tableView];
    
    cell.news = model;
    
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


@end
