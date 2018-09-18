//
//  HgTabBarController.m
//  网易新闻
//
//  Created by CZG on 18/1/26.
//  Copyright © 2018年 xbull. All rights reserved.
//


#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"

#import "HgTabBarController.h"
#import "HgTabBar.h"
#import "HgNavigationController.h"
#import "HgHeadlinesViewController.h"
#import "HgAlertSheetView.h"
#import "HgMusicViewController.h"
#import "HgVideoViewController.h"

@interface HgTabBarController ()<UITabBarControllerDelegate,HgTabBarDelegate>

@property (nonatomic, strong) HgTabBar * HgTabBar;

@end

@implementation HgTabBarController

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setUpTabBar];
    
    [self addDcChildViewController];
    
//    self.selectedIndex = 1;
    
    self.tabBar.translucent = NO;
}

#pragma mark - 更换系统tabbar
- (void) setUpTabBar{
    self.HgTabBar = [[HgTabBar alloc] init];
    self.HgTabBar.backgroundColor = [UIColor whiteColor];
    
    self.HgTabBar.myDelegate = self;
    
    //隐藏tabbar黑线
    CGRect rect = CGRectMake(0, 0, SCREENW, SCREENH);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.HgTabBar setBackgroundImage:img];
    [self.HgTabBar setShadowImage:img];
    
    [self setValue:self.HgTabBar forKey:@"tabBar"];
}

/**
 *  点击了加号按钮
 */
- (void)tabBarDidClickPlusButton:(HgTabBar *)tabBar
{
    HgAlertSheetView * alertSheetView = [[HgAlertSheetView alloc] initWithSelecetButtonBlock:^(NSInteger index) {
        if (index == 0) {
            NSLog(@"选择相册");
        }else if (index == 1){
            NSLog(@"拍照");
        }else{
            NSLog(@"提问");
        }
    }];
    [alertSheetView show];
}
#pragma mark - 添加子控制器
- (void)addDcChildViewController{
    NSArray * childArray = @[
                             @{
                                 MallClassKey : @"HgHeadlinesViewController",
                                 MallTitleKey : @"头条",
                                 MallImgKey   : @"头条（未）",
                                 MallSelImgKey: @"头条（选中）"},
                             @{
                                 MallClassKey : @"HgVideoViewController",
                                 MallTitleKey : @"视频",
                                 MallImgKey   : @"视频 （未）",
                                 MallSelImgKey: @"视频 （选中）"},
                             @{
                                 MallClassKey : @"HgMusicViewController",
                                 MallTitleKey : @"音乐",
                                 MallImgKey   : @"音乐（未）",
                                 MallSelImgKey: @"音乐（选中）"},
                             @{
                                 MallClassKey : @"HgMineViewController",
                                 MallTitleKey : @"我",
                                 MallImgKey   : @"我的（未）",
                                 MallSelImgKey: @"我的（选中）"},
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController * vc = [NSClassFromString(dict[MallClassKey])new];
        vc.navigationItem.title = dict[MallTitleKey];
        HgNavigationController * nav = [[HgNavigationController alloc] initWithRootViewController: vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title=dict[MallTitleKey];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        // 设置导航栏字体颜色
        UIColor * naiColor = RGBA(41,121,246,1);
        attributes[NSForegroundColorAttributeName] = naiColor;
        [item setTitleTextAttributes:attributes forState:UIControlStateSelected];
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
        [self addChildViewController:nav];
    }];
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}
#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
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
