//
//  JZCopyableLabel.m
//  AirDefender
//
//  Created by Liu Rui on 15/12/24.
//  Copyright © 2015年 Liu Rui. All rights reserved.
//

#import "JZCopyableLabel.h"

@implementation JZCopyableLabel

//绑定事件
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.PasteboardString = nil;
        [self attachTapHandler];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        self.PasteboardString = nil;
        [self attachTapHandler];
    }
    return self;
}

-(void)awakeFromNib {
    
    [super awakeFromNib];
    [self attachTapHandler];
}



-(BOOL)canBecomeFirstResponder {
    
    return YES;
}

// 可以响应的方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return (action == @selector(copy:));
}

//针对于响应方法的实现
-(void)copy:(id)sender {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    if (nil != self.PasteboardString) {
        pboard.string = self.PasteboardString;
    } else {
        pboard.string = self.text;
    }
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}


-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    [self becomeFirstResponder];
    
    // UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制"
    //                                                  action:@selector(copy:)];
    // [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
}


@end
