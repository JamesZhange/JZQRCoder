//
//  ViewController.m
//  JZQRCoderObjC
//
//  Created by Liu Rui on 2017/1/23.
//  Copyright © 2017年 James. All rights reserved.
//

#import "ViewController.h"
#import "QRScannerViewController.h"


@interface ViewController () <QRScannerViewDelegate>
{
    NSString* mScanResultString;
    BOOL isFirstLaunch;
}

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *ScanResultTextView;

@property (weak, nonatomic) IBOutlet UIButton *CopyButton;
@property (weak, nonatomic) IBOutlet UIButton *OpenButton;
@property (weak, nonatomic) IBOutlet UIButton *ScanButton;

@property (nonatomic, strong) NSString* ScanResultString;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mScanResultString = nil;
    isFirstLaunch = YES;
    
    // debug
    // self.ScanResultString = @"www.fairair.cn";
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    if ((nil == mScanResultString) && (YES == isFirstLaunch)) {
        isFirstLaunch = NO;
        [self popupScanCameraView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// iOS9 以后用复写这个函数来控制状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault; // 白色
}



#pragma mark - property
-(NSString*)ScanResultString {
    return mScanResultString;
}
-(void)setScanResultString:(NSString *)ScanResultString {
    mScanResultString = ScanResultString;
    self.ScanResultTextView.text = mScanResultString;
    [self refreshButtonAble];
}

#pragma mark - button action

- (IBAction)OnCopyButtonClicked:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    if (nil != mScanResultString) {
        pboard.string = mScanResultString;
        
        // 弹窗
    }
}

- (IBAction)OnOpenButtonClicked:(id)sender {
    
    NSString* urlstring = nil;
    
    if (([mScanResultString hasPrefix: @"http://"])
        || ([mScanResultString hasPrefix: @"https://"]))
    {
        urlstring = mScanResultString;
    } else {
        urlstring = @"http://";
        urlstring = [urlstring stringByAppendingString: mScanResultString];
    }

#if true
    NSURL *url = [NSURL URLWithString:[urlstring stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
#else
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [urlstring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    NSURL *url = [NSURL URLWithString: encodedUrl];
#endif
    
    [[UIApplication sharedApplication] openURL: url];
}


- (IBAction)OnScanButtonClicked:(id)sender {
    self.ScanResultString = @"";
    [self popupScanCameraView];
}

-(void)popupScanCameraView {
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    QRScannerViewController* scanview = [mainStoryboard instantiateViewControllerWithIdentifier: @"QRScannerView"];
    
    if (nil != scanview) {
        scanview.delegate = self;
        [self.navigationController pushViewController:scanview animated:YES];
    }
    
}


-(void)getQRCodeScanResult: (eumScanResult)rescode
              ResultString: (NSString*)resultstring
{
    if (scanResult_Success == rescode) {
        self.ScanResultString = resultstring;
    }
}


-(void)refreshButtonAble {
    if ((nil != mScanResultString) && (mScanResultString.length > 0)) {
        self.CopyButton.enabled = YES;
        self.OpenButton.enabled = YES;
    } else {
        self.CopyButton.enabled = NO;
        self.OpenButton.enabled = NO;
    }
}

@end








