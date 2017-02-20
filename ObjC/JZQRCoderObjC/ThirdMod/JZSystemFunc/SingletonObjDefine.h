//
//  SingletonObjDefine.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/3/13.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#ifndef AirDefenderNewUI_SingletonObjDefine_h
#define AirDefenderNewUI_SingletonObjDefine_h


// 单实例宏

// 头文件使用
#define SYNTHESIZE_SINGLETON_FOR_HEADER(className)  \
                                                    \
+ (className *)shared##className;


// implement使用
#define SYNTHESIZE_SINGLETON_FOR_CLASS(className)   \
                                                    \
+ (className *)shared##className {                  \
    static className *shared##className = nil;      \
    static dispatch_once_t onceToken;               \
    dispatch_once(&onceToken, ^{                    \
        shared##className = [[self alloc] init];    \
    });                                             \
    return shared##className;                       \
}



// james
#define APPInstance(className)  \
\
[className shared##className]


#endif
