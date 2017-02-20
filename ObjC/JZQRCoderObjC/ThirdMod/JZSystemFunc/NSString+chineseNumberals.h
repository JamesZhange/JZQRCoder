//
//  NSString+chineseNumberals.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/7/7.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>


#define NSSTINGCHINESENUMBERINVALDINTVALUE      (-999999)


@interface NSString (chineseNumberals)

- (NSString *)arabicNumberalsFromChineseNumber;
- (int)integerNumberalsFromChineseNumber;

@end
