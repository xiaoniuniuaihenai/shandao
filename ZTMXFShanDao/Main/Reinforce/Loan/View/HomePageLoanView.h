//
//  HomePageLoanView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageLoanView;
@class LSBorrowHomeInfoModel;

typedef enum : NSUInteger {
    ConsumeLoanViewType,
    WhiteLoanViewType,
} LoanViewType;

@protocol HomePageLoanViewDelegate <NSObject>

/** 点击借钱 */
- (void)homePageLoanViewClickBorrowMoney:(HomePageLoanView *)loanView loanAmount:(NSString *)amount loanDays:(NSString *)days;
/** 白领贷点击title */
- (void)homePageLoanViewClickWhiteLoanTitle:(HomePageLoanView *)loanView loanAmount:(NSString *)amount loanDays:(NSString *)days;

@end

@interface HomePageLoanView : UIView

/** 借钱首页model */
@property (nonatomic, strong) LSBorrowHomeInfoModel *homeInfoModel;

@property (nonatomic, weak) id<HomePageLoanViewDelegate> delegate;

- (instancetype)initWithLoanType:(LoanViewType)loanViewType;

/** 设置title */
- (void)configLoanTitle:(NSString *)title;
/** 设置title ICON */
- (void)configLoanTitleIcon:(NSString *)titleIcon;
/** 设置title 描述 */
- (void)configTitleDescribe:(NSString *)describe;

@end
