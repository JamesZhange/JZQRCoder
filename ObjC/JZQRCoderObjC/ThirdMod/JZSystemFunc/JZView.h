//
//  JZView.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/15.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZView : UIView

// 渐变背景
@property(nonatomic, strong) NSArray *gradientColors;
@property(nonatomic, strong) NSArray<NSNumber *> *gradientLocations;
@property CGPoint gradientStartPoint;
@property CGPoint gradientEndPoint;

// 把View绘成虚线
/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;


@end
