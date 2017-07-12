//
//  QRCodeScanningVC.m
//  SinoCommunity
//
//  Created by df on 2017/7/10.
//  Copyright © 2017年 df. All rights reserved.
//

#import "QRCodeScanningVC.h"

#import "DFQRCodeScanningView.h"

#import "DFQRCodeScanManager.h"

@interface QRCodeScanningVC ()<DFQRCodeScanManagerDelegate>

@property (nonatomic, strong) DFQRCodeScanningView *scanningView;

@end

@implementation QRCodeScanningVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"扫一扫";

    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.scanningView];
    
    [self setupQRCodeScanning];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [[DFQRCodeScanManager sharedManager] startRunning];

    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[DFQRCodeScanManager sharedManager] stopRunning];

    [self.scanningView removeTimer];
}

- (void)setupQRCodeScanning {
    
    DFQRCodeScanManager *manager = [DFQRCodeScanManager sharedManager];
    
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    
    manager.delegate = self;
    
    [manager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
}

- (void)DFQRCodeScanManager:(DFQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects {
    
    [[DFQRCodeScanManager sharedManager] stopRunning];
    [self.scanningView removeTimer];

    SystemSoundID soundID = 1013;//具体参数详情下面贴出来
    //播放声音
    AudioServicesPlaySystemSound(soundID);
    
    
    NSLog(@"%@",metadataObjects);
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
