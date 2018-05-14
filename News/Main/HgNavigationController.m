//
//  HgNavigationController.m
//  网易新闻
//
//  Created by CZG on 18/1/26.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgNavigationController.h"

@interface HgNavigationController ()

@end

@implementation HgNavigationController

#pragma mark - load初始化一次
+ (void)load
{
    [self setUpBase];
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
}

#pragma mark - <初始化>
+ (void)setUpBase
{
    UINavigationBar *bar = [UINavigationBar appearance];
    UIColor *Color1= RGBA(41,121,246,1);
    bar.barTintColor = Color1;
    [bar setShadowImage:[UIImage new]];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = [UIColor whiteColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    bar.titleTextAttributes = attributes;
}

#pragma mark - <返回>
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        //        if (@available(ios 11.0,*)) {
        //            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
        //            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        //        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark - 导航栏上状态栏为白色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}



/**
 如果单单只是想控制所有界面上方的BarStyle可以打开上面的代码打开这行代码并且在那个界面重写上面的代码
 
 @return UIViewController
 */
- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    
}

-(void)removeParent
{
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

@end
