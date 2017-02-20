//
//  JZGestureScrollView.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/4/25.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//
//  这里的改动只是针对左右滑动的scroll !!!!
//
//  可以选择左右滑动的手势识别区域（边缘、全部）
//
//  可以选择在什么情况下识别系统导航栏的左侧屏幕边沿轻扫返回
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(int, eumJZScrollPanArea)
{
    JZGestureScrollPanArea_Edge = 1,
    JZGestureScrollPanArea_Center = 1<<1,
    JZGestureScrollPanArea_All = (JZGestureScrollPanArea_Edge | JZGestureScrollPanArea_Center)   // default
};


typedef NS_ENUM(int, eumJZScrollShouldPopWhen)
{
    JZScrollShouldPopWhen_Never = 0,    // default
    JZScrollShouldPopWhen_LeftMost,
    JZScrollShouldPopWhen_AnyPage,
};


@interface JZGestureScrollView : UIScrollView

@property (nonatomic) eumJZScrollPanArea        recognizeArea;
@property (nonatomic) eumJZScrollShouldPopWhen  recognizeSysPop;

// 如果希望响应系统的左侧轻扫pop，则需要绑定在 navigationController上的 screenEdgePanGestureRecognizer，否则自身的滚动会同时发生
// ？？
// 暂时用 [gestureRecognizer requireGestureRecognizerToFail: otherGestureRecognizer]; 给绕过了，感觉是一个意思，但不知道会不会有其他问题


-(void)addIgnoreCancelTouchesSubviewClass: (Class)subviewclass;
-(void)removeIgnoreCancelTouchesSubviewClass: (Class)subviewclass;

@end
