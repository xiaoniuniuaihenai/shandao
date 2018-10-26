//
//  LSBorrowMenuView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSBorrowMenuViewDelegate <NSObject>

@optional

- (void)borrowMenuViewSelectBorrowDays:(NSString *)borrowDays;

@end

@interface LSBorrowMenuView : UIView

@property (nonatomic, strong) NSArray *borrowDays;
@property (nonatomic, weak  ) id <LSBorrowMenuViewDelegate> delegate;
@property (nonatomic, assign) NSUInteger currentIndex;

/** 设置当前选中天数 */
- (void)configCurrentIndex:(NSInteger)index animate:(BOOL)animate;

@end
