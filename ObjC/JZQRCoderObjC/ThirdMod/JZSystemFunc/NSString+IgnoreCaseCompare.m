//
//  NSString+IgnoreCaseCompare.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/9/6.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "NSString+IgnoreCaseCompare.h"

@implementation NSString (IgnoreCaseCompare)

-(BOOL)isEqualIgnoreCaseToString: (NSString*)aString
{
    if ((NSOrderedSame == [self caseInsensitiveCompare: aString])) {
        return YES;
    }
    return NO;
}

@end
