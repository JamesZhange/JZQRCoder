//
//  NSString+containsSubString.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/7/6.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "NSString+containsSubString.h"

@implementation NSString (containsSubString)

-(BOOL)containsSubString: (NSString*)substr
{
    if ([self rangeOfString: substr].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

@end
