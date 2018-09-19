//
//  HgBaseViewController.m
//  News
//
//  Created by CZG on 18/5/9.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgBaseViewController.h"

@interface HgBaseViewController ()<MBProgressHUDDelegate>

// 等待框
@property (nonatomic,strong) MBProgressHUD *awaitProgress;

@end

@implementation HgBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self hideProgress];
}

#pragma mark MBProgressHUD
- (void)createProgress
{
    _awaitProgress = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    [self.view addSubview:_awaitProgress];
    [self.view bringSubviewToFront:_awaitProgress];
    _awaitProgress.delegate = self;
    _awaitProgress.mode = MBProgressHUDModeText;
    _awaitProgress.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _awaitProgress.bezelView.backgroundColor = [UIColor blackColor];
    _awaitProgress.label.textColor = [UIColor whiteColor];
    _awaitProgress.label.text = @"加载中...";
}

- (void)showProgress
{
    if (_awaitProgress) {
        [_awaitProgress showAnimated:NO];
    }
}

- (void)hideProgress
{
    
    if (_awaitProgress) {
        [_awaitProgress hideAnimated:YES];
    }
}

@end
