//
//  HgAlertSheetView.m
//  News
//
//  Created by CZG on 18/5/10.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgAlertSheetView.h"

#define ButtonHeight 80
#define AlertSheetViewHeight 160

@implementation HgAlertSheetView{
    UIView     * backgroundView;
    UIView     * alertSheetView;
    NSArray    * nameArray;
    NSArray    * imgArray;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = SCREENbounds;
        nameArray = @[@"相册",@"拍照",@"提问"];
        imgArray = @[@"相册",@"拍照",@"提问"];
    }
    return self;
}

-(instancetype)initWithSelecetButtonBlock:(HgAlertSheetViewSelecetButtonBlock)block{
    self = [self init];
    if (self) {
        _selectIndexBlock = block;
        
        backgroundView = [[UIView alloc] initWithFrame:self.frame];
        backgroundView.backgroundColor = RGBA(0, 0, 0, 0.5);
        backgroundView.alpha = 0.0f;
        [self addSubview:backgroundView];
        
        alertSheetView = [[UIView alloc] init];
        [self addSubview:alertSheetView];
        [alertSheetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-8);
            make.height.mas_equalTo(AlertSheetViewHeight);
            make.top.mas_equalTo(SCREENH-AlertSheetViewHeight-8-kBottomMargin);
        }];
        alertSheetView.backgroundColor = RGBA(255, 255, 255, 1);
        
        NSInteger count=nameArray.count;
        CGFloat padding=(SCREENW-16-ButtonHeight*count)/(count+1);
        for (int i = 0; i < count; i ++) {
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(padding+i*(ButtonHeight+padding), 20, ButtonHeight, ButtonHeight)];
            [alertSheetView addSubview:button];
            button.tag = i;
            [button setImage:[UIImage imageNamed:[imgArray objectAtIndex:i]] forState:0];
            [button addTarget:self action:@selector(didSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            button.adjustsImageWhenHighlighted = NO;
            [button setTitle:[nameArray objectAtIndex:i] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [button setTitleColor:RGBA(10, 10, 10, 0.5) forState:UIControlStateNormal];
            [button.imageView setContentMode:UIViewContentModeScaleAspectFill];
            
            [self setButtonContentCenter:button];
        }
        
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [cancelBtn setTitleColor:RGBA(10, 10, 10, 0.5) forState:UIControlStateNormal];
        
        [cancelBtn setBackgroundColor:RGBA(237, 237, 237, 1)];
        
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [alertSheetView addSubview:cancelBtn];
        
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(alertSheetView);
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
        [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        alertSheetView.layer.cornerRadius = 10;
        alertSheetView.layer.masksToBounds = YES;
    }
    
    return self;
}

-(void)didSelectAction:(UIButton *)button{
    NSLog(@"%zd",button.tag);
    if (self.selectIndexBlock){
        NSInteger index = button.tag;
        self.selectIndexBlock(index);
    }
    [self dismiss];
}

#pragma mark 按钮图片文字垂直居中排列
-(void)setButtonContentCenter:(UIButton *)button
{
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    CGFloat heightSpace = 10.0f;
    
    //设置按钮内边距
    imgViewSize = button.imageView.bounds.size;
    titleSize = button.titleLabel.bounds.size;
    btnSize = button.bounds.size;
    
    imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
    [button setImageEdgeInsets:imageViewEdge];
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    [button setTitleEdgeInsets:titleEdge];
}

- (void)show {

    [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        backgroundView.alpha = 1.0;
//        alertSheetView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-AlertSheetViewHeight, CGRectGetWidth(self.frame), AlertSheetViewHeight);
    } completion:NULL];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:backgroundView];
    if (!CGRectContainsPoint([alertSheetView frame], point)) {
        [self dismiss];
    }
}

-(void)dismiss{
    [UIView animateWithDuration:0.35f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        backgroundView.alpha = 0.0;
        alertSheetView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), AlertSheetViewHeight);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
 动画
 [UIView animateWithDuration: delay: options: animations: completion:^(BOOL finished) {}]
 UIViewAnimationOptionLayoutSubviews            //提交动画的时候布局子控件，表示子控件将和父控件一同动画。
 
 UIViewAnimationOptionAllowUserInteraction      //动画时允许用户交流，比如触摸
 
 UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
 
 UIViewAnimationOptionRepeat                    //动画无限重复
 
 UIViewAnimationOptionAutoreverse               //执行动画回路,前提是设置动画无限重复
 
 UIViewAnimationOptionOverrideInheritedDuration //忽略外层动画嵌套的执行时间
 
 UIViewAnimationOptionOverrideInheritedCurve    //忽略外层动画嵌套的时间变化曲线
 
 UIViewAnimationOptionAllowAnimatedContent      //通过改变属性和重绘实现动画效果，如果key没有提交动画将使用快照
 
 UIViewAnimationOptionShowHideTransitionViews   //用显隐的方式替代添加移除图层的动画效果
 
 UIViewAnimationOptionOverrideInheritedOptions  //忽略嵌套继承的选项
 
 //时间函数曲线相关
 
 UIViewAnimationOptionCurveEaseInOut            //时间曲线函数，缓入缓出，中间快
 
 UIViewAnimationOptionCurveEaseIn               //时间曲线函数，由慢到特别快（缓入快出）
 
 UIViewAnimationOptionCurveEaseOut              //时间曲线函数，由快到慢(快入缓出)
 
 UIViewAnimationOptionCurveLinear               //时间曲线函数，匀速
 
 //转场动画相关的
 
 UIViewAnimationOptionTransitionNone            //无转场动画
 
 UIViewAnimationOptionTransitionFlipFromLeft    //转场从左翻转
 
 UIViewAnimationOptionTransitionFlipFromRight   //转场从右翻转
 
 UIViewAnimationOptionTransitionCurlUp          //上卷转场
 
 UIViewAnimationOptionTransitionCurlDown        //下卷转场
 
 UIViewAnimationOptionTransitionCrossDissolve   //转场交叉消失
 
 UIViewAnimationOptionTransitionFlipFromTop     //转场从上翻转
 
 UIViewAnimationOptionTransitionFlipFromBottom  //转场从下翻转*/

@end
