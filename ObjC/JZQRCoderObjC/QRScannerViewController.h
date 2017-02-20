//
//  QRScannerViewController.h
//  JZQRCoderObjC
//
//  Created by Liu Rui on 2017/1/23.
//  Copyright © 2017年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, eumScanResult) {
    scanResult_NoResult = 0,
    scanResult_Success,
    scanResult_Cancel,
    scanResult_Unknow,
};




@protocol QRScannerViewDelegate <NSObject>
@optional
-(void)getQRCodeScanResult: (eumScanResult)rescode
              ResultString: (NSString*)resultstring;

@end


@interface QRScannerViewController : UIViewController

@property(nonatomic, strong) id<QRScannerViewDelegate> delegate;

@end
