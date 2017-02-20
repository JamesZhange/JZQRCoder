//
//  JZTimer.h
//  JZSystemFuncDemon
//
//  Created by Liu Rui on 15/2/3.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZTimer : NSObject

+(JZTimer*)newTimer;

-(void)startTimerTimingSecond: (NSTimeInterval)second
                        block: (void (^)())timerBlock
                       repeat: (BOOL)yesOrNo;

-(void)pauseTimer;
-(void)resumeTimer;
-(void)stopTimer;

-(void)fire;

@end
