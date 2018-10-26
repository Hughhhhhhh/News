//
//  HgNewsDetailViewController.m
//  News
//
//  Created by admin on 2018/9/19.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgNewsDetailViewController.h"
#import <WebKit/WebKit.h>

@interface HgNewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation HgNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详情";
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.webView.navigationDelegate = self;
    
//    //禁止webview滚动
//    UIScrollView *tempView = (UIScrollView *)[self.webView.subviews objectAtIndex:0];
//    tempView.scrollEnabled = NO;
//    self.webView.scrollView.bounces=NO;
    
    [self.view addSubview:self.webView];
    NSURL *url = [NSURL URLWithString:self.model.url_3w];
    [self createProgress];
    [self showProgress];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    [self.webView loadRequest:request];
    
    //监听UIWindow隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.webView)
        {
            if(self.webView.estimatedProgress >= 1.0f)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hideProgress];
                });
                
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(void)endFullScreen{
    NSLog(@"退出全屏");
//    [[UIApplication sharedApplication] setStatusBarHidden:false animated:false];
    [[UIApplication sharedApplication] setStatusBarHidden:false];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    }
    return _webView;
}

@end
