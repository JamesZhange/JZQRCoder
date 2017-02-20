//
//  JZView.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/15.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZView.h"

@interface JZView()
{
    CAGradientLayer* gradientLayer;
    NSArray* mGradientColorArray;
}

@end





@implementation JZView




-(void)initParameters
{
    mGradientColorArray = nil;
    _gradientLocations = nil;
    _gradientStartPoint = CGPointMake(0, 0.5);
    _gradientEndPoint = CGPointMake(1.0, 0.5);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (nil != mGradientColorArray) {
        
        [self drawGradientColor];
        
    }
}



#pragma mark - property

-(NSArray*)gradientColors
{
    return mGradientColorArray;
}
-(void)setGradientColors:(NSArray *)gradientColors
{
    if ((nil != gradientColors) && (gradientColors.count > 0)) {
        if ([gradientColors[0] isKindOfClass: [UIColor class]]) {  // 补丁，外边有时候会写错成UIColor
            NSMutableArray* cgcolorarray = [NSMutableArray array];
            for (UIColor* color in gradientColors) {
                [cgcolorarray addObject: (id)(color.CGColor)];
            }
            mGradientColorArray = cgcolorarray;
        } else {
            mGradientColorArray = gradientColors;
        }
        
        [self setBackgroundColor: [UIColor clearColor]];
        
    } else {
        mGradientColorArray = nil;
    }
}



#pragma mark - 渐变色背景
-(void)drawGradientColor
{
    if (nil == mGradientColorArray) {
        return;
    }
    if (nil != gradientLayer) {
        [gradientLayer removeFromSuperlayer];
    }
    gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = self.bounds;
    gradientLayer.frame = self.bounds;
    gradientLayer.borderWidth = 0;
    
    gradientLayer.colors = mGradientColorArray;
    
    if (nil != _gradientLocations) {
        gradientLayer.locations = _gradientLocations;
    }
    gradientLayer.startPoint = _gradientStartPoint;
    gradientLayer.endPoint = _gradientEndPoint;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    // NSLog(@"gradlayer frame: x: %d, y: %d, w: %d, h: %d", (int)gradientLayer.frame.origin.x, (int)gradientLayer.frame.origin.y, (int)gradientLayer.frame.size.width, (int)gradientLayer.frame.size.height);
}




#pragma mark - 把View绘成虚线
/**
 ** lineView:	   需要绘制成虚线的view
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


@end
