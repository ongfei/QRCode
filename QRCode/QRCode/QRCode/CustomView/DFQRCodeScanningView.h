//
//  DFQRCodeScanningView.h
//  SinoCommunity
//
//  Created by df on 2017/7/10.
//  Copyright © 2017年 df. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFQRCodeScanningView : UIView

@property (nonatomic, assign) BOOL pinchEnable;

/**
 *  对象方法创建DFQRCodeScanningView
 *
 *  @param frame     frame
 *  @param layer     父视图 layer
 */
- (instancetype)initWithFrame:(CGRect)frame layer:(CALayer *)layer;
/**
 *  类方法创建DFQRCodeScanningView
 *
 *  @param frame     frame
 *  @param layer     父视图 layer
 */
+ (instancetype)scanningViewWithFrame:(CGRect )frame layer:(CALayer *)layer;

/** 添加定时器 */
- (void)addTimer;
/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;

@end
