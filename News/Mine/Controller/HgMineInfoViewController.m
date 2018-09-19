//
//  HgMineInfoViewController.m
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgMineInfoViewController.h"
#import "HgMineInfoViewCell.h"
#import "HgMineInfoNameViewController.h"

@interface HgMineInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HgMineInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的资料";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HgMineInfoViewCell * cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell1"];
            if (!cell) {
                cell = [HgMineInfoViewCell informationCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.title.text = @"我的头像";
            NSString *headImg = (NSString *)[NSObject readObjforKey:@"avatar"];
            NSURL *url = [NSURL URLWithString:headImg];
            [cell.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
            
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell2"];
            if (!cell) {
                cell = [HgMineInfoViewCell informationCell2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.title2.text = @"手机号码";
            cell.number.text = (NSString *)[NSObject readObjforKey:@"username"];
            
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell3"];
            if (!cell) {
                cell = [HgMineInfoViewCell informationCell3];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.title3.text = @"我的昵称";
            cell.label.text = (NSString *)[NSObject readObjforKey:@"nickname"];
            
        }else if(indexPath.row == 3){
            cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell3"];
            if (!cell) {
                cell = [HgMineInfoViewCell informationCell3];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.title3.text = @"我的性别";
            BOOL sex = (NSString *)[NSObject readObjforKey:@"sex"];
            NSString * SEX;
            if (sex) {
                SEX = @"男";
            }else{
                SEX = @"女";
            }
            cell.label.text = SEX;
            
        }else if(indexPath.row == 4){
            cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell3"];
            if (!cell) {
                cell = [HgMineInfoViewCell informationCell3];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.title3.text = @"个性签名";
            cell.label.text = (NSString *)[NSObject readObjforKey:@"whatisup"];
            
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 2) {
        HgMineInfoNameViewController * vc = [[HgMineInfoNameViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
