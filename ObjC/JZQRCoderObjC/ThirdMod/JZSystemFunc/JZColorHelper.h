//
//  JZColorHelper.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/3/12.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZColorHelper : NSObject

+ (UIColor *)colorFromHexRGB:(const NSString *)inColorString;
+ (UIColor *)colorFromHexRGBA:(const NSString *)inColorString;

+(NSDictionary *)rgbaDictionaryByColor:(UIColor *)originColor;

+(UIColor*)colorFromColor: (UIColor*)color
                  OffsetR: (CGFloat)offsetr
                  OffsetG: (CGFloat)offsetg
                  OffsetB: (CGFloat)offsetb
                  OffsetA: (CGFloat)offseta;
@end


// short call

#define ColorRGB(rgbstring)  [JZColorHelper colorFromHexRGB: rgbstring]
#define ColorRGBA(rgbstring)  [JZColorHelper colorFromHexRGBA: rgbstring]
#define fColorRGB(fred,fgreen,fblue) [UIColor colorWithRed:(fred) green:(fgreen) blue:(fblue) alpha:1]
#define fColorRGBA(fred,fgreen,fblue,falpha) [UIColor colorWithRed:(fred) green:(fgreen) blue:(fblue) alpha:(falpha)]

#define CLEARCOLOR [UIColor clearColor]

#define offsetColor(color, offsetR, offsetG, offsetB, offsetA) [JZColorHelper colorFromColor:color OffsetR:offsetR OffsetG:offsetG OffsetB:offsetB OffsetA:offsetA]
#define offsetAllColor(color, offset) [JZColorHelper colorFromColor:color OffsetR:offset OffsetG:offset OffsetB:offset OffsetA: 0];
