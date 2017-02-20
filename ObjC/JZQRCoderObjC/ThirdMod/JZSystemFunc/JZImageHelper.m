//
//  JZImageHelper.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/3/31.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZImageHelper.h"

@implementation JZImageHelper

// 改变图像的尺寸
+(UIImage *)resizeImage: (UIImage*)image
                 toSize: (CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 等比缩放
+(UIImage *)resizeImage: (UIImage *)image
                toScale: (float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}



// UIView 生成 Image
+(UIImage*) imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage*) imageWithUIView:(UIView*)view atRect:(CGRect)rect
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}





/**
 *  渐变色图案
 *  const CGFloat locations[5] = {0,0.2,0.5,0.8,1};
 *  CGFloat components[20] = {
 *      R, G, B, 0.1*A,
 *      R, G, B, 0.4*A,
 *      R, G, B, 0.7*A,
 *      R, G, B, 0.4*A,
 *      R, G, B, 0.1*A
 *  };
 *  [self gradientImageWithSize:size locations:locations components:components count:5]
 */
+(UIImage *)gradientImageWithSize:(CGSize) size
                        locations:(const CGFloat []) locations
                       components:(const CGFloat []) components
                            count:(NSUInteger)count
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef colorGradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawLinearGradient(context, colorGradient, (CGPoint){0, 0}, (CGPoint){size.width, 0}, 0);
    CGGradientRelease(colorGradient);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


// 纯色 image
+(UIImage*)imageWithSize: (CGSize)size
               pureColor: (UIColor*)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [color set];
    UIRectFill(CGRectMake(0,0, size.width, size.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}



@end
