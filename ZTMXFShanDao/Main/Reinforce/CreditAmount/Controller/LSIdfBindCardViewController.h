//
//  LSIdfBindCardViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  绑定银行卡
typedef NS_ENUM(NSInteger,BindBankCardType) {
    BindBankCardTypeCommon = 0,// 普通绑卡
    BindBankCardTypeMain  ,  //绑主卡
};
#import "BaseViewController.h"

@interface LSIdfBindCardViewController : BaseViewController
@property (nonatomic,assign) BindBankCardType  bindCardType;

/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

/** 是否我的页面进入 */
@property (nonatomic, assign) BOOL isAddBankCard;

/** 是否签约页面进入 */
@property (nonatomic, assign) BOOL isSigning;

@end
