//
//  JZCompatibleAlertButton.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/6/21.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZCompatibleAlert.h"


@interface JZCompatibleAlertButton : NSObject

@property (nonatomic) NSInteger tag;
@property (nonatomic, strong) ButtonAction buttonAction;
@property (nonatomic, strong) NSString* title;
@property (nonatomic) BOOL enable;

// ios 8
@property (nonatomic, strong) UIAlertAction *uialertaction;

@end
