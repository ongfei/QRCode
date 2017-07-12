//
//  DFQRCodeScanManager.h
//  SinoCommunity
//
//  Created by df on 2017/7/10.
//  Copyright © 2017年 df. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class DFQRCodeScanManager;
@protocol DFQRCodeScanManagerDelegate <NSObject>

//扫描成功回调
- (void)DFQRCodeScanManager:(DFQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects;

@end

@interface DFQRCodeScanManager : NSObject

@property (nonatomic, weak) id<DFQRCodeScanManagerDelegate> delegate;


+ (instancetype)sharedManager;

- (void)setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController;

/// 开启会话对象扫描
- (void)startRunning;
/// 停止会话对象扫描
- (void)stopRunning;
/// 移除 videoPreviewLayer 对象
- (void)videoPreviewLayerRemoveFromSuperlayer;
/// 播放音效文件
- (void)palySoundName:(NSString *)name;

@end
