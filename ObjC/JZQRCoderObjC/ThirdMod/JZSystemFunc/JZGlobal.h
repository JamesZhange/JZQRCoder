//
//  JZGlobal.h
//  JZQRCoderObjC
//
//  Created by Liu Rui on 2017/1/23.
//  Copyright © 2017年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

// 不需要 Global.h 的头文件
#import "SingletonObjDefine.h"
#import "JZMultiDelegateObject.h"
#import "JZMultiDelegateUIView.h"
#import "JZLockTimer.h"
#import "JZTimer.h"
#import "JZColorHelper.h"
#import "JZLocation.h"
#import "JZMemory.h"
#import "JZStringHelper.h"
#import "JZView.h"
#import "JZCompatibleAlert.h"
#import "JZImageHelper.h"
#import "JZURLRequest.h"
#import "LongpressReorderTableView.h"
#import "UIScrollView+subviews.h"
#import "JZGestureScrollView.h"
#import "JZCopyableLabel.h"
#import "JZActivityIndicatorMgr.h"
#import "NSString+containsSubString.h"
#import "NSString+chineseNumberals.h"
#import "NSString+IgnoreCaseCompare.h"
#import "NSURLConnection+tag.h"


#define IOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS_10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)


#define DISPATCHTIME(t) (dispatch_time(DISPATCH_TIME_NOW, (int64_t)((t) * NSEC_PER_SEC)))

// #define DLOG
// #define DLOG  NSLog
#define DLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

// G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]





@interface JZGlobal : NSObject


+(NSString*)AppDocumentsPatch;
+(NSString*)AppDocumentsFilePatch: (NSString*)filename;

+(NSString*)AppCacheDirectoryPatch;
+(NSString*)AppCacheDirectoryFilePatch: (NSString*)filename;


@end
