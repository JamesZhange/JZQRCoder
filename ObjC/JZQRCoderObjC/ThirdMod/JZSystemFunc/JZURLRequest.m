//
//  JZUrlCreater.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 2016/12/1.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "JZURLRequest.h"







@interface JZURLRequest()
{
    NSString* mUrl;
    NSString* mMethod;
    NSMutableDictionary* mBodyDic;
}

@property (nonatomic, strong) NSString* URL;
@property (nonatomic, strong) NSString* Method;

@end






@implementation JZURLRequest

-(instancetype)init{
    self = [super init];
    if (nil != self) {
        mUrl = nil;
        mBodyDic = nil;
        mMethod = HTTPMETHOD_GET;
    }
    return self;
}

+(JZURLRequest*)requestWithURL: (NSString*)urlstr
                    httpMethod: (NSString*)method
{
    if ((nil != urlstr)
        && (nil != method))
    {
        JZURLRequest* request = [[JZURLRequest alloc] init];
        
        request.URL = urlstr;
        request.Method = method;
        
        return request;
    }
    return nil;
}


-(void)addValue:(NSString*)value forBodyParameter:(NSString*)key
{
    if ((nil != value) && (nil != key)) {
        if (nil == mBodyDic) {
            mBodyDic = [[NSMutableDictionary alloc] init];
        }
        
        [mBodyDic setObject: value forKey: key];
    }
}

-(void)removeBodyParameter:(NSString*)key
{
    if ((nil != mBodyDic) && (nil != key)) {
        [mBodyDic removeObjectForKey: key];
    }
}



#pragma mark - property

-(NSString*) URL {
    return mUrl;
}
-(void)setURL:(NSString *)URL {
    mUrl = URL;
}

-(NSString*) Method {
    return mMethod;
}
-(void)setMethod:(NSString *)Method {
    mMethod = Method;
}


-(NSURLRequest*)request {
    return [self requestWithTimeout: 15];
}

-(NSURLRequest*)requestWithTimeout:(NSTimeInterval)time {
    return [self packagingRequestWithTimeout: time];
}

-(NSURLRequest*)packagingRequestWithTimeout: (NSTimeInterval)time
{
    if (nil == mUrl) {
        return nil;
    }
    
    NSString* urlall = mUrl;
    
    if ((nil != mBodyDic) && (0 != [mBodyDic allKeys].count)) {
        NSString* bodystr = @"?";
        for (NSString* key in [mBodyDic allKeys]) {
            NSString* value = [mBodyDic objectForKey: key];
            bodystr = [bodystr stringByAppendingString: [NSString stringWithFormat: @"%@=%@&", key, value]];
        }
        
        bodystr = [bodystr substringToIndex: (bodystr.length-1)];
        
        urlall = [urlall stringByAppendingString: bodystr];
    }
    
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL: [NSURL URLWithString: urlall]];
    [request setHTTPMethod: mMethod];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval: time]; //  超时
    
    return request;
}


@end




