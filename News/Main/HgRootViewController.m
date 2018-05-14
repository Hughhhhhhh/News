//
//  HgRootViewController.m
//  网易新闻
//
//  Created by CZG on 18/1/30.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgRootViewController.h"
#import "HgTabBarController.h"
#import "HgNavigationController.h"
#import "HgLoginViewController.h"
#import "NSObject+Hg.h"

@interface HgRootViewController ()
{
HgTabBarController * tabBarVc;
HgNavigationController * login_nav;
}
@end

@implementation HgRootViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([NSObject isLogin]) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }else{
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self entry];
}

- (void) entry{
    
    if ([NSObject isLogin]) {
        
        [self enterMainView];
        
    }
    else
    {
        [self enterLoginView];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterLoginViewAction) name: @"enterLoginView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterMainViewAction) name: @"enterMainView" object:nil];

}

-(void)enterLoginView
{
    
    
    HgLoginViewController * loginVc = [[HgLoginViewController alloc]init];
    
    loginVc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    login_nav = [[HgNavigationController alloc]initWithRootViewController:loginVc];
    
    [[login_nav navigationBar]setTranslucent:NO];
    
    [login_nav addParentController:self];;
    
}

-(void)enterMainView
{
    tabBarVc = [[HgTabBarController alloc]init];
    tabBarVc.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [tabBarVc addParentController:self];
    
}

- (void) enterLoginViewAction{
    [self removeMainView];
    [self enterLoginView];
    
}

- (void) enterMainViewAction{
    [self removeLoginView];
    [self enterMainView];
}

-(void)removeLoginView
{
    [login_nav removeParent];
}

-(void)removeMainView
{
    [tabBarVc removeParent];
}


@end
