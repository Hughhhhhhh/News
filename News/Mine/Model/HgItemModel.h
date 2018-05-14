//
//  HgItemModel.h
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HgItemModel : NSObject

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * icon;
// >
@property (nonatomic,copy) NSString *rView;
// 目标控制器
@property (nonatomic,assign) Class destination;
// xib
@property (nonatomic,copy) NSString *nibStr;

// 初始化类方法
+ (instancetype)itemWithname:(NSString *)name withIcon:(NSString *)icon withrView:(NSString *)rView withDestination:(Class)destination;
+ (instancetype)itemWithname:(NSString *)name withIcon:(NSString *)icon withrView:(NSString *)rView withNibStr:(NSString *)nibStr;
+ (instancetype)itemWithname:(NSString *)name withrView:(NSString *)rView withDestination:(Class)destination;
+ (instancetype)itemWithname:(NSString *)name withrView:(NSString *)rView;

@end
