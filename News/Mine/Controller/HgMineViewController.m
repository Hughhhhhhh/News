//
//  HgMineViewController.m
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMineViewController.h"
#import "HgMineItemViewCell.h"
#import "HgItemModel.h"
#import "HgHeadOfMineView.h"
#import "HgMineInfoViewController.h"
#import "HgMineArticleViewController.h"
#import "HgSettingViewController.h"
#import "News-Swift.h"

#define HeadViewHeight 183

@interface HgMineViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIView *view_bar;
}
@property (nonatomic,strong) HgHeadOfMineView *headView;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) UILabel * pageTitle;

@end

@implementation HgMineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setItems];
    [self setInfo];
    [self.tableview reloadData];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (scrollView == self.tableview) {
        if(yOffset< -(HeadViewHeight+20))
        {
            CGRect frame= self.headView.frame;
            frame.origin.y=yOffset;
            frame.size.height=-yOffset;
            frame.origin.x = (yOffset* SCREENW/183+SCREENW)/2;
            frame.size.width = -yOffset*SCREENW/183;
            self.headView.frame=frame;
            
        }else if(yOffset<-NaviBarHeight){
            [view_bar setHidden:NO];
            
            self.pageTitle.hidden = NO;
            
            self.pageTitle.textColor = RGBA(255, 255, 255, (HeadViewHeight+yOffset)/ 100);
            
            view_bar.backgroundColor=RGBA(41,121,246,(HeadViewHeight+yOffset)/ 100);
        }else
        {
            [view_bar setHidden:NO];
            
            self.pageTitle.hidden = NO;
            
            view_bar.backgroundColor=RGBA(41,121,246,1);
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSArray new];
    
    self.tableview.delegate = self;
    
    self.tableview.dataSource = self;
    
    [self.tableview addSubview:self.headView];
    
    self.tableview.contentInset = UIEdgeInsetsMake(HeadViewHeight, 0, 0, 0);
    
    self.tableview.showsVerticalScrollIndicator = NO;
    
    [self NavigationBa];
}

-(UIView*)NavigationBa
{
    view_bar =[[UIView alloc]init];
    
    view_bar.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview: view_bar];
    
    [view_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(NaviBarHeight);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton * meBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [meBtn setBackgroundImage:[UIImage imageNamed:@"ic_edit"] forState:UIControlStateNormal];
    
    [meBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    [view_bar addSubview:meBtn];
    
    [meBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-11);
    }];
    
    self.pageTitle = [[UILabel alloc]init];
    
    self.pageTitle.text = @"我";
    
    self.pageTitle.hidden = YES;
    
    self.pageTitle.textColor = [UIColor clearColor];
    
    [view_bar addSubview:self.pageTitle];
    
    [self.pageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(meBtn);
        make.centerX.equalTo(view_bar);
    }];
    
    return view_bar;
}

-(void)click{
    HgMineInfoViewController * vc = [[HgMineInfoViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *rows = self.dataArray[section];
    return rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HgMineItemViewCell *cell = [HgMineItemViewCell cellWithTableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *rows = self.dataArray[indexPath.section];
    
    HgItemModel *item = rows[indexPath.row];
    
    cell.item = item;
    
    return cell;
}

-(void) setItems{
    HgItemModel *item0 = [HgItemModel itemWithname:@"我的文章" withIcon:@"ic_article" withrView:@"ic_more" withDestination:[HgMineArticleViewController class]];
    
    HgItemModel *item1 = [HgItemModel itemWithname:@"我的收藏" withIcon:@"ic_collection" withrView:@"ic_more" withDestination:[HgMineArticleViewController class]];
    
    HgItemModel *item2 = [HgItemModel itemWithname:@"我的设置" withIcon:@"ic_setting" withrView:@"ic_more" withDestination:[HgSettingViewController class]];
    
    self.dataArray = @[@[item0,item1],
                       @[item2]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *rows = self.dataArray[indexPath.section];
//    HgItemModel *item = rows[indexPath.row];
//    if (item.destination) {
//        UIViewController *vc = [[item.destination alloc] init];
//        vc.navigationItem.title = item.name;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    HgViewController * vc = [[HgViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) setInfo{
    self.headView.name.text = (NSString *)[NSObject readObjforKey:@"nickname"];
    NSString *headImg = (NSString *)[NSObject readObjforKey:@"avatar"];
    NSURL *url = [NSURL URLWithString:headImg];
    [self.headView.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
}

- (HgHeadOfMineView *)headView{
    if (_headView == nil) {
        _headView = [HgHeadOfMineView headOfMineViewWithNib];
        _headView.frame = CGRectMake(0, -HeadViewHeight, [UIScreen mainScreen].bounds.size.width, HeadViewHeight);
        _headView.backgroundColor = RGBA(41,121,246,1);
        _headView.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _headView;
}

@end
