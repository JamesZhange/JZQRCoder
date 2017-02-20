//
//  JZCompatibleAlert.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/6/17.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JZCAlertControllerStyle) {
    JZCAlertStyleActionSheet = 0,
    JZCAlertStyleAlert
};

typedef void (^ButtonAction)(void);
typedef void (^AlertCompletion)(void);







@interface JZCompatibleAlert : NSObject


-(instancetype)initWithWithTitle: (NSString*)title
                         message: (NSString*)message
                           style: (JZCAlertControllerStyle)style;
-(UITextField*)addTextFieldWithTag: (NSInteger)tag;
-(UITextField*)textfieldWithTag: (NSInteger)tag;

-(int)addCancelButtonTitle: (NSString*)title
                     action: (ButtonAction)action;

-(int)addDefaultButtonTitle: (NSString*)title
                     withTag: (NSInteger)tag
                      action: (ButtonAction)action;
-(void)defaultButtonTag: (NSInteger)tag
                 enable: (BOOL)enable;

-(void)showOnViewController: (UIViewController*)viewcontroller
                   animated: (BOOL)animated
                 completion: (AlertCompletion)completion;

@end
