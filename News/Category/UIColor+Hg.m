//
//  UIColor+Hg.m
//  News
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import "UIColor+Hg.h"

@interface NSString (Hg)
- (NSUInteger)hexValue;
@end

@implementation NSString (Hg)
- (NSUInteger)hexValue {
    NSUInteger result = 0;
    sscanf([self UTF8String], "%lx", &result);
    return result;
}

@end

@implementation UIColor (Hg)

+ (UIColor *)colorWithHex:(NSString *)hex {
    // 移除 `#` 和 `0x`
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    } else if ([hex hasPrefix:@"0x"]) {
        hex = [hex substringFromIndex:2];
    }
    
    // 如果长度不为 3, 6, 8的字符串，则说明该色彩无效
    NSUInteger length = [hex length];
    if (length != 3 && length != 6 && length != 8) {
        return nil;
    }
    
    // 如果颜色值只有三个，则处理一下,如F3D,则变成FF33DDFF
    if (length == 3) {
        NSString *r = [hex substringWithRange:NSMakeRange(0, 1)];
        NSString *g = [hex substringWithRange:NSMakeRange(1, 1)];
        NSString *b = [hex substringWithRange:NSMakeRange(2, 1)];
        hex = [NSString stringWithFormat:@"%@%@%@%@%@%@ff",
               r, r, g, g, b, b];
    } else if (length == 6) {
        // 如果为六，则添加alpha值ff
        hex = [hex stringByAppendingString:@"ff"];
    }
    
    CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] hexValue] / 255.0f;
    CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] hexValue] / 255.0f;
    CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] hexValue] / 255.0f;
    CGFloat alpha = [[hex substringWithRange:NSMakeRange(6, 2)] hexValue] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha
{
    // 移除 `#` 和 `0x`
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    } else if ([hex hasPrefix:@"0x"]) {
        hex = [hex substringFromIndex:2];
    }
    
    // 如果长度不为 3, 6, 8的字符串，则说明该色彩无效
    NSUInteger length = [hex length];
    if (length != 3 && length != 6 && length != 8) {
        return nil;
    }
    
    CGFloat red = [[hex substringWithRange:NSMakeRange(0, 2)] hexValue] / 255.0f;
    CGFloat green = [[hex substringWithRange:NSMakeRange(2, 2)] hexValue] / 255.0f;
    CGFloat blue = [[hex substringWithRange:NSMakeRange(4, 2)] hexValue] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)hexValue {
    return [self hexValueWithAlpha:NO];
}

- (NSString *)hexValueWithAlpha:(BOOL)includeAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    
    static NSString *stringFormat = @"%02x%02x%02x";
    
    NSString *hex = nil;
    
    // Grayscale
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    }
    
    // RGB
    else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat, (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f), (NSUInteger)(components[2] * 255.0f)];
    }
    
    // Add alpha
    if (hex && includeAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx", (unsigned long)(CGColorGetAlpha(self.CGColor) * 255.0f)];
    }
    
    // Unsupported color space
    return hex;
}

@end
