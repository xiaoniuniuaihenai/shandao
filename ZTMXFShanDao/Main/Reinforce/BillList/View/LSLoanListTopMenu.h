//
//  LSLoanListTopMenu.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/9.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSLoanListTopMenuDelegate <NSObject>

@optional
- (void)uploadLoanListDataWithIndex:(NSInteger)index;// 更新我的账单数据

@end

@interface LSLoanListTopMenu : UIView

@property (nonatomic, assign) NSInteger currentMenuIndex;

@property (nonatomic, strong) NSArray *menuList;

@property (nonatomic, weak) id <LSLoanListTopMenuDelegate> delegate;

@end





