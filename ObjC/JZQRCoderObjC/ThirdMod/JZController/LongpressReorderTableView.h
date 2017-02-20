//
//  LongpressReorderTableView.h
//  AirDefenderNewUI
//
//  Created by Liu Rui on 16/3/2.
//  Copyright © 2016年 James Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LPRTableViewPressReorderDelegate <NSObject>

-(void)         table: (UITableView*)table
              Section: (NSUInteger)section
  ExchangeCellAtIndex: (NSUInteger)idx1
      withCellAtIndex: (NSUInteger)idx2;

@end





@interface LongpressReorderTableView : UITableView

@property (nonatomic) BOOL EnableLongPressGesture;
@property (nonatomic, weak) id<LPRTableViewPressReorderDelegate> longpressReorderDelegate;

@end
