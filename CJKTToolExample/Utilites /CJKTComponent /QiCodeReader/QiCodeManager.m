//
//  QiCodeManager.m
//  QiQRCode
//
//  Created by huangxianshuai on 2018/11/13.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiCodeManager.h"
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>

static NSString *QiInputCorrectionLevelL = @"L";//!< L: 7%
static NSString *QiInputCorrectionLevelM = @"M";//!< M: 15%
static NSString *QiInputCorrectionLevelQ = @"Q";//!< Q: 25%
static NSString *QiInputCorrectionLevelH = @"H";//!< H: 30%

@interface QiCodeManager () <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, QiCodePreviewViewDelegate>
 //AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) QiCodePreviewView *previewView;

@property (nonatomic, copy) void(^lightObserver)(BOOL, BOOL);
@property (nonatomic, copy) void(^callback)(NSString *);
@property (nonatomic, assign) BOOL lightObserverHasCalled;
@property (nonatomic, assign) BOOL autoStop;

@end

@implementation QiCodeManager

#pragma mark - 扫描二维码/条形码

- (instancetype)initWithPreviewView:(QiCodePreviewView *)previewView completion:(nonnull void (^)(void))completion {
    
    self = [super init];
    
    if (self) {
        
        if ([previewView isKindOfClass:[QiCodePreviewView class]]) {
            _previewView = (QiCodePreviewView *)previewView;
            _previewView.delegate = self;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        // 在全局队列开启新线程，异步初始化AVCaptureSession（比较耗时）
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             //获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            /** 创建设备输入数据源 */
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            /** 创建设备输出数据源 */
            AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
            [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//            创建会话对象
            self.session = [[AVCaptureSession alloc] init];
            self.session.sessionPreset = AVCaptureSessionPresetHigh;//设置采样质量为 高
            //会话添加设备的 输入 输出，建立连接
            if ([self.session canAddInput:input]) {
                [self.session addInput:input];
            }
            if ([self.session canAddOutput:output]) {
                [self.session addOutput:output];
                //指定设备的识别类型(在输出添加到会话之后指定识别类型，否则设备的课识别类型会为空，程序会出现崩溃)
                if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode] &&
                    [output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code] &&
                    [output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
                    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeEAN13Code];
                }
            }

            [device lockForConfiguration:nil];
            if (device.isFocusPointOfInterestSupported && [device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            }
            [device unlockForConfiguration];
            
            // 回主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                //预览层 初始化，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
                AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
                previewLayer.frame = previewView.layer.bounds;
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                [previewView.layer insertSublayer:previewLayer atIndex:0];
                
                // 设置扫码区域(自定义)
                CGRect rectFrame = self.previewView.rectFrame;
                if (!CGRectEqualToRect(rectFrame, CGRectZero)) {
                    CGFloat y = rectFrame.origin.y / previewView.bounds.size.height;
                    CGFloat x = (previewView.bounds.size.width - rectFrame.origin.x - rectFrame.size.width) / previewView.bounds.size.width;
                    CGFloat h = rectFrame.size.height / previewView.bounds.size.height;
                    CGFloat w = rectFrame.size.width / previewView.bounds.size.width;
/**
与CGRectMake(x, y, w, h)的传统定义不同，可以将rectOfInterest理解成被翻转过的CGRect
 rectY, rectX, rectH, rectW也不是控件或区域的值，而是所对应的比例
 rectOfInterest的默认值为CGRectMake(.0, .0, 1.0, 1.0)，表示识别二维码/条形码的区域为全屏（previewLayer区域）
 */
                    
                    output.rectOfInterest = CGRectMake(y, x, h, w);
                }
                // 可以在[session startRunning];之后用此语句设置扫码区域
                // metadataOutput.rectOfInterest = [previewLayer metadataOutputRectOfInterestForRect:rectFrame];
                
                // 缩放手势
                UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
                [previewView addGestureRecognizer:pinchGesture];
                
                // 停止previewView上转动的指示器
                [self.previewView stopIndicating];
                
                if (completion) {
                    completion();
                }
            });
        });
    }
    
    return self;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Public functions

- (void)startScanningWithCallback:(void (^)(NSString * _Nonnull))callback {
    
    [self startScanningWithCallback:callback autoStop:NO];
}

- (void)startScanningWithCallback:(void (^)(NSString * _Nonnull))callback autoStop:(BOOL)autoStop {
    
    _callback = callback;
    _autoStop = autoStop;
    
    [self startScanning];
}

- (void)startScanning {
    
    if (_session && !_session.isRunning) {
        [_session startRunning];
        [_previewView startScanning];
    }
    
    __weak typeof(self) weakSelf = self;
    [self observeLightStatus:^(BOOL dimmed, BOOL torchOn) {
        if (dimmed || torchOn) {// 变为弱光或者手电筒处于开启状态
            [weakSelf.previewView stopScanning];// 停止扫描动画
            [weakSelf.previewView showTorchSwitch];// 显示手电筒开关
        } else {// 变为亮光并且手电筒处于关闭状态
            [weakSelf.previewView startScanning];// 开始扫描动画
            [weakSelf.previewView hideTorchSwitch];// 隐藏手电筒开关
        }
    }];
}

