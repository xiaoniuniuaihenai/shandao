//
//  ZTMXFChooseBankViewController.h
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  选择支付方式

#import "ZTMXFTableViewController.h"

@class ZTMXFChooseBankViewController;
@protocol ZTMXFChooseBankViewControllerDelegate <NSObject>

@optional
//** 选择使用的银行卡id   -6 -4支付宝线下  >0 银行卡支付   -111  添加银行卡  */
- (void)chooseUseBankCardId:(NSString *)bankCardId;

//** 选择使用的银行卡id   -6 -4支付宝线下  >0 银行卡支付   -111  添加银行卡  */
- (void)chooseUseBankCardId:(NSString *)bankCardId bankInfoDic:(NSDictionary *)bankInfoDic;


@end


@interface ZTMXFChooseBankViewController : ZTMXFTableViewController

/** title str */
@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic, assign) BOOL showOfflinePay;

@property (nonatomic, weak) id<ZTMXFChooseBankViewControllerDelegate> delegate;
/** title str */
@property (nonatomic, copy) NSDictionary * parameters;
/**
 还款金额
 */
@property (nonatomic, copy) NSString *amountStr;
/**
 还款 REPAYMENTCASH、续借RENEWAL_PAY
 */
@property (nonatomic, copy) NSString *bizCode;
@property (nonatomic, copy) NSString *borrowId;





@end
