//
//  PaymentOrderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderPayDetailModel;
@class BankCardModel;

//  订单支付方式(分期支付, 银行卡支付)
typedef enum : NSUInteger {
    MallOrderInstallmentPayType,
    MallOrderBankCardPayType,
} MallOrderPayType;

@protocol PaymentOrderViewDelegate <NSObject>
@optional
/** 点击支付 */
- (void)paymentOrderViewClickPayWithNper:(NSInteger)nper orderPayType:(MallOrderPayType)payType;
/** 点击消费分期认证 */
- (void)paymentOrderViewClickMallAuth;
/** 点击添加银行卡 */
- (void)paymentOrderViewClickAddBankCard;
/** 点击合作协议 */
- (void)clickMallCooperateProtocol;
/** 点击借款协议 */
- (void)clickMallPayProtocol;

@end

@interface PaymentOrderView : UIView

@property (nonatomic, weak) id<PaymentOrderViewDelegate> delegate;

@property (nonatomic, strong) OrderPayDetailModel *orderPayDetailModel;

@property (nonatomic, strong) BankCardModel *bankCardModel;

/** 当前分期数 */
@property (nonatomic, strong) NSString *currentNper;

@end
