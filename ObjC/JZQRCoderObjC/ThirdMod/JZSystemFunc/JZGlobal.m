//
//  JZGlobal.m
//  JZQRCoderObjC
//
//  Created by Liu Rui on 2017/1/23.
//  Copyright © 2017年 James. All rights reserved.
//

#import "JZGlobal.h"



@implementation JZGlobal


//获取应用程序沙盒的Documents目录
+(NSString*)AppDocumentsPatch
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Path = [paths objectAtIndex:0];
    
    return Path;
}

+(NSString*)AppDocumentsFilePatch: (NSString*)filename
{
    return [[JZGlobal AppDocumentsPatch] stringByAppendingPathComponent: filename];
}


+(NSString*)AppCacheDirectoryPatch
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *Path = [paths objectAtIndex:0];
    return Path;
}
+(NSString*)AppCacheDirectoryFilePatch: (NSString*)filename
{
    return [[JZGlobal AppCacheDirectoryPatch] stringByAppendingPathComponent: filename];
}


@end
