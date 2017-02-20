//
//  JZImageHelper.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/3/31.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JZImageHelper : NSObject

+(UIImage *)resizeImage: (UIImage*)image
                 toSize: (CGSize)size;
// 等比缩放
+(UIImage *)resizeImage: (UIImage *)image
                toScale: (float)scaleSize;


// UIView 生成 Image
+(UIImage*) imageWithUIView: (UIView*)view;

+(UIImage*) imageWithUIView: (UIView*)view
                     atRect: (CGRect)rect;

+(UIImage *)gradientImageWithSize:(CGSize) size
                        locations:(const CGFloat []) locations
                       components:(const CGFloat []) components
                            count:(NSUInteger)count;

+(UIImage*)imageWithSize: (CGSize)size
               pureColor: (UIColor*)color;
@end
