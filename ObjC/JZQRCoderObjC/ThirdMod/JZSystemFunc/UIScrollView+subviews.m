//
//  UIScrollView+subviews.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/3/14.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "UIScrollView+subviews.h"

@implementation UIScrollView (subviews)

-(void)removeAllSubViews
{
    for (UIView* subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end
