//
//  JZColorHelper.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/3/12.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZColorHelper.h"

#define ColorMin    0
#define ColorMax    255

#define fColorMin    0.0
#define fColorMax    1.0





@implementation JZColorHelper




/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

+ (UIColor *)colorFromHexRGBA:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte, alphaByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 24);
    greenByte = (unsigned char) (colorCode >> 16);
    blueByte = (unsigned char) (colorCode >> 8); // masks off high bits
    alphaByte = (unsigned char)(colorCode);
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha: (float)alphaByte/ 0xff];
    return result;
}


+(NSDictionary *)rgbaDictionaryByColor:(UIColor *)originColor
{
    if (nil == originColor) {
        return nil;
    }
    
    CGFloat r=0,g=0,b=0,a=0;
    
    if ([originColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        
        [originColor getRed:&r green:&g blue:&b alpha:&a];
        
    } else {
        
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}



+(UIColor*)colorFromColor: (UIColor*)color
                  OffsetR: (CGFloat)offsetr
                  OffsetG: (CGFloat)offsetg
                  OffsetB: (CGFloat)offsetb
                  OffsetA: (CGFloat)offseta
{
    if (nil != color) {
        NSDictionary* rgbDic = [JZColorHelper rgbaDictionaryByColor: color];
        
        CGFloat r = ((NSNumber*)[rgbDic objectForKey:@"R"]).floatValue + offsetr;
        CGFloat g = ((NSNumber*)[rgbDic objectForKey:@"G"]).floatValue + offsetg;
        CGFloat b = ((NSNumber*)[rgbDic objectForKey:@"B"]).floatValue + offsetb;
        CGFloat a = ((NSNumber*)[rgbDic objectForKey:@"A"]).floatValue + offseta;
        
        r = [self fColorSaturation: r];
        g = [self fColorSaturation: g];
        b = [self fColorSaturation: b];
        a = [self fColorSaturation: a];
        
        UIColor* offsetcolor = [UIColor colorWithRed:r green:g blue:b alpha:a];
        return offsetcolor;
    }
    return nil;
}




+(CGFloat)fColorSaturation: (CGFloat)value
{
    CGFloat floor = (value < fColorMin) ? fColorMin : value;
    CGFloat top = (floor > fColorMax) ? fColorMax : floor;
    
    return top;
}

+(int)ColorSaturation: (int)value
{
    int floor = (value < ColorMin) ? ColorMin : value;
    int top = (floor > ColorMax) ? ColorMax : floor;
    
    return top;
}

@end


