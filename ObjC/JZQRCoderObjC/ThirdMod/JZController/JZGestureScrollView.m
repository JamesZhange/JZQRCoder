//
//  JZGestureScrollView.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/25.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZGestureScrollView.h"

#define XSpaceFromScreenEdge    30



#define DebugLog    NSLog
// #define DebugLog


@interface JZGestureScrollView()
{
    NSMutableArray* mIgnoreCancelClass;
}

@end


@implementation JZGestureScrollView

-(instancetype)init
{
    self = [super init];
    if (nil != self) {
        [self initParameters];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (nil != self) {
        [self initParameters];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (nil != self) {
        [self initParameters];
    }
    return self;
}


-(void)initParameters
{
    _recognizeArea = JZGestureScrollPanArea_All;
    
    _recognizeSysPop = JZScrollShouldPopWhen_Never;
    
    mIgnoreCancelClass = [NSMutableArray array];
    self.canCancelContentTouches = YES; // scroll 是否能取消之前发送给contentview的touch消息
    self.delaysContentTouches = YES; // scroll 是否要延迟一段时间(这段时间内判断操作是否应该被自身拦截下来)再传给 Contentview
}



#pragma mark - 解决scrollview 与系统 pop 手势冲突问题

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    DebugLog(@"gesture: <%@>  should simultaneously other gesture: <%@>", [[gestureRecognizer class] description], [[otherGestureRecognizer class] description]);
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]])
    {
        if (JZScrollShouldPopWhen_AnyPage == _recognizeSysPop) {
            DebugLog(@"Simultaneously 1 YES");
            
            [gestureRecognizer requireGestureRecognizerToFail: otherGestureRecognizer]; // 阻止scrollview 在返回的过程中同时滚动
            
            return YES;
        } else if (JZScrollShouldPopWhen_LeftMost == _recognizeSysPop){
            if (self.contentOffset.x <= 0) {
                DebugLog(@"Simultaneously 2 YES");
                
                [gestureRecognizer requireGestureRecognizerToFail: otherGestureRecognizer]; // 阻止scrollview 在返回的过程中同时滚动
                
                return YES;
            }
        }
    }
    
    // else
    DebugLog(@"Simultaneously NO");
    return NO;
}



#pragma mark - 控制拖动的响应区域

#if true

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    DebugLog(@"gesture: <%@>  should begin", [[gestureRecognizer class] description]);

    //---- 获得当前拖动区域，根据配置的期望区域决定是否能够响应 ----
    
    // if (gestureRecognizer == self.panGestureRecognizer)
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        
        UIGestureRecognizerState state = gestureRecognizer.state;
        if (UIGestureRecognizerStateBegan == state
            || UIGestureRecognizerStatePossible == state) {
            
            CGPoint location = [gestureRecognizer locationInView:self];
            
            if (JZGestureScrollPanArea_Edge == _recognizeArea) {
                if (YES == [self isGestureAtEdgelocationPoint: location]) {
                    DebugLog(@"panGesture ShouldBegin 1 YES");
                    return YES;
                } else {
                    DebugLog(@"panGesture ShouldBegin 2 NO");
                    return NO;
                }
            } else if (JZGestureScrollPanArea_Center == _recognizeArea) {
                if (NO == [self isGestureAtEdgelocationPoint: location]) {
                    DebugLog(@"panGesture ShouldBegin 3 YES");
                    return YES;
                } else {
                    DebugLog(@"panGesture ShouldBegin 4 NO");
                    return NO;
                }
            } else {
                DebugLog(@"panGesture ShouldBegin 5 YES");
                return YES;
            }
        }
    }
    
    BOOL superReture = [super gestureRecognizerShouldBegin: gestureRecognizer];
    DebugLog(@"super return: %@", superReture?@"YES":@"NO");
    return superReture;
}


#endif





#pragma mark - scroll 子页面触控响应延迟的解决

-(void)addIgnoreCancelTouchesSubviewClass: (Class)subviewclass
{
    if (nil != subviewclass) {
        
        [mIgnoreCancelClass addObject: subviewclass];
        
        self.canCancelContentTouches = YES;
        self.delaysContentTouches = NO;
    }
}

-(void)removeIgnoreCancelTouchesSubviewClass: (Class)subviewclass
{
    if (nil != subviewclass) {
        for (Class ignorclass in mIgnoreCancelClass) {
            if (ignorclass == subviewclass) {
                [mIgnoreCancelClass removeObject: ignorclass];
                break;
            }
        }
        
        if (0 == mIgnoreCancelClass.count) {
            self.canCancelContentTouches = YES;
            self.delaysContentTouches = YES;
        }
    }
}


-(BOOL)touchesShouldCancelInContentView:(UIView *)view{

    DebugLog(@"touchesShouldCancelInContentView: <%@>", [[view class] description]);
    
    for (Class ignorclass in mIgnoreCancelClass) {
        if ([view isKindOfClass: ignorclass]) {
            
            DebugLog(@"return NO");
            return NO;
        }
    }
    
    BOOL superShouldCancel = [super touchesShouldCancelInContentView:view];
    DebugLog(@"superShouldCancel: %@", superShouldCancel?@"YES":@"NO");
    return superShouldCancel;
}



#pragma mark - helper function


-(BOOL)isGestureAtEdgelocationPoint: (CGPoint)location
{
    if (YES == [self isGestureAtLeftEdgelocationPoint: location]) {
        return YES;
    } else if (YES == [self isGestureAtRightEdgelocationPoint: location]) {
        return YES;
    }
    
    // NSLog(@"scrollRect: x: %0.2f, y: %0.2f, w: %0.2f, h: %0.2f, location x at: %0.2f , at edge -- NO", scrollRect.origin.x, scrollRect.origin.y, scrollRect.size.width, scrollRect.size.height, location.x);
    return NO;
}

-(BOOL)isGestureAtLeftEdgelocationPoint: (CGPoint)location
{
    CGRect scrollRect = self.frame;
    
    if ([self floatModDividend:location.x Divisor:scrollRect.size.width] <= XSpaceFromScreenEdge) {
        
        // NSLog(@"scrollRect: x: %0.2f, y: %0.2f, w: %0.2f, h: %0.2f, location x at: %0.2f , at edge -- YES", scrollRect.origin.x, scrollRect.origin.y, scrollRect.size.width, scrollRect.size.height, location.x);
        
        return YES;
    }
    return NO;
}

-(BOOL)isGestureAtRightEdgelocationPoint: (CGPoint)location
{
    CGRect scrollRect = self.frame;
    
    if ([self floatModDividend:location.x Divisor:scrollRect.size.width] >= (self.bounds.size.width - XSpaceFromScreenEdge)) {
        
        // NSLog(@"scrollRect: x: %0.2f, y: %0.2f, w: %0.2f, h: %0.2f, location x at: %0.2f , at edge -- YES", scrollRect.origin.x, scrollRect.origin.y, scrollRect.size.width, scrollRect.size.height, location.x);
        
        return YES;
    }
    return NO;
}


-(CGFloat)floatModDividend: (CGFloat)dividend
                   Divisor: (CGFloat)divisor
{
    CGFloat mod = dividend;
    
    while (mod > divisor) {
        mod -= divisor;
    }
    // NSLog(@"float mode %0.2f %% %0.2f = %0.2f", dividend, divisor, mod);
    return mod;
}

@end





