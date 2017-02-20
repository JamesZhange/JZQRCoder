//
//  JZMultiDelegateUIView.h
//  BTArmController
//
//  Created by Liu Rui on 15/10/14.
//  Copyright © 2015年 Liu Rui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMulticastDelegate.h"


@interface JZMultiDelegateUIView : UIView
{
    id multiDelegate;
    dispatch_queue_t moduleQueue;
    void *moduleQueueTag;
}

@property (readonly) dispatch_queue_t moduleQueue;
@property (readonly) void *moduleQueueTag;

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end
