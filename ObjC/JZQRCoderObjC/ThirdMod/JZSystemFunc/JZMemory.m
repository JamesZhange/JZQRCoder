//
//  JZMemory.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/4/13.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "JZMemory.h"

@interface JZMemory()
{
    Byte *allocAddr;
    Byte *alignAddr;
}

@end


@implementation JZMemory

-(id)init
{
    return nil;
}
-(id)initSize: (NSUInteger)size align:(eumJZMAlignSize)align
{
    if ((size <= 0) || ((align != AlignSize_Random)
                        && (align != AlignSize_2byte)
                        && (align != AlignSize_4byte)
                        && (align != AlignSize_8byte)
                        && (align != AlignSize_16byte)))
    {
        return nil;
    }
    
    
    self = [super init];
    if (nil != self) {
        
        allocAddr = NULL;
        alignAddr = NULL;
        _memoryLen = size;
        
        allocAddr = malloc(size + align);
        
        if (NULL != allocAddr) {
            
            NSInteger mask = ~0;
            mask <<= align;
            
            alignAddr = (Byte*)(((NSInteger)(allocAddr)) & mask);
        } else {
            return nil;
        }
    }
    
    return self;
}


-(void)dealloc
{
    if (NULL != allocAddr) {
        free(allocAddr);
        allocAddr = NULL;
        alignAddr = NULL;
    }
}


#pragma mark - property

-(Byte*)memory
{
    return alignAddr;
}


@end
