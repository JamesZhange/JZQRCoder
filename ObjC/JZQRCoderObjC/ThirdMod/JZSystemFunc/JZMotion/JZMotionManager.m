//
//  JZMotionManager.m
//  BTArmController
//
//  Created by Liu Rui on 15/9/24.
//  Copyright © 2015年 Liu Rui. All rights reserved.
//

#import "JZMotionManager.h"
#import "AccelerometerFilter.h"
// #import "vector.h"
// #import "vector_inline_implementation.h"


// static const double kMinCutoffFrequency = 1;

// static const double kUserAccelerationHpfCutoffFrequency = 1000.0;
static const double kUserAccelerationLpfCutoffFrequency = 10.0;



@interface JZMotionManager ()
{
    CMMotionManager *motionManager;
    
    BOOL isDeviceMotionStart;
    BOOL isAccelerometerStart;
    BOOL isMagnetometerStart;
    BOOL isGyroStart;
    
    LowpassFilter *accelerationLpf;  // 加速度低通滤波器
    
    // attitude
    CMAttitude *referenceAttitude;
}

@end



@implementation JZMotionManager
SYNTHESIZE_SINGLETON_FOR_CLASS(JZMotionManager)

-(id)init
{
    self = [super init];
    if (nil != self) {
        
        // --
        // core motion 组件
        motionManager = nil;
        
        isDeviceMotionStart = NO;
        isAccelerometerStart = NO;
        isMagnetometerStart = NO;
        isGyroStart = NO;
        
        referenceAttitude = nil;

        
        // Manager初始化
        motionManager = [[CMMotionManager alloc] init];

    }
    return self;
}



#pragma mark - start stop


/* --- 系统整合滤波后各种数据 ----*/
-(int)startDeviceMotion: (NSTimeInterval)updateInterval
{
    int res = 1;
    
    if (YES == isDeviceMotionStart) {
        [self stopDeviceMotion];
    }
    
    referenceAttitude = nil;
    
    motionManager.deviceMotionUpdateInterval = updateInterval;
    
    if (motionManager.isDeviceMotionAvailable) {
        
        // pull
        [motionManager startDeviceMotionUpdates];
        
        // push
        // [motionManager startDeviceMotionUpdatesUsingReferenceFrame: CMAttitudeReferenceFrameXArbitraryZVertical];
        
        isDeviceMotionStart = YES;
    }
    return res;
}
-(void)stopDeviceMotion
{
    if (nil != motionManager) {
        
        if (YES == isDeviceMotionStart) {
            [motionManager stopDeviceMotionUpdates];
            isDeviceMotionStart = NO;
        }
    }
}



/* --- 加速度计 ----*/
-(int)startAccelerometer
{
    int res = 1;
    
    if (YES == isAccelerometerStart) {
        [self stopAccelerometer];
    }
    
    motionManager.accelerometerUpdateInterval = 0.01;
    
    // 滤波器初始化
#if 0
    gravityLpf = [[LowpassFilter alloc] initWithCutoffFrequency:(100 + kMinCutoffFrequency)];
    
    userAccelerationHpf = [[HighpassFilter alloc] initWithCutoffFrequency:kUserAccelerationHpfCutoffFrequency];
    userAccelerationHpfLpf = [[LowpassFilter alloc] initWithCutoffFrequency:kUserAccelerationLpfCutoffFrequency];
    //--------------
    
    mat4f_identity(modelViewMatrix);
    // mat4f_identity(projectionMatrix);
    
    //        mat4f_initPerspective(60.0f * kDegreesToRadians, (float) backingWidth*1.0f/backingHeight, 0.1f, 10.0f, projectionMatrix);
#endif
    accelerationLpf = [[LowpassFilter alloc] initWithCutoffFrequency:kUserAccelerationLpfCutoffFrequency];

    
    [motionManager startAccelerometerUpdates];
    isAccelerometerStart = YES;
    res = 0;
    
    return res;
}
-(void)stopAccelerometer
{
    if (nil != motionManager) {
        
        if (YES == isAccelerometerStart) {
            [motionManager stopAccelerometerUpdates];
            isAccelerometerStart = NO;
        }
    }
}


/* --- 磁力计 ----*/
-(int)startMagnetometer
{
    int res = 1;
   
    if (YES == isMagnetometerStart) {
        [self stopMagnetometer];
    }
    
    // 没写初始化参数
    
    [motionManager startMagnetometerUpdates];
    isMagnetometerStart = YES;
    
    return res;
}
-(void)stopMagnetometer
{
    if (nil != motionManager) {
        
        if (YES == isMagnetometerStart) {
            [motionManager stopMagnetometerUpdates];
            isMagnetometerStart = NO;
        }
    }
}


/* --- 陀螺仪 ----*/
-(int)startGyro
{
    int res = 1;
    
    if (YES == isGyroStart) {
        [self stopGyro];
    }
    
    // 没写初始化参数
    
    [motionManager startGyroUpdates];
    isGyroStart = YES;
    
    return res;
}
-(void)stopGyro
{
    if (nil != motionManager) {
        
        if (YES == isGyroStart) {
            [motionManager stopGyroUpdates];
            isGyroStart = NO;
        }
    }
}



-(void)dealloc
{
    if (nil != motionManager) {
        
        if (YES == isDeviceMotionStart) {
            [motionManager stopDeviceMotionUpdates];
        }
        if (YES == isAccelerometerStart) {
            [motionManager stopAccelerometerUpdates];
        }
        if (YES == isMagnetometerStart) {
            [motionManager stopMagnetometerUpdates];
        }
        if (YES == isGyroStart) {
            [motionManager stopGyroUpdates];
        }
    }
}






#pragma mark - property

-(CMDeviceMotion *)cmDeviceMotion
{
    if (nil != motionManager) {
        return motionManager.deviceMotion;
    }
    return nil;
}

-(CMAcceleration)acceleration
{
    return motionManager.accelerometerData.acceleration;
}

-(CMAcceleration)userAcceleration
{
    CMAcceleration userAcceleration = self.cmDeviceMotion.userAcceleration;
    [accelerationLpf addAcceleration: userAcceleration
                       withTimestamp: self.cmDeviceMotion.timestamp];
    userAcceleration.x = accelerationLpf.x;
    userAcceleration.y = accelerationLpf.y;
    userAcceleration.z = accelerationLpf.z;
    return userAcceleration;
}




@end
