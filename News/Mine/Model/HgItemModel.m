//
//  HgItemModel.m
//  网易新闻
//
//  Created by CZG on 18/2/5.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "HgItemModel.h"

@implementation HgItemModel

+ (instancetype)itemWithname:(NSString *)name withIcon:(NSString *)icon withrView:(NSString *)rView withDestination:(Class)destination{
    HgItemModel *item = [[self alloc] init];
    item.name = name;
    item.icon = icon;
    item.rView = rView;
    item.destination = destination;
    return item;
}
+ (instancetype)itemWithname:(NSString *)name withIcon:(NSString *)icon withrView:(NSString *)rView withNibStr:(NSString *)nibStr{
    HgItemModel *item = [[self alloc] init];
    item.name = name;
    item.icon = icon;
    item.rView = rView;
    item.nibStr = nibStr;
    return item;
}
+ (instancetype)itemWithname:(NSString *)name withrView:(NSString *)rView withDestination:(Class)destination{
    HgItemModel *item = [[self alloc] init];
    item.name = name;
    item.rView = rView;
    item.destination = destination;
    return item;
}
+ (instancetype)itemWithname:(NSString *)name withrView:(NSString *)rView{
    HgItemModel *item = [[self alloc] init];
    item.name = name;
    item.rView = rView;
    return item;
}

@end
