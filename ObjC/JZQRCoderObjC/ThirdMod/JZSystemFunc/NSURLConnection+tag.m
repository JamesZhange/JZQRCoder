//
//  NSURLConnection+tag.m
//  AirDefender
//
//  Created by Liu Rui on 14-7-4.
//  Copyright (c) 2014年 Liu Rui. All rights reserved.
//

#import "NSURLConnection+tag.h"

static const char *ConnectTagKey = "tagKey";


@implementation NSURLConnection (tag)

// get方法
- (NSNumber *) tag {
    return (NSNumber *)objc_getAssociatedObject(self, ConnectTagKey);
}
// set方法
- (void)setTag:(NSNumber *)tag {
    objc_setAssociatedObject(self, ConnectTagKey, tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
