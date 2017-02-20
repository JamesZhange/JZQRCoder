//
//  JZStringHelper.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 15/4/14.
//  Copyright (c) 2015年 Liu Rui. All rights reserved.
//

#import "JZStringHelper.h"

@implementation JZStringHelper


+(NSString*)translatHexStringFromCharArray:(char*)charArray ArrayLength: (unsigned int)len
{
    if (NULL != charArray){
        
        NSString* outstr = @"";
        unsigned char* pu8 = (unsigned char*)charArray;
        
        for (int i=0; i<len; i++) {
            NSString* tmpstr = [NSString stringWithFormat:@"%02x", pu8[i]];
            outstr = [outstr stringByAppendingString: tmpstr];
        }
        
        return outstr;
    }
    
    return nil;
}


+(void)translatHexString: (NSString*)hexstring
             ToCharArray: (unsigned char*)charArray
             ArrayLength: (unsigned int)len
{
    if ((nil != hexstring) && (hexstring.length >= 2) && (NULL != charArray) && (len > 0)) {
        memset(charArray, 0, len);
        
        int transByteLen = (hexstring.length/2) <= len ? ((int)hexstring.length/2) : len;
        unsigned char* pu8 = (unsigned char*)charArray;
        for (int i=0; i<transByteLen; i++) {
            NSRange subRang = NSMakeRange(i*2, 2);
            NSString* substr = [hexstring substringWithRange:subRang];
            
            unsigned int anInt = 0;
            NSScanner * scanner = [[NSScanner alloc] initWithString: substr];
            [scanner scanHexInt: &anInt];
            pu8[i] = (unsigned char)anInt;
        }
    }
}



+(NSString*)translatASCIIStringFromCharArray: (char*)asciistring ArrayLength: (unsigned int)len
{
    if (NULL != asciistring){
        
        NSString* outstr = @"";
        unsigned char* pu8 = (unsigned char*)asciistring;
        
        for (int i=0; i<len; i++) {
            NSString* tmpstr = [NSString stringWithFormat:@"%c", pu8[i]];
            outstr = [outstr stringByAppendingString: tmpstr];
        }
        
        return outstr;
    }
    
    return nil;
}

+(void)translatASCIIString: (NSString*)asciistring
               ToCharArray: (unsigned char*)charArray
               ArrayLength: (unsigned int)len
{
    if ((nil != asciistring) && (asciistring.length >= 2) && (NULL != charArray) && (len > 0)) {
        memset(charArray, 0, len);
        
        int transByteLen = asciistring.length <= len ? (int)asciistring.length : len;
        
        memcpy(charArray, asciistring.UTF8String, transByteLen);
    }
}

@end