- (void)stopScanning {
    
    if (_session && _session.isRunning) {
        [_session stopRunning];
        [_previewView stopScanning];
    }
    [QiCodeManager switchTorch:NO];
    [QiCodeManager resetZoomFactor];
}

- (void)presentPhotoLibraryWithRooter:(UIViewController *)rooter callback:(nonnull void (^)(NSString * _Nonnull))callback {
    _callback = callback;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [rooter presentViewController:imagePicker animated:YES completion:nil];
}

- (void)handleCodeString:(NSString *)codeString {
    
    if (_autoStop) {
        [self stopScanning];
    }
    if (_callback) {
        _callback(codeString);
    }
}


#pragma mark - Notification functions

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    
    [self startScanning];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    
    [self stopScanning];
}


#pragma mark - < 输出代理> AVCaptureMetadataOutputObjectsDelegate
//代理的回调方法，实现我们在成功识别二维码之后要实现的功能逻辑
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
     //数组中包含的都是AVMetadataMachineReadableCodeObject 类型的对象，该对象中包含解码后的数据
     //拿到扫描内容在这里进行个性化处理
    AVMetadataMachineReadableCodeObject *code = metadataObjects.firstObject;
    
    if (code.stringValue) {
        [self handleCodeString:code.stringValue];
    }
}


#pragma mark - QiCodePreviewViewDelegate

- (void)codeScanningView:(QiCodePreviewView *)scanningView didClickedTorchSwitch:(UIButton *)switchButton {
    
    switchButton.selected = !switchButton.selected;
    
    [QiCodeManager switchTorch:switchButton.selected];
    _lightObserverHasCalled = switchButton.selected;
}


#pragma mark -  UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage *pickedImage = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    CIImage *detectImage = [CIImage imageWithData:UIImagePNGRepresentation(pickedImage)];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyLow}];
    CIQRCodeFeature *feature = (CIQRCodeFeature *)[detector featuresInImage:detectImage options:nil].firstObject;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if (feature.messageString) {
            [self handleCodeString:feature.messageString];
        }
    }];
}




