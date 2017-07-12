//
//  DFQRCodeManager.h
//  SinoCommunity
//
//  Created by df on 2017/7/10.
//  Copyright © 2017年 df. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DFQRCodeManager : NSObject

//生成一张普通的二维码
+ (UIImage *)generateWithDefaultQRCodeString:(NSString *)string imageSize:(CGSize)Imagesize;

/// 生成一张带有logo的二维码 logoScale 0-1DFQRCodeManager.h
+ (UIImage *)generateWithLogoQRCodeString:(NSString *)string logoImageName:(NSString *)logoName logoScaleToSuperView:(CGFloat)logoScale;

//生成一张彩色的二维码
+ (UIImage *)generateWithColorQRCodeString:(NSString *)string backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

@end
