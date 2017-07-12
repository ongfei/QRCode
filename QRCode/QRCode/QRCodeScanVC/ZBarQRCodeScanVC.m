//
//  ZBarQRCodeScanVC.m
//  SinoCommunity
//
//  Created by df on 2017/7/11.
//  Copyright © 2017年 df. All rights reserved.
//

#import "ZBarQRCodeScanVC.h"

#import "DFQRCodeScanningView.h"

#import <ZBarSDK/ZBarSDK.h>

#import <AVFoundation/AVFoundation.h>

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface ZBarQRCodeScanVC ()<ZBarReaderViewDelegate>

@property (nonatomic, strong) DFQRCodeScanningView *scanningView;

@property (nonatomic, strong) ZBarReaderView *readerView;

@end

@implementation ZBarQRCodeScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫一扫";
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupZBarQRCodeScanning];
    
    [self.view addSubview:self.scanningView];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.scanningView addTimer];
    [self.readerView start];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.scanningView removeTimer];
    [self.readerView stop];
    [self.readerView flushCache];

}

- (void)setupZBarQRCodeScanning {
    
    ZBarReaderView *readerView = [[ZBarReaderView alloc] init];
    
    self.readerView = readerView;
    
    readerView.frame = self.view.bounds;
    
    readerView.readerDelegate = self;
    
    readerView.allowsPinchZoom = NO; // 不使用Pinch手势变焦
    
    readerView.torchMode = 0;//闪光灯 关
    
    readerView.trackingColor = [UIColor clearColor];//锁定图码 显示的颜色框
    
    CGRect scanMaskRect = CGRectMake(ScreenWidth * 0.15 + 1, ScreenHeight * 0.24 + 1, ScreenWidth * 0.7 - 2, ScreenWidth * 0.7 - 2);
    
    readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:readerView.frame];
    
    readerView.allowsPinchZoom = YES;
    
    [self.view addSubview:readerView];

}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)rvBounds{
    
    CGFloat x,y,width,height;
    
    x = rect.origin.y / rvBounds.size.height;
    
    y = 1 - (rect.origin.x + rect.size.width) / rvBounds.size.width;
    
    width = (rect.origin.y + rect.size.height) / rvBounds.size.height;
    
    height = 1 - rect.origin.x / rvBounds.size.width;
    
    return CGRectMake(x, y, width, height);
    
}



- (void) readerView: (ZBarReaderView*) readerView  didReadSymbols: (ZBarSymbolSet*) symbols  fromImage: (UIImage*) image
{
    
    SystemSoundID soundID = 1013;//具体参数详情下面贴出来
    //播放声音
    AudioServicesPlaySystemSound(soundID);
    
    [readerView flushCache];
    [self.readerView stop];
    [self.scanningView removeTimer];

    NSString *strCode;
    
    for (ZBarSymbol *symbol in symbols) {
        
        strCode = symbol.data;
        break;
    }
    
    NSLog(@"zbarQRCode --- %@",strCode);
    
    if ([strCode hasPrefix:@"http"]) {
       //跳转webview
        
    }else {
        
        
    }

}

- (DFQRCodeScanningView *)scanningView {
    
    if (!_scanningView) {
        
        _scanningView = [DFQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
        
        
    }
    return _scanningView;
}

- (void)dealloc {
    
    NSLog(@" - dealloc");
    
    [self removeScanningView];
}
- (void)removeScanningView {
    
    [self.scanningView removeTimer];
    
    [self.scanningView removeFromSuperview];
    
    self.scanningView = nil;
}


@end
