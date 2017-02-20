//
//  JZMultiDelegateObject.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/3/16.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZMulticastDelegate.h"

@interface JZMultiDelegateObject : NSObject
{
    id multiDelegate;
    dispatch_queue_t moduleQueue;
    void *moduleQueueTag;
}

@property (readonly) dispatch_queue_t moduleQueue;
@property (readonly) void *moduleQueueTag;

- (id)init;
- (id)initWithDispatchQueue:(dispatch_queue_t)queue;

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)addDelegateInMainQueue:(id)delegate;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate;
- (void)removeAllDelegates;

@end
