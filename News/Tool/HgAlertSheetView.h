//
//  HgAlertSheetView.h
//  News
//
//  Created by CZG on 18/5/10.
//  Copyright © 2018年 xbull. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HgAlertSheetView;

typedef void(^HgAlertSheetViewSelecetButtonBlock)(NSInteger index);

@interface HgAlertSheetView : UIView

-(instancetype)initWithSelecetButtonBlock:(HgAlertSheetViewSelecetButtonBlock)block;

@property (nonatomic, copy) HgAlertSheetViewSelecetButtonBlock selectIndexBlock;

-(void)show;

@end
