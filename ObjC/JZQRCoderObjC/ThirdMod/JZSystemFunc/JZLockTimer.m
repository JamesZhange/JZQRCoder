//
//  JZLockTimer.m
//  JZSystemFuncDemon
//
//  Created by Liu Rui on 15/2/3.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "JZLockTimer.h"

//---------------------------------

@interface JZLockTimer()
{
    NSTimer* timer;
    void (^mCompletion)(void);
}

@end



//---------------------------------

@implementation JZLockTimer


-(id)init
{
    self = [super init];
    if (self) {
        timer = nil;
        _isLock = NO;
    }
    return self;
}

+(JZLockTimer*)newTimer
{
    return [[JZLockTimer alloc] init];
}

-(void)dealloc
{
    [self stopTimer];
}

-(void)startTimerTimingSecond: (NSTimeInterval)second completion: (void (^)())completion
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    _isLock = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval: second
                                             target: self
                                           selector: @selector(endTimer)
                                           userInfo: nil repeats:NO];
    
    mCompletion = completion;
}

-(void)endTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    
    if (nil != mCompletion) {
        mCompletion();
    }
    
    _isLock = NO;
}

// 提前终止，此时不运行 completion block
-(void)stopTimer
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }

    _isLock = NO;
}



@end