#pragma mark - 打开/关闭手电筒
//    通过监测光线亮度给用户提供打开手电筒的选择
- (void)observeLightStatus:(void (^)(BOOL, BOOL))lightObserver {
    
    _lightObserver = lightObserver;

    AVCaptureVideoDataOutput *lightOutput = [[AVCaptureVideoDataOutput alloc] init];
    [lightOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    if ([_session canAddOutput:lightOutput]) {
        [_session addOutput:lightOutput];
    }
}

//当出现手电筒开关时，我们可以通过点击开关改变手电筒的状态
+ (void)switchTorch:(BOOL)on {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureTorchMode torchMode = on? AVCaptureTorchModeOn: AVCaptureTorchModeOff;
    
    if (device.hasFlash && device.hasTorch && torchMode != device.torchMode) {
        [device lockForConfiguration:nil];// 修改device属性之前须lock
        [device setTorchMode:torchMode];// 修改device的手电筒状态
        [device unlockForConfiguration];// 修改device属性之后unlock
    }
}


#pragma mark -  <弱光监测代理> AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    // 通过sampleBuffer获取到光线亮度值brightness
    CFDictionaryRef metadataDicRef = CMCopyDictionaryOfAttachments(NULL, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadataDic = (__bridge NSDictionary *)metadataDicRef;
    CFRelease(metadataDicRef);
    NSDictionary *exifDic = metadataDic[(__bridge NSString *)kCGImagePropertyExifDictionary];
    CGFloat brightness = [exifDic[(__bridge NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    // 初始化一些变量，作为是否透传brightness的因数
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    BOOL torchOn = device.torchMode == AVCaptureTorchModeOn;
    BOOL dimmed = brightness < 1.0;//brightness < 1.0为弱光
    static BOOL lastDimmed = NO;
    
    // 控制透传逻辑：第一次监测到光线或者光线明暗变化（dimmed变化）时透传
    if (_lightObserver) {
        if (!_lightObserverHasCalled) {
            _lightObserver(dimmed, torchOn);
            _lightObserverHasCalled = YES;
            lastDimmed = dimmed;
        }
        else if (dimmed != lastDimmed) {
            _lightObserver(dimmed, torchOn);
            lastDimmed = dimmed;
        }
    }
}



#pragma mark - 缩放手势
// 在selector方法中根据gesture.scale调整device.videoZoomFactor
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
      // 设定有效缩放范围，防止超出范围而崩溃
    CGFloat minZoomFactor = 1.0;
    CGFloat maxZoomFactor = device.activeFormat.videoMaxZoomFactor;
    
    if (@available(iOS 11.0, *)) {
        minZoomFactor = device.minAvailableVideoZoomFactor;
        maxZoomFactor = device.maxAvailableVideoZoomFactor;
    }
  
    static CGFloat lastZoomFactor = 1.0;
     //对手势的状态进行判断
    if (gesture.state == UIGestureRecognizerStateBegan) {
        // 记录上次缩放的比例，本次缩放在上次的基础上叠加
        lastZoomFactor = device.videoZoomFactor;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat zoomFactor = lastZoomFactor * gesture.scale;
        zoomFactor = fmaxf(fminf(zoomFactor, maxZoomFactor), minZoomFactor);
        [device lockForConfiguration:nil];//先锁定相机设备
        device.videoZoomFactor = zoomFactor;//修改device的视频缩放比例
        [device unlockForConfiguration];//有了变化，在解锁相机设备
    }
}


#pragma mark - Private functions

+ (void)resetZoomFactor {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    device.videoZoomFactor = 1.0;
    [device unlockForConfiguration];
}



#pragma mark - 生成二维码/条形码 -------------------------------

//! 生成二维码
+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size {
    
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator" withInputParameters:@{@"inputMessage": codeData, @"inputCorrectionLevel": QiInputCorrectionLevelH}];
    UIImage *codeImage = [QiCodeManager scaleImage:filter.outputImage toSize:size];
    
    return codeImage;
}

//! 生成二维码+logo
+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size logo:(nonnull UIImage *)logo {
    
    UIImage *codeImage = [QiCodeManager generateQRCode:code size:size];
    codeImage = [QiCodeManager combinateCodeImage:codeImage andLogo:logo];
    
    return codeImage;
}

//! 生成条形码
+ (UIImage *)generateCode128:(NSString *)code size:(CGSize)size {
    
    NSData *codeData = [code dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator" withInputParameters:@{@"inputMessage": codeData, @"inputQuietSpace": @.0}];
    /* @{@"inputMessage": codeData, @"inputQuietSpace": @(.0), @"inputBarcodeHeight": @(size.width / 3)} */
    UIImage *codeImage = [QiCodeManager scaleImage:filter.outputImage toSize:size];
    
    return codeImage;
}


#pragma mark - Util functions

// 缩放图片(生成高质量图片）
+ (UIImage *)scaleImage:(CIImage *)image toSize:(CGSize)size {
    
    //! 将CIImage转成CGImageRef
    CGRect integralRect = image.extent;// CGRectIntegral(image.extent);// 将rect取整后返回，origin取舍，size取入
    CGImageRef imageRef = [[CIContext context] createCGImage:image fromRect:integralRect];
    
    //! 创建上下文
    CGFloat sideScale = fminf(size.width / integralRect.size.width, size.width / integralRect.size.height) * [UIScreen mainScreen].scale;// 计算需要缩放的比例
    size_t contextRefWidth = ceilf(integralRect.size.width * sideScale);
    size_t contextRefHeight = ceilf(integralRect.size.height * sideScale);
    CGContextRef contextRef = CGBitmapContextCreate(nil, contextRefWidth, contextRefHeight, 8, 0, CGColorSpaceCreateDeviceGray(), (CGBitmapInfo)kCGImageAlphaNone);// 灰度、不透明
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);// 设置上下文无插值
    CGContextScaleCTM(contextRef, sideScale, sideScale);// 设置上下文缩放
    CGContextDrawImage(contextRef, integralRect, imageRef);// 在上下文中的integralRect中绘制imageRef
    
    //! 从上下文中获取CGImageRef
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(contextRef);
    
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    
    //! 将CGImageRefc转成UIImage
    UIImage *scaledImage = [UIImage imageWithCGImage:scaledImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    return scaledImage;
}

// 合成图片（code+logo）
+ (UIImage *)combinateCodeImage:(UIImage *)codeImage andLogo:(UIImage *)logo {
    
    UIGraphicsBeginImageContextWithOptions(codeImage.size, YES, [UIScreen mainScreen].scale);
    
    // 将codeImage画到上下文中
    [codeImage drawInRect:(CGRect){.0, .0, codeImage.size.width, codeImage.size.height}];
    
    // 定义logo的绘制参数
    CGFloat logoSide = fminf(codeImage.size.width, codeImage.size.height) / 4;
    CGFloat logoX = (codeImage.size.width - logoSide) / 2;
    CGFloat logoY = (codeImage.size.height - logoSide) / 2;
    CGRect logoRect = (CGRect){logoX, logoY, logoSide, logoSide};
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:logoRect cornerRadius:logoSide / 5];
    [cornerPath setLineWidth:2.0];
    [[UIColor whiteColor] set];
    [cornerPath stroke];
    [cornerPath addClip];
    
    // 将logo画到上下文中
    [logo drawInRect:logoRect];
    
    // 从上下文中读取image
    codeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return codeImage;
}

@end
