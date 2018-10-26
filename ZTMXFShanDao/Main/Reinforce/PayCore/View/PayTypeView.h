//
//  PayTypeView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayChannelModel;

@protocol PayTypeViewDelegate <NSObject>

/** 点击返回按钮 */
- (void)payTypeViewClickBackButton;
/** 选择渠道支付 */
- (void)payTypeViewClickPayChannel:(PayChannelModel *)channelModel;
- (void)choiseBankCardViewAddBankCard;
@end


@interface PayTypeView : UIView

/** title */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL offlinePay;
@property (nonatomic, weak) id<PayTypeViewDelegate> delegate;
/** 选中银行卡ID */
@property (nonatomic, copy) NSString *selectBankCardId;

@end
