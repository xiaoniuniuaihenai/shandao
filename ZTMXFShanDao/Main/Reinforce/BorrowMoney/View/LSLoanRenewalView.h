//
//  LSLoanRenewalView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBrwRenewalaInfoModel;
@class BankCardModel;

@protocol LSLoanRenewalViewDelegate<NSObject>

/** 点击延期还款按钮 */
- (void)renewalPoundageRate:(NSString *)poundageRate;

@end


@interface LSLoanRenewalView : UIScrollView

@property (nonatomic, weak) id<LSLoanRenewalViewDelegate> loanRenewalViewDelegate;
/** 支付金额 */
@property (nonatomic, copy) NSString                  *payAmount;

/** 还款金额 */
@property (nonatomic, copy) NSString                  *totalRepaymentCapitalAmount;
/** 延期金额 */
@property (nonatomic, copy) NSString                  *renewalAmount;
/** 延期还款本金 */
@property (nonatomic, copy) NSString                  *renewalCapitalAmount;
/** 当前额度延期还款本金利率 */
@property (nonatomic, copy) NSString               *currentPoundageRate;

/** 延期还款页面信息Model */
@property (nonatomic, strong) LSBrwRenewalaInfoModel    *renewalInfoModel;
/** 选中银行卡Model */
//@property (nonatomic, strong) BankCardModel             *selectedBankCard;
/**
 再次尝试 调起银行卡列表 134版本
 */
//- (void)bankCardViewAction;


@end
