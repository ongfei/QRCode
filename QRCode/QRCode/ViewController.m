//
//  ViewController.m
//  QRCode
//
//  Created by df on 2017/7/12.
//  Copyright © 2017年 df. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "DFQRCodeManager.h"

#import "ZBarQRCodeScanVC.h"

#import "QRCodeScanningVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *codeImgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubviews];
    
}

- (void)createSubviews {
    
    UIButton *generateNormalQR = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [self.view addSubview:generateNormalQR];
    
    [generateNormalQR setTitle:@"生成标准二维码" forState:(UIControlStateNormal)];
    
    generateNormalQR.titleLabel.font = [UIFont systemFontOfSize:18];
    
    generateNormalQR.frame = CGRectMake(100, 100, self.view.frame.size.width - 200, 50);
    
    [generateNormalQR addTarget:self action:@selector(generateNormalQRClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *generateIcoQR = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [self.view addSubview:generateIcoQR];
    
    [generateIcoQR setTitle:@"生成ico二维码" forState:(UIControlStateNormal)];
    
    generateIcoQR.titleLabel.font = [UIFont systemFontOfSize:18];
    
    generateIcoQR.frame = CGRectMake(100, CGRectGetMaxY(generateNormalQR.frame), self.view.frame.size.width - 200, 50);
    
    [generateIcoQR addTarget:self action:@selector(generateIcoQRClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *sysQRScan = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [self.view addSubview:sysQRScan];
    
    [sysQRScan setTitle:@"系统扫描二维码" forState:(UIControlStateNormal)];
    
    sysQRScan.titleLabel.font = [UIFont systemFontOfSize:18];
    
    sysQRScan.frame = CGRectMake(100, CGRectGetMaxY(generateIcoQR.frame), self.view.frame.size.width - 200, 50);
    
    [sysQRScan addTarget:self action:@selector(sysQRScanClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *zbarQRScan = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    [self.view addSubview:zbarQRScan];
    
    [zbarQRScan setTitle:@"zbar二维码" forState:(UIControlStateNormal)];
    
    zbarQRScan.titleLabel.font = [UIFont systemFontOfSize:18];
    
    zbarQRScan.frame = CGRectMake(100, CGRectGetMaxY(sysQRScan.frame), self.view.frame.size.width - 200, 50);
    
    [zbarQRScan addTarget:self action:@selector(zbarQRScanClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.codeImgV = [UIImageView new];
    
    [self.view addSubview:self.codeImgV];
    
    self.codeImgV.frame = CGRectMake(50, CGRectGetMaxY(zbarQRScan.frame) + 100, self.view.frame.size.width - 100, self.view.frame.size.width - 100);
}

- (void)generateNormalQRClick {
    
    UIAlertController *alerC = [UIAlertController alertControllerWithTitle:@"生成二维码" message:@"二维码字符串" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [alerC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"二维码字符串";
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if (alerC.textFields.firstObject.text.length > 0) {
            
            [self generateQRWithString:alerC.textFields.firstObject.text andIcoString:@""];
        }
        

    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    
    [alerC addAction:sureAction];
    [alerC addAction:cancleAction];
    
    [self presentViewController:alerC animated:YES completion:^{
        
    }];

}

- (void)generateIcoQRClick {
    
    UIAlertController *alerC = [UIAlertController alertControllerWithTitle:@"生成二维码" message:@"二维码字符串" preferredStyle:(UIAlertControllerStyleAlert)];
    
    [alerC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"二维码字符串";
        
        NSLog(@"%@",textField.text);
        
    }];
    
    [alerC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.text = @"ico";
        
        textField.enabled = NO;
        
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self generateQRWithString:alerC.textFields.firstObject.text andIcoString:alerC.textFields.lastObject.text];
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    
    [alerC addAction:sureAction];
    [alerC addAction:cancleAction];
    
    [self presentViewController:alerC animated:YES completion:^{
        
    }];

    
}

- (void)generateQRWithString:(NSString *)str andIcoString:(NSString *)icoString {
    
    if ([icoString isEqualToString:@""]) {
        
        self.codeImgV.image = [DFQRCodeManager generateWithDefaultQRCodeString:str imageSize:CGSizeMake(CGRectGetWidth(self.codeImgV.frame), CGRectGetHeight(self.codeImgV.frame))];
    }else {
        
        self.codeImgV.image = [DFQRCodeManager generateWithLogoQRCodeString:str logoImageName:icoString logoScaleToSuperView:0.6];
    }

}

- (void)sysQRScanClick {
    
    __block __weak ViewController *weakSelf = self;
    [self detectionCamera:^(BOOL enabel) {
        
        if (enabel) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                QRCodeScanningVC *sysQRScan = [QRCodeScanningVC new];
                
                [weakSelf.navigationController pushViewController:sysQRScan animated:YES];
                
            });
        }
    }];
    
}

- (void)zbarQRScanClick {
    
    __block __weak ViewController *weakSelf = self;
    [self detectionCamera:^(BOOL enabel) {
        
        if (enabel) {
            
            dispatch_async(dispatch_get_main_queue(), ^{

                ZBarQRCodeScanVC *zbarQRScan = [ZBarQRCodeScanVC new];
                
                [weakSelf.navigationController pushViewController:zbarQRScan animated:YES];
                
            });
        }
    }];

}

- (void)detectionCamera:(void(^)(BOOL enabel))block {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    
                        block(YES);
                    });
                    
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    block(NO);
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            
           block(YES);
            
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            
            block(NO);
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        
        block(NO);
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    } 

}

@end
