//
//  UIColor+Hg.h
//  News
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hg)

/**
 *  把十六进制的颜色字符串转换成对象
 *
 *  @param hex 颜色的十六进制,如:FF00FF
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorWithHex:(NSString *)hex;

+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

@end
