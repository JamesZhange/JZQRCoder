//
//  JZStringHelper.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/4/14.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JZStringHelper : NSObject

// char[]按位转成十六进制字符
+(NSString*)translatHexStringFromCharArray:(char*)charArray ArrayLength: (unsigned int)len;

// 十六进制字符转成对应 char[]
+(void)translatHexString: (NSString*)hexstring
             ToCharArray: (unsigned char*)charArray
             ArrayLength: (unsigned int)len;

// char[] 按 ascii 转成 NSString
+(NSString*)translatASCIIStringFromCharArray: (char*)charArray ArrayLength: (unsigned int)len;

// NSString 按 ascii 转成 char[]
+(void)translatASCIIString: (NSString*)asciistring
               ToCharArray: (unsigned char*)charArray
               ArrayLength: (unsigned int)len;



@end
