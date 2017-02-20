//
//  NetworkReachability.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/2/29.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "NetworkReachability.h"
#import "JZGlobal.h"
#import "TonyReachability.h"


#define TESTNETUSEHOSTNAME      @"www.baidu.com"


@interface NetworkReachability ()

@property (strong, nonatomic) TonyReachability* hostReach;

@end




@implementation NetworkReachability
SYNTHESIZE_SINGLETON_FOR_CLASS(NetworkReachability);

-(id)init
{
    self = [super init];
    if (nil != self) {
        
        self.hostReach = [TonyReachability reachabilityWithHostName: TESTNETUSEHOSTNAME] ;
        self.hostReach.reachableBlock = ^(TonyReachability * reachability)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                // "网络可用";
                DLOG(@"网络可用");
                if (reachability.isReachableViaWiFi) {
                    DLOG(@"当前通过wifi连接");
                } else {
                    DLOG(@"wifi未开启，不能用");
                }
                
                if (reachability.isReachableViaWWAN) {
                    DLOG(@"当前通过2g or 3g连接");
                } else {
                    DLOG(@"2g or 3g网络未使用");
                }
            });
        };
        
        self.hostReach.unreachableBlock = ^(TonyReachability * reachability)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                DLOG(@"网络不可用");
            });
        };
    }
    return self;
}



-(void) startMonitorNetwork
{
    [self.hostReach startNotifier];
}

-(void) stopMonitorNetwork
{
    [self.hostReach stopNotifier];
}



@end
