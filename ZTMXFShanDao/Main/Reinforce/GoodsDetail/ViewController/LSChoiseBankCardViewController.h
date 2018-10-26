//
//  LSChoiseBankCardViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"
@class BankCardModel;

@protocol ChoiseBankCardViewDelegate <NSObject>

/** 选中银行卡 */
- (void)choiseBankCardViewSelectBankCard:(BankCardModel *)bankCardModel;

@end

@interface LSChoiseBankCardViewController : BaseViewController

@property (nonatomic, weak) id<ChoiseBankCardViewDelegate> delegate;

@property (nonatomic, assign) LoanType loanType;

@end
