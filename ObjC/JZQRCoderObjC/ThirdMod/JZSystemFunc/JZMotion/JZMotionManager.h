//
//  JZMotionManager.h
//  BTArmController
//
//  Created by Liu Rui on 15/9/24.
//  Copyright © 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "JZGlobal.h"


#define PI              (3.1415926535898)
#define ANGLEforPI      (180)


@interface JZMotionManager : NSObject
SYNTHESIZE_SINGLETON_FOR_HEADER(JZMotionManager)


@property(readonly, nonatomic) CMDeviceMotion *cmDeviceMotion;

@property(readonly, nonatomic) CMAcceleration acceleration;
@property(readonly, nonatomic) CMAcceleration userAcceleration;


-(int)startDeviceMotion: (NSTimeInterval)updateInterval;    // 经过内部转换和滤波
-(void)stopDeviceMotion;

-(int)startAccelerometer;   // 原始数据，以重力方向为原始数据
-(void)stopAccelerometer;   // 原始数据，以重力方向为原始数据

-(int)startMagnetometer;
-(void)stopMagnetometer;

-(int)startGyro;
-(void)stopGyro;

@end
