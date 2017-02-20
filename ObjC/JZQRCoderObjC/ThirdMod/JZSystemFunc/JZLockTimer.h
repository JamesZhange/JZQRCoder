//
//  JZLockTimer.h
//  JZSystemFuncDemon
//
//  Created by Liu Rui on 15/2/3.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>


/* 使用环境：希望在一段时间有锁定的标志，在超过时间后自动清除标志 */

@interface JZLockTimer : NSObject

@property (atomic) BOOL isLock;

+(JZLockTimer*)newTimer;

-(void)startTimerTimingSecond: (NSTimeInterval)second completion: (void (^)())completion;
-(void)stopTimer;


@end
