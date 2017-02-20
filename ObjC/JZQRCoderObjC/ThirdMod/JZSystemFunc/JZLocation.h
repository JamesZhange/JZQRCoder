//
//  JZLocation.h
//  AirDefenderNewUI
//
//
//  单实例定位管理
//   使用GCDMultiDelegate进行多播管理
//
//
//  Created by Liu Rui on 15/3/12.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "JZGlobal.h"




@protocol JZLocationDelegate <NSObject>

@optional
-(void) JZLocaDidChangeAuthorizationStatus: (CLAuthorizationStatus)status;

-(void) JZLocaDidUpdateToLocation: (CLLocation *)newLocation
                     fromLocation: (CLLocation *)oldLocation;

-(void) JZLocaGeoLocationPlacemarkArray: (NSArray*)placemarks
                               geoError: (NSError*) error;

-(void) JZLocaGetError;

@end








#pragma mark -  @interface JZLocation



@interface JZLocation : JZMultiDelegateObject

SYNTHESIZE_SINGLETON_FOR_HEADER(JZLocation);

//
-(int)StartLocation;
-(void)StopLocation;


// ios8
-(void)requestAuthorizationWhenInUse __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0);
-(void)requestAuthorizationWhenAlways __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0);


@end



