//
//  JZActivityIndicatorMgr.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/28.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//
//  写一个 ActivityIndicator 的框架，管理一下 ActivityIndicator，以后可以更换里边的样式，不动外部的调用
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, eumJZActivityIndicatorStyle) {
    
    JZActivityIndicatorStyleFairairWhite,
    JZActivityIndicatorStyleFairairWhiteLarge,
    JZActivityIndicatorStyleFairairGray,
    JZActivityIndicatorStyleFairairGrayLarge,
    
    JZActivityIndicatorStyleSystemWhite,
    JZActivityIndicatorStyleSystemWhiteLarge,
    JZActivityIndicatorStyleSystemGray,
    JZActivityIndicatorStyleSystemGrayLarge,
    
};






@interface JZActivityIndicatorMgr : NSObject

@property (nonatomic, readonly) NSInteger numberOfBars;     // 多少个线
@property (nonatomic) CGFloat barWidth;                     // 线宽
@property (nonatomic) CGFloat barHeight;                    // 线高
@property (nonatomic) CGFloat aperture;                     // 孔径
@property (nonatomic) UIColor *barColor;                    // 颜色


-(instancetype)initActivityIndicatorInView: (UIView*)contentView
                                 WithFrame: (CGRect)frame
                            IndicatorStyle: (eumJZActivityIndicatorStyle)style;

- (void)showIndicator;
- (void)hideIndicator;

@end
