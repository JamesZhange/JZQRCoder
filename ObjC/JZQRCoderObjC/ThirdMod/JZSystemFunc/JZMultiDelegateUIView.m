//
//  JZMultiDelegateUIView.m
//  BTArmController
//
//  Created by Liu Rui on 15/10/14.
//  Copyright © 2015年 Liu Rui. All rights reserved.
//

#import "JZMultiDelegateUIView.h"

@implementation JZMultiDelegateUIView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self initWithDispatchQueue:NULL];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self initWithDispatchQueue:NULL];
    }
    return self;
}

- (void)initWithDispatchQueue:(dispatch_queue_t)queue
{
    if (queue)
    {
        moduleQueue = queue;
    }
    else
    {
        const char *moduleQueueName = [NSStringFromClass([self class]) UTF8String];
        moduleQueue = dispatch_queue_create(moduleQueueName, NULL);
    }
    
    moduleQueueTag = &moduleQueueTag;
    dispatch_queue_set_specific(moduleQueue, moduleQueueTag, moduleQueueTag, NULL);
    
    multiDelegate = [[JZMulticastDelegate alloc] init];
}

- (dispatch_queue_t)moduleQueue
{
    return moduleQueue;
}

- (void *)moduleQueueTag
{
    return moduleQueueTag;
}

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    dispatch_block_t block = ^{
        [multiDelegate addDelegate:delegate delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(moduleQueueTag))
        block();
    else
        dispatch_async(moduleQueue, block);
}

- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue synchronously:(BOOL)synchronously
{
    dispatch_block_t block = ^{
        [multiDelegate removeDelegate:delegate delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(moduleQueueTag))
        block();
    else if (synchronously)
        dispatch_sync(moduleQueue, block);
    else
        dispatch_async(moduleQueue, block);
    
}
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    [self removeDelegate:delegate delegateQueue:delegateQueue synchronously:YES];
}

- (void)removeDelegate:(id)delegate
{
    [self removeDelegate:delegate delegateQueue:NULL synchronously:YES];
}

- (void)removeAllDelegates
{
    [multiDelegate removeAllDelegates];
}

@end
