//
//  HgHeadlinesViewController.m
//  News
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgHeadlinesViewController.h"
#import "HgNewsViewController.h"
#import "ZJScrollPageView.h"

@interface HgHeadlinesViewController ()<ZJScrollPageViewDelegate>

@property (nonatomic , strong) NSArray * titles;

@end

@implementation HgHeadlinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)creatUI{
    self.view.backgroundColor=[UIColor whiteColor];
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    style.showLine = YES;
    style.scrollLineColor=Theme_Color;
    style.scrollLineHeight=2;
    style.normalTitleColor=RGBA(100, 100, 100, 1);
    style.selectedTitleColor=Theme_Color;
    style.scrollTitle = NO;
    style.gradualChangeTitleColor = YES;
    style.titleFont=[UIFont boldSystemFontOfSize:15];
    
    self.titles  = @[@"新闻",@"新闻",@"新闻"];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:scrollPageView];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        HgNewsViewController *VC = [[HgNewsViewController alloc] init];
        childVc=VC;
    }
    
    return childVc;
}

@end
