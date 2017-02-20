//
//  LongpressReorderTableView.m
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/3/2.
//  Copyright © 2016年 James Zhang. All rights reserved.
//


#import "LongpressReorderTableView.h"



@interface LongpressReorderTableView()
{
    BOOL isEnableLongPressGesture;
    UILongPressGestureRecognizer *longPressRecognizer;
}



@end


@implementation LongpressReorderTableView

-(instancetype)init
{
    self = [super init];
    if (nil != self) {
        isEnableLongPressGesture = TRUE;
        longPressRecognizer = nil;
        [self addPressReorderGestureRecognizer];
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (nil != self) {
        isEnableLongPressGesture = TRUE;
        longPressRecognizer = nil;
        [self addPressReorderGestureRecognizer];
        
    }
    return self;
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (nil != self) {
        isEnableLongPressGesture = TRUE;
        longPressRecognizer = nil;
        [self addPressReorderGestureRecognizer];
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Property

-(BOOL)EnableLongPressGesture
{
    return isEnableLongPressGesture;
}
-(void)setEnableLongPressGesture:(BOOL)EnableLongPressGesture
{
    isEnableLongPressGesture = EnableLongPressGesture;
    
    if (YES == isEnableLongPressGesture) {
        
        [self addPressReorderGestureRecognizer];
    
    } else {
        [self removePressReorderGestureRecognizer];
    }
}




#pragma mark - press action

-(void)addPressReorderGestureRecognizer
{
    if (nil == longPressRecognizer) {
        longPressRecognizer = [[UILongPressGestureRecognizer alloc]
                               initWithTarget: self
                               action: @selector(longPressCityTableRecognized:)];
        
        [self addGestureRecognizer: longPressRecognizer];
    }
}

-(void)removePressReorderGestureRecognizer
{
    if (nil != longPressRecognizer) {
        [self removeGestureRecognizer: longPressRecognizer];
        longPressRecognizer = nil;
    }
}


- (void)longPressCityTableRecognized:(id)sender {
    
    // NSLog(@"Long Press Device TableView");
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView: self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                if ((nil != _longpressReorderDelegate)
                    && ([_longpressReorderDelegate respondsToSelector: @selector(table:Section:ExchangeCellAtIndex:withCellAtIndex:)])) {
                    [_longpressReorderDelegate table: self
                                             Section: indexPath.section
                                 ExchangeCellAtIndex: indexPath.row
                                     withCellAtIndex: sourceIndexPath.row];
                }
                
                // ... move the rows.
                [self moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                cell.hidden = NO;
                
            }];
            
            break;
        }
    }
}






#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}







@end





