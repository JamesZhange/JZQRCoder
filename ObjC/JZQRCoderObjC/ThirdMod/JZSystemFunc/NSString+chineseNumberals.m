//
//  NSString+chineseNumberals.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/7/7.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import "NSString+chineseNumberals.h"

@implementation NSString (chineseNumberals)


- (NSString *)arabicNumberalsFromChineseNumber
{
    
    NSMutableDictionary * mdic =[[NSMutableDictionary alloc]init];
    
    
    
    [mdic setObject:[NSNumber numberWithInt:10000] forKey:@"万"];
    
    [mdic setObject:[NSNumber numberWithInt:1000] forKey:@"千"];
    
    [mdic setObject:[NSNumber numberWithInt:100] forKey:@"百"];
    
    [mdic setObject:[NSNumber numberWithInt:10] forKey:@"十"];
    
    
    
    [mdic setObject:[NSNumber numberWithInt:9] forKey:@"九"];
    
    [mdic setObject:[NSNumber numberWithInt:8] forKey:@"八"];
    
    [mdic setObject:[NSNumber numberWithInt:7] forKey:@"七"];
    
    [mdic setObject:[NSNumber numberWithInt:6] forKey:@"六"];
    
    [mdic setObject:[NSNumber numberWithInt:5] forKey:@"五"];
    
    [mdic setObject:[NSNumber numberWithInt:4] forKey:@"四"];
    
    [mdic setObject:[NSNumber numberWithInt:3] forKey:@"三"];
    
    [mdic setObject:[NSNumber numberWithInt:2] forKey:@"二"];
    
    [mdic setObject:[NSNumber numberWithInt:2] forKey:@"两"];
    
    [mdic setObject:[NSNumber numberWithInt:1] forKey:@"一"];
    
    [mdic setObject:[NSNumber numberWithInt:0] forKey:@"零"];
    
    
    
    //    NSLog(@"%@",mdic);
    
    
    BOOL flag=YES;//yes表示正数，no表示负数
    
    NSString * s=[self substringWithRange:NSMakeRange(0, 1)];
    
    if([s isEqualToString:@"负"]){
        
        flag=NO;
        
    }
    
    int i=0;
    
    if(!flag){
        
        i=1;
        
    }
    
    int sum=0;//和
    
    int num[20];//保存单个汉字信息数组
    
    for(int i=0;i<20;i++){//将其全部赋值为0
        
        num[i]=0;
        
    }
    
    int k=0;//用来记录数据的个数
    
    
    
    //如果是负数，正常的数据从第二个汉字开始，否则从第一个开始
    
    for(;i<[self length];i++){
        
        NSString * key=[self substringWithRange:NSMakeRange(i, 1)];
        
        int tmp=[[mdic valueForKey:key] intValue];
        
        num[k++]=tmp;
        
    }
    
    //将获得的所有数据进行拼装
    
    for(int i=0;i<k;i++){
        
        if(num[i]<10&&num[i+1]>=10){
            
            sum+=num[i]*num[i+1];
            
            i++;
            
        }else{
            
            sum+=num[i];
            
        }
        
    }
    
    NSMutableString * result=[[NSMutableString alloc]init];;
    
    if(flag){//如果正数
        
        NSLog(@"%d",sum);
        
        result=[NSMutableString stringWithFormat:@"%d",sum];
        
    }else{//如果负数
        
        NSLog(@"-%d",sum);
        
        result=[NSMutableString stringWithFormat:@"-%d",sum];
        
    }
    
    return result;
    
}



- (int)integerNumberalsFromChineseNumber
{
    NSString* arabicNumber = [self arabicNumberalsFromChineseNumber];
    if ((nil != arabicNumber) && (0 != arabicNumber.length)) {
        int value = [arabicNumber intValue];
        
        return value;
    }
    return NSSTINGCHINESENUMBERINVALDINTVALUE;
}



@end
