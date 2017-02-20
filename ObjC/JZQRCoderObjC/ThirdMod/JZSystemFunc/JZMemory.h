//
//  JZMemory.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/4/13.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(unsigned int, eumJZMAlignSize) {
    AlignSize_Random = 0,
    AlignSize_2byte = 1,
    AlignSize_4byte = 2,
    AlignSize_8byte = 3,
    AlignSize_16byte = 4,
    
};




@interface JZMemory : NSObject

@property (nonatomic, readonly) Byte* memory;
@property (nonatomic, readonly) NSUInteger memoryLen;   // 这个len是用户申请使用的长度，不是内部实际malloc的长度

-(id)initSize: (NSUInteger)size align:(eumJZMAlignSize)align;


@end
