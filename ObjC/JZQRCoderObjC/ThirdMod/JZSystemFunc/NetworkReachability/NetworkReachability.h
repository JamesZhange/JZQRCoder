//
//  NetworkReachability.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/2/29.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZMultiDelegateObject.h"
#import "JZGlobal.h"

@interface NetworkReachability : JZMultiDelegateObject
SYNTHESIZE_SINGLETON_FOR_HEADER(NetworkReachability);

-(void) startMonitorNetwork;
-(void) stopMonitorNetwork;

@end
