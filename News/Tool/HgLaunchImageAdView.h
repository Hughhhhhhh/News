//
//  HgLaunchImageAdView.h
//  News
//
//  Created by CZG on 18/5/7.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

//广告类型
typedef NS_ENUM(NSInteger, AdType){
    FullScreenAdType,//全屏广告
    LogoAdType//带logo广告
};

//点击类型
typedef NS_ENUM(NSInteger, ClickType){
    skipAdType,//点击跳过
    clickAdType,//点击广告
    overtimeAdType//倒计时完成跳过
};

@interface HgLaunchImageAdView : UIView

typedef void (^HgClickType) (const ClickType);

@property (nonatomic, strong) UIImageView *aDImgView;
//倒计时总时长,默认6秒
@property (nonatomic, assign) NSInteger adTime;
//跳过按钮 可自定义
@property (nonatomic, strong) UIButton *skipBtn;
//本地图片名字
@property (nonatomic, copy) NSString *localAdImgName;
//网络图片URL
@property (nonatomic, copy) NSString *imgUrl;
//是否添加跳过按钮
@property (nonatomic, assign) BOOL isSkipBtn;

@property (nonatomic, copy)HgClickType clickBlock;
//广告类型
-(void(^)(AdType const adType))getHgLaunchImageAdViewType;

@end
