//
//  HgLaunchImageAdView.m
//  News
//
//  Created by CZG on 18/5/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgLaunchImageAdView.h"
#import "UIImageView+WebCache.h"
#import "FLAnimatedImageView+WebCache.h"

#define IMGURL @"IMGURL"

@interface HgLaunchImageAdView()
{
    NSTimer * countDownTimer;
}
@property (strong, nonatomic) NSString *isClick;

@end

@implementation HgLaunchImageAdView

#pragma mark - 获取广告类型
- (void (^)(AdType adType))getHgLaunchImageAdViewType{
    WEAKSELF;
    return ^(AdType adType){
        [weakSelf addHgLaunchImageAdView:adType];
    };
}

#pragma mark - 点击广告
- (void)activiTap:(UITapGestureRecognizer*)recognizer{
    _isClick = @"1";
    [self startcloseAnimation];
}

#pragma mark - 开启关闭动画
- (void)startcloseAnimation{
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.5;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.3];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    [self.aDImgView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
    [NSTimer scheduledTimerWithTimeInterval:opacityAnimation.duration
                                     target:self
                                   selector:@selector(closeAddImgAnimation)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)skipBtnClick{
    _isClick = @"2";
    [self startcloseAnimation];
}

#pragma mark - 关闭动画完成时处理事件
-(void)closeAddImgAnimation
{
    [countDownTimer invalidate];
    countDownTimer = nil;
    self.hidden = YES;
    self.aDImgView.hidden = YES;
    [self removeFromSuperview];
    if ([_isClick integerValue] == 1) {
        if (self.clickBlock) {//点击广告
            self.clickBlock(clickAdType);
        }
    }else if([_isClick integerValue] == 2){
        if (self.clickBlock) {//点击跳过
            self.clickBlock(skipAdType);
        }
    }else{
        if (self.clickBlock) {
            self.clickBlock(overtimeAdType);
        }
    }
}

- (void)onTimer {
    if (_isSkipBtn) {
        [self addSubview:self.skipBtn];
    }
    if (_adTime == 0) {
        [countDownTimer invalidate];
        countDownTimer = nil;
        [self startcloseAnimation];
    }else{
        [self.skipBtn setTitle:[NSString stringWithFormat:@"跳过"] forState:UIControlStateNormal];
        _adTime--;
    }
}

#pragma mark -- 设置本地图片
- (void)setLocalAdImgName:(NSString *)localAdImgName{
    _localAdImgName = localAdImgName;
    if (_localAdImgName.length > 0) {
        if ([_localAdImgName rangeOfString:@".gif"].location  != NSNotFound ) {
            _localAdImgName  = [_localAdImgName stringByReplacingOccurrencesOfString:@".gif" withString:@""];
            NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:_localAdImgName ofType:@"gif"]];
            UIWebView *webView = [[UIWebView alloc] initWithFrame:self.aDImgView.frame];
            webView.backgroundColor = [UIColor clearColor];
            webView.scalesPageToFit = YES;
            webView.scrollView.scrollEnabled = NO;
            [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
            [webView setUserInteractionEnabled:NO];
            UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            clearBtn.frame = webView.frame;
            clearBtn.backgroundColor = [UIColor clearColor];
            [clearBtn addTarget:self action:@selector(activiTap:) forControlEvents:UIControlEventTouchUpInside];
            [webView addSubview:clearBtn];
            [self.aDImgView addSubview:webView];
            [self.aDImgView bringSubviewToFront:_skipBtn];
        }else{
            self.aDImgView.image = [UIImage imageNamed:_localAdImgName];
        }
    }
}

-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    if ([self isImgCache] == nil) {
        [_aDImgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
    }
    [NSObject saveObj:_imgUrl withKey:IMGURL];
}


- (void)addHgLaunchImageAdView:(AdType)adType{
#pragma mark - iOS开发 强制竖屏
    NSNumber * orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    //倒计时时间
    _adTime = 6;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    NSString *launchImageName = [self getLaunchImage:@"Portrait"];
    UIImage * launchImage = [UIImage imageNamed:launchImageName];
    self.backgroundColor = [UIColor colorWithPatternImage:launchImage];
    self.frame = CGRectMake(0, 0, SCREENW, SCREENH);
    if (adType == FullScreenAdType) {
        self.aDImgView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH)];
    }else{
        self.aDImgView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - SCREENH/5)];
    }
    self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipBtn.frame = CGRectMake(SCREENW - 50, 20, 40, 40);
    if (iphoneX) {
        self.skipBtn.frame = CGRectMake(SCREENW - 50, 40, 40, 40);
    }
    self.skipBtn.backgroundColor = [UIColor brownColor];
    self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.skipBtn setTitle:[NSString stringWithFormat:@"跳过"] forState:UIControlStateNormal];
    [self.skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.skipBtn.layer.cornerRadius = 20;
    self.skipBtn.layer.masksToBounds = YES;
    self.aDImgView.tag = 1101;
    [self addSubview:self.aDImgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activiTap:)];
    // 允许用户交互
    self.aDImgView.userInteractionEnabled = YES;
    [self.aDImgView addGestureRecognizer:tap];
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.8;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.8];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.aDImgView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
    if ([self isImgCache].length > 0) {
        [_aDImgView sd_setImageWithURL:[NSURL URLWithString:[self isImgCache]] placeholderImage:[UIImage imageNamed:@"backgroundImage3"]];
    }
    
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

/*
 *viewOrientation 屏幕方向
 */
- (NSString *)getLaunchImage:(NSString *)viewOrientation{
    //获取启动图片
    CGSize viewSize = [UIApplication sharedApplication].delegate.window.bounds.size;
    //横屏请设置成 @"Landscape"|Portrait
    //    NSString *viewOrientation = @"Portrait";
    __block NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    [imagesDict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize imageSize = CGSizeFromString(obj[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:obj[@"UILaunchImageOrientation"]])
        {
            launchImageName = obj[@"UILaunchImageName"];
        }
    }];
    return launchImageName;
}

- (NSString *)isImgCache{
    NSString *imgURL = (NSString *)[NSObject readObjforKey:IMGURL];
    if (imgURL.length > 0) {
        return imgURL;
    }
    return nil;
}

@end
