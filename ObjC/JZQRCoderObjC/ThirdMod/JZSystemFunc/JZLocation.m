//
//  JZLocation.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/3/12.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//
#import "JZGlobal.h"
#import "JZLocation.h"


#define GeoLocationRetryNum 5


@interface JZLocation() <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    
    int GeoLocationRetryCount;
}

@end



@implementation JZLocation

SYNTHESIZE_SINGLETON_FOR_CLASS(JZLocation);

-(id)init
{
    self = [super init];
    if (nil != self) {
        
        multiDelegate = (JZMulticastDelegate <JZLocationDelegate> *)[[JZMulticastDelegate alloc] init];
        
        [self CreateLocation];
    }
    return self;
}

-(void)CreateLocation
{
    // 实例化一个位置管理器
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    // 设置定位精度
    // kCLLocationAccuracyNearestTenMeters:精度10米
    // kCLLocationAccuracyHundredMeters:精度100 米
    // kCLLocationAccuracyKilometer:精度1000 米
    // kCLLocationAccuracyThreeKilometers:精度3000米
    // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
    // kCLLocationAccuracyBestForNavigation:导航情况下最高精度，一般要有外接电源时才能使用
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
    // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
    locationManager.distanceFilter = 1000.0f; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
    
    //---
    geocoder = [[CLGeocoder alloc] init];
}



//
-(int)StartLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [locationManager startUpdatingLocation];
        
        GeoLocationRetryCount = 0;
        
        return 0;
    }
    else {
        
        return 1;
    }
    
}
-(void)StopLocation
{
    [locationManager stopUpdatingLocation];
}


#pragma mark - Authorization

-(void)requestAuthorizationWhenInUse __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0)
{
    // 注意要在 .plist 中添加 NSLocationWhenInUseUsageDescription 字串 //  james
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
}

-(void)requestAuthorizationWhenAlways __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_8_0)
{
    // 注意要在 .plist 中添加 NSLocationAlwaysUsageDescription 字串 //  james
    
    if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [locationManager requestAlwaysAuthorization];
    }
}




#pragma mark - CLLocationManagerDelegate

- (void)locationManager: (CLLocationManager *)manager
didChangeAuthorizationStatus: (CLAuthorizationStatus)status {
    
    [multiDelegate JZLocaDidChangeAuthorizationStatus: status];
    
}

- (void)locationManager: (CLLocationManager *)manager
    didUpdateToLocation: (CLLocation *)newLocation
           fromLocation: (CLLocation *)oldLocation
{
    if (nil == newLocation) {
        return;
    }
    
    [multiDelegate JZLocaDidUpdateToLocation:newLocation fromLocation:oldLocation];
    
    
    // 停止位置更新
    
    
    // 获取经纬度
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    
    // ----
    [self GeoLocation: newLocation];

}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"location error:%@",error);
    [multiDelegate JZLocaGetError];
}


-(void) GeoLocation: (CLLocation *)newLocation
{
    if ((nil != geocoder) && (nil != newLocation) ){

        [geocoder reverseGeocodeLocation: newLocation
                       completionHandler: ^(NSArray *placemarks, NSError *error)
         {
             
             [multiDelegate JZLocaGeoLocationPlacemarkArray: placemarks geoError: error];
             
             if (error)
             {
                 NSLog(@"Geo error: %@", error.localizedDescription);

                 [self retryGeoLocation: newLocation];
                 
             } else {
                 
                 for(CLPlacemark *placemark in placemarks)
                 {
                     // NSLog(@"address dic %@",placemark.addressDictionary);
                     NSString *localCity = [placemark.addressDictionary objectForKey:@"City"];
                     NSString *localProvince = [placemark.addressDictionary objectForKey:@"State"];
                     NSLog(@"get city: %@", localCity);
                     
                     // self.LocationCity = localCity;
                     if ((nil == localCity) || (nil == localProvince)) {

                         [self retryGeoLocation: newLocation];
                         return;
                     }
                     
                 }
             }
         }];
    }
}

-(void)retryGeoLocation: (CLLocation *)newLocation
{
    if (GeoLocationRetryCount < GeoLocationRetryNum) {
        [self performSelector:@selector(GeoLocation:) withObject:newLocation afterDelay:2];
        GeoLocationRetryCount++;
    } else {
        // 重试超过预订次数
        [self StartLocation];
        return;
    }
}









@end




