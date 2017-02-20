//
//  QRScannerViewController.m
//  JZQRCoderObjC
//
//  Created by Liu Rui on 2017/1/23.
//  Copyright © 2017年 James. All rights reserved.
//

#import "QRScannerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JZGlobal.h"


@interface QRScannerViewController () <AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    BOOL isAvcaptureDeviceInited;
}
@property (weak, nonatomic) IBOutlet UIButton *GoBackButton;
@property (weak, nonatomic) IBOutlet UIView *CameraContentView;


@property (strong, nonatomic) AVCaptureDevice            *device;
@property (strong, nonatomic) AVCaptureDeviceInput       *input;
@property (strong, nonatomic) AVCaptureMetadataOutput    *output;
@property (strong, nonatomic) AVCaptureSession           *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@end




@implementation QRScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.device = nil;
    self.input = nil;
    self.output = nil;
    self.session = nil;
    self.preview = nil;
    isAvcaptureDeviceInited = NO;
    
    self.CameraContentView.backgroundColor = [UIColor blackColor];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self initAvcaptureDevice];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    [self startAvcapture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
-(void)initAvcaptureDevice {
    
    if (NO == isAvcaptureDeviceInited) {
        
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        self.output = [[AVCaptureMetadataOutput alloc]init];
        [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        self.session = [[AVCaptureSession alloc]init];
        [self.session setSessionPreset:([UIScreen mainScreen].bounds.size.height<500)?AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh];
        [self.session addInput:self.input];
        [self.session addOutput:self.output];
        self.output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode];
        
        self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.preview.frame = [UIScreen mainScreen].bounds;
        [self.CameraContentView.layer insertSublayer:self.preview atIndex:0];
        
        CGRect scanRect = [self drawScanView];

        [[NSNotificationCenter defaultCenter] addObserverForName: AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                          object: nil
                                                           queue: [NSOperationQueue currentQueue]
                                                      usingBlock: ^(NSNotification *_Nonnull note) {
                                                          CGRect adddRect = [self.preview metadataOutputRectOfInterestForRect: scanRect];;
                                                          self.output.rectOfInterest = adddRect;
                                                      }];
        
        isAvcaptureDeviceInited = YES;
    }
}

-(void)startAvcapture {
    
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authorizationStatus) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
                if (granted) {
                    //开始捕获
                    if (YES == isAvcaptureDeviceInited) {
                        [self.session startRunning];
                    }
                } else {
                    JZCompatibleAlert *alert = [[JZCompatibleAlert alloc] initWithWithTitle: @"相机访问受限"
                                                                                    message: @"请在设置界面设置本程序使用相机权限"
                                                                                      style: JZCAlertStyleAlert];
                    [alert addCancelButtonTitle: @"OK"
                                         action: nil];
                    [alert showOnViewController: self animated: YES completion: nil];
                }
            }];
            break;
        }
            
        case AVAuthorizationStatusAuthorized: {
            //开始捕获
            if (YES == isAvcaptureDeviceInited) {
                [self.session startRunning];
            }
            break;
        }
            
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            JZCompatibleAlert *alert = [[JZCompatibleAlert alloc] initWithWithTitle: @"相机访问受限"
                                                                            message: @"请在设置界面设置本程序使用相机权限"
                                                                              style: JZCAlertStyleAlert];
            [alert addCancelButtonTitle: @"OK"
                                 action: nil];
            [alert showOnViewController: self animated: YES completion: nil];
            break;
        }
            
        default: {
            break;
        }
    }
}


#pragma mark - avcapture delegate

- (void)    captureOutput: (AVCaptureOutput *)captureOutput
 didOutputMetadataObjects: (NSArray *)metadataObjects
           fromConnection: (AVCaptureConnection *)connection
{
    if ( (metadataObjects.count==0) )
    {
        return;
    }
    
    if (metadataObjects.count>0) {
        
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        
        //输出扫描字符串
        if ((nil != _delegate)
            && ([_delegate respondsToSelector: @selector(getQRCodeScanResult:ResultString:)])) {
            [_delegate getQRCodeScanResult: scanResult_Success ResultString: metadataObject.stringValue];
        }
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}



#pragma mark - Button Action

- (IBAction)OnCancelButtonClicked:(id)sender {
    
    self.device = nil;
    self.input = nil;
    self.output = nil;
    self.session = nil;
    self.preview = nil;
    
    //输出扫描字符串
    if ((nil != _delegate)
        && ([_delegate respondsToSelector: @selector(getQRCodeScanResult:ResultString:)])) {
        [_delegate getQRCodeScanResult: scanResult_Cancel ResultString: nil];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)OnPhotoAlbumButtonClicked:(id)sender {
    
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        JZCompatibleAlert *alert = [[JZCompatibleAlert alloc] initWithWithTitle: @"无法打开相册"
                                                                        message: @"无法打开相册"
                                                                          style: JZCAlertStyleAlert];
        [alert addCancelButtonTitle: @"OK"
                             action: nil];
        [alert showOnViewController: self animated: YES completion: nil];
        return;
    }
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
    
    
    
}

#pragma mark - <UIImagePickerControllerDelegate>
// 获取图片后的操作
- (void)imagePickerController: (UIImagePickerController *)picker
didFinishPickingMediaWithInfo: (NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    UIImage * srcImage = info[UIImagePickerControllerOriginalImage];

    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:srcImage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    
    NSString *result = feature.messageString;
    
    if (nil == result) {
        JZCompatibleAlert *alert = [[JZCompatibleAlert alloc] initWithWithTitle: @"无扫描结果"
                                                                        message: @"从照片中无法获得扫描结果"
                                                                          style: JZCAlertStyleAlert];
        [alert addCancelButtonTitle: @"OK"
                             action: nil];
        [alert showOnViewController: self animated: YES completion: nil];
    } else {
        //输出扫描字符串
        if ((nil != _delegate)
            && ([_delegate respondsToSelector: @selector(getQRCodeScanResult:ResultString:)])) {
            [_delegate getQRCodeScanResult: scanResult_Success ResultString: result];
        }
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}



#pragma mark - UI

-(CGRect)drawScanView {
    
    CGRect viewframe = self.CameraContentView.frame;
    
    //中间镂空的矩形框
    CGSize hollowoutSize = CGSizeMake(viewframe.size.width*3/4, viewframe.size.width*3/4);
    CGRect hollowoutRect =CGRectMake((viewframe.size.width-hollowoutSize.width)/2, (viewframe.size.height-hollowoutSize.height)/2-50,
                              hollowoutSize.width, hollowoutSize.height);
    
    //背景
    // UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:viewframe cornerRadius:0];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:viewframe];
    
    //镂空
    // UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect: hollowoutRect];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect: hollowoutRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.5;
    
    [self.CameraContentView.layer addSublayer:fillLayer];
    
    return hollowoutRect;
}

// iOS9 以后用复写这个函数来控制状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent; // 白色
}

@end












