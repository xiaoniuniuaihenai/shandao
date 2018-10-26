//
//  PayTypePopupView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  选择支付类型弹窗

#import <UIKit/UIKit.h>
@class PayChannelModel;

@protocol PayTypePopupViewDelegate <NSObject>

@optional
/** 输入密码完成(银行卡支付) */
- (void)payTypePopupViewEnterPassword:(NSString *)password channelModel:(PayChannelModel *)channelModel;
/** 线下支付宝支付 */
- (void)payTypePopupViewAlipayWithChannelModel:(PayChannelModel *)channelModel isNewPayStyle:(NSInteger)isNewPayStyle;
/** 其他支付方式 */
- (void)payTypePopupViewOtherPayStyleWithChannelModel:(PayChannelModel *)channelModel;

/** 忘记密码 */
- (void)payTypePopupViewClickForgetPassword;

@end


@interface PayTypePopupView : UIView

/** title str */
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, assign) BOOL showOfflinePay;
@property (nonatomic, weak) id<PayTypePopupViewDelegate> delegate;

//  弹出选择分期方式view
+ (instancetype)popupView;
//  弹框取消
- (void)dismiss;

@end
