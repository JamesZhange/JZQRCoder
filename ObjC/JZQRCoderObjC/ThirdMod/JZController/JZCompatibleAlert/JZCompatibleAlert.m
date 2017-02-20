//
//  JZCompatibleAlert.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/6/17.
//  Copyright © 2016年 Liu Rui. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "JZGlobal.h"
#import "JZCompatibleAlert.h"
#import "JZCompatibleAlertButton.h"


@interface JZCompatibleAlert()
{
    UIAlertView* mAlertview;
    UIAlertController* mAlertcontroller;
    
    NSString* mTitle;
    NSString* mMessage;
    JZCAlertControllerStyle mStyle;
    
    NSUInteger mTextfieldCount;
    
    // iOS 8
    UIAlertAction *cancelAction;
    ButtonAction mCancelButtonAct;
    
    NSMutableArray* mDefaultButtonArray;       // JZCompatibleAlertButton
    
}

@property (strong, nonatomic) UIAlertView* alertview;
@property (strong, nonatomic) UIAlertController* alertcontroller;

@end








@implementation JZCompatibleAlert

-(instancetype)init
{
    return nil;
}

-(instancetype)initWithWithTitle: (NSString*)title
                         message: (NSString*)message
                           style: (JZCAlertControllerStyle)style
{
    self = [super init];
    if (nil != self) {
        mAlertcontroller = nil;
        mAlertview = nil;
        mTextfieldCount = 0;
        
        mTitle = title;
        mMessage = message;
        mStyle = style;
        
        cancelAction = nil;
        mCancelButtonAct = nil;
        
        mDefaultButtonArray = [NSMutableArray array];
        
        if (IOS_8_OR_LATER) {
            [self alertcontroller];
        }
        else {
        }
        
    }
    return self;
}


-(UITextField*)addTextFieldWithTag: (NSInteger)tag
{
    if (IOS_8_OR_LATER) {

        [self.alertcontroller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.tag = tag;
        }];
        
        return [self textfieldWithTag: tag];
    }
    else {
        UITextField *textfield = [[UITextField alloc] init];
        textfield.tag = tag;
        return textfield;
    }
}

-(UITextField*)textfieldWithTag: (NSInteger)tag
{
    for (UITextField *textfield in self.alertcontroller.textFields) {
        if (tag == textfield.tag) {
            return textfield;
        }
    }
    return nil;
}



-(int)addCancelButtonTitle: (NSString*)title
                     action: (ButtonAction)action
{
    if (nil != cancelAction) {
        return 1;
    }
    
    mCancelButtonAct = action;
    
    if (IOS_8_OR_LATER) {
        cancelAction = [UIAlertAction actionWithTitle: title
                                                style: UIAlertActionStyleCancel
                                              handler: ^(UIAlertAction *action) {
                                                  if (nil != mCancelButtonAct) {
                                                      mCancelButtonAct();
                                                  }
                                              }];
        [self.alertcontroller addAction: cancelAction];
    }
    else
    {
        
    }
    
    return 0;
}

-(int)addDefaultButtonTitle: (NSString*)title
                     withTag: (NSInteger)tag
                      action: (ButtonAction)action
{
    for (JZCompatibleAlertButton* button in mDefaultButtonArray) {
        if (tag == button.tag) {
            return 1;
        }
    }
    
    JZCompatibleAlertButton* newbutton = [[JZCompatibleAlertButton alloc] init];
    
    if (nil != newbutton) {
        [mDefaultButtonArray addObject: newbutton];
        
        newbutton.tag = tag;
        newbutton.buttonAction = action;
        newbutton.title = title;
        
        if (IOS_8_OR_LATER) {
            newbutton.uialertaction = [UIAlertAction actionWithTitle: title
                                                               style: UIAlertActionStyleDefault
                                                             handler: ^(UIAlertAction *action) {
                                                                 
                                                                 for (JZCompatibleAlertButton* button in mDefaultButtonArray) {
                                                                     if ((button.uialertaction == action)
                                                                         && (nil != button.buttonAction))
                                                                     {
                                                                         button.buttonAction();
                                                                     }
                                                                 }
                                                                 
                                                             }];
            [self.alertcontroller addAction: newbutton.uialertaction];
        }
        else
        {
            
        }
    }
    
    return -1;
}

-(void)defaultButtonTag: (NSInteger)tag
                 enable: (BOOL)enable
{
    JZCompatibleAlertButton* button = [self defaultButtonWithTag:tag];
    if (nil != button) {
        if (IOS_8_OR_LATER) {
            button.uialertaction.enabled = enable;
        }
        else
        {
            
        }
    }
}

-(JZCompatibleAlertButton*)defaultButtonWithTag: (NSInteger)tag
{
    for (JZCompatibleAlertButton* button in mDefaultButtonArray) {
        if (button.tag == tag) {
            return button;
        }
    }
    return nil;
}



-(void)showOnViewController: (UIViewController*)viewcontroller
                   animated: (BOOL)animated
                 completion: (AlertCompletion)completion
{
    
    if (IOS_8_OR_LATER) {
        
        
        [viewcontroller presentViewController: self.alertcontroller
                                     animated: animated
                                   completion: completion];
        
    } else {
    
    
    
    }
    
}


#pragma mark - property

-(UIAlertController*)alertcontroller
{
    if (nil == mAlertcontroller) {
        mAlertcontroller = [UIAlertController alertControllerWithTitle: mTitle
                                                                message: mMessage
                                                         preferredStyle: [self uialertStyleFrom: mStyle]];
    }
    return mAlertcontroller;
}




#pragma mark - 辅助
-(UIAlertControllerStyle)uialertStyleFrom: (JZCAlertControllerStyle)jzStyle
{
    switch (jzStyle) {
            
        case JZCAlertStyleAlert:
            return UIAlertControllerStyleAlert;
            
        case JZCAlertStyleActionSheet:
        default:
            return UIAlertControllerStyleActionSheet;
    }
}




@end







