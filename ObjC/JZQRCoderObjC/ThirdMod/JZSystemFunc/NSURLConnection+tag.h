//
//  NSURLConnection+tag.h
//  AirDefender
//
//  Created by Liu Rui on 14-7-4.
//  Copyright (c) 2014年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSURLConnection (tag)

@property (nonatomic, strong) NSNumber *tag;

@end
