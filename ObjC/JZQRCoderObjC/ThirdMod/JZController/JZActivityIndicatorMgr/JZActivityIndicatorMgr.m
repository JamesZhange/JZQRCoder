//
//  JZActivityIndicatorMgr.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/28.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZGlobal.h"
#import "JZActivityIndicatorMgr.h"
#import "AMPActivityIndicator.h"

#define BarNumbersNameString          @"barNumbers"
#define BarWidthNameString          @"barwidth"
#define BarHeightNameString         @"barheight"
#define BarApertureNameString       @"baraperture"
#define BarColorNameString          @"barColor"



@interface JZActivityIndicatorMgr()
{
    UIView  *mContentView;
    CGRect mContentFrame;
    UIColor *mBarColor;
    NSInteger mNumberOfBars;
    CGFloat mBarWidth;
    CGFloat mBarHeight;
    CGFloat mAperture;
}

@property (nonatomic, strong) AMPActivityIndicator *spinner;

@end




@implementation JZActivityIndicatorMgr


-(instancetype)init
{
    return nil;
}

-(instancetype)initActivityIndicatorInView: (UIView*)contentView
                                 WithFrame: (CGRect)frame
                            IndicatorStyle: (eumJZActivityIndicatorStyle)style
{
    self = [super init];
    if (nil != self) {
        
        NSDictionary* defaultStyle = [self presetDicForStyle: style];
        
        mNumberOfBars = ((NSNumber*)[defaultStyle objectForKey:BarNumbersNameString]).integerValue;
        mBarWidth = ((NSNumber*)[defaultStyle objectForKey:BarWidthNameString]).floatValue;
        mBarHeight = ((NSNumber*)[defaultStyle objectForKey:BarHeightNameString]).floatValue;;
        mAperture = ((NSNumber*)[defaultStyle objectForKey:BarApertureNameString]).floatValue;;
        mBarColor = [defaultStyle objectForKey:BarColorNameString];
        
        self.spinner = [[AMPActivityIndicator alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.spinner.numberOfBars = mNumberOfBars;
        self.spinner.barWidth = mBarWidth;
        self.spinner.barHeight = mBarHeight;
        self.spinner.aperture = mAperture;
        self.spinner.barColor = mBarColor;
        
        mContentView = contentView;
        mContentFrame = frame;
    }
    return self;
}

-(void)dealloc
{
    [self hideIndicator];
    self.spinner = nil;
}



#pragma mark - property 

-(UIColor*)barColor {
    return mBarColor;
}
-(void)setBarColor:(UIColor *)barColor {
    if (nil != barColor) {
        mBarColor = barColor;
        if (nil != self.spinner) {
            [self.spinner setBarColor: barColor];
        }
    }
}

-(CGFloat)barWidth {
    return mBarWidth;
}
-(void)setBarWidth:(CGFloat)barWidth {
    if (barWidth > 0) {
        mBarWidth = barWidth;
        if (nil != self.spinner) {
            [self.spinner setBarWidth: barWidth];
        }
    }
}

-(CGFloat)barHeight {
    return mBarHeight;
}
-(void)setBarHeight:(CGFloat)barHeight {
    if (barHeight > 0) {
        mBarHeight = barHeight;
        if (nil != self.spinner) {
            [self.spinner setBarHeight: barHeight];
        }
    }
}

-(CGFloat)aperture {
    return mAperture;
}
-(void)setAperture:(CGFloat)aperture {
    if (aperture > 0) {
        mAperture = aperture;
        if (nil != self.spinner) {
            [self.spinner setAperture: aperture];
        }
    }
}




#pragma mark - show / hide

- (void)showIndicator
{
    if (nil != self.spinner) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            
            [mContentView addSubview: self.spinner];
            self.spinner.center = CGPointMake((mContentFrame.origin.x + (mContentFrame.size.width/2)),
                                              (mContentFrame.origin.y + (mContentFrame.size.height/2))) ;
            [self.spinner startAnimating];
        });
    }
}

- (void)hideIndicator
{
   //  dispatch_async(dispatch_get_main_queue(), ^(){
        if (nil != self.spinner) {
            [self.spinner stopAnimating];
            [self.spinner removeFromSuperview];
        }
    // });
}




#pragma mark - 预设参数

#define JZActivityIndicatorWhite    ColorRGBA(@"ffffffaa")
#define JZActivityIndicatorGray     ColorRGBA(@"454545aa")


-(NSDictionary*)presetDicForStyle: (eumJZActivityIndicatorStyle)style
{
    switch (style) {
        case JZActivityIndicatorStyleSystemWhite:
        {
            return @{BarNumbersNameString: @(12), BarWidthNameString:@(2.0) ,BarHeightNameString:@(5.2) ,BarApertureNameString:@(7.6) ,BarColorNameString: JZActivityIndicatorWhite};
        }
            break;
        case JZActivityIndicatorStyleSystemWhiteLarge:
        {
            return @{BarNumbersNameString: @(12), BarWidthNameString:@(2.75) ,BarHeightNameString:@(8.3) ,BarApertureNameString:@(12.85) ,BarColorNameString: JZActivityIndicatorWhite};
        }
            break;
        case JZActivityIndicatorStyleSystemGray:
        {
            return @{BarNumbersNameString: @(12), BarWidthNameString:@(2.0) ,BarHeightNameString:@(5.2) ,BarApertureNameString:@(7.6) ,BarColorNameString: JZActivityIndicatorGray};
        }
            break;
        case JZActivityIndicatorStyleSystemGrayLarge:
        {
            return @{BarNumbersNameString: @(12), BarWidthNameString:@(2.75) ,BarHeightNameString:@(8.3) ,BarApertureNameString:@(12.85) ,BarColorNameString: JZActivityIndicatorGray};
        }
            break;
        case JZActivityIndicatorStyleFairairWhite:
        {
            return @{BarNumbersNameString: @(21), BarWidthNameString:@(2.0) ,BarHeightNameString:@(2.0) ,BarApertureNameString:@(8.5) ,BarColorNameString: JZActivityIndicatorWhite};
        }
            break;
        case JZActivityIndicatorStyleFairairWhiteLarge:
        {
            return @{BarNumbersNameString: @(21), BarWidthNameString:@(3.4) ,BarHeightNameString:@(3.4) ,BarApertureNameString:@(16.5) ,BarColorNameString: JZActivityIndicatorWhite};
        }
            break;
        case JZActivityIndicatorStyleFairairGray:
        {
            return @{BarNumbersNameString: @(21), BarWidthNameString:@(2.0) ,BarHeightNameString:@(2.0) ,BarApertureNameString:@(8.5) ,BarColorNameString: JZActivityIndicatorGray};
        }
            break;
        case JZActivityIndicatorStyleFairairGrayLarge:
        {
            return @{BarNumbersNameString: @(21), BarWidthNameString:@(3.4) ,BarHeightNameString:@(3.4) ,BarApertureNameString:@(16.5) ,BarColorNameString: JZActivityIndicatorGray};
        }
            break;
            
        default:
            return @{BarNumbersNameString: @(21), BarWidthNameString:@(2.0) ,BarHeightNameString:@(2.0) ,BarApertureNameString:@(8.5) ,BarColorNameString: JZActivityIndicatorWhite};
            break;
    }
}

@end
