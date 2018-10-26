//
//  LSSubmitConsumeLoanView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBasicsBottomView;
@class LSBaseAuthView;
@class LSPromoteCreditInfoModel;

@protocol SubmitConsumeLoanViewDelegate <NSObject>

@optional
/** 点击芝麻信用 */
- (void)submitConsumeLoanViewClickZhiMaCredit;
/** 点击运营商 */
- (void)submitConsumeLoanViewClickPhoneOperation;
/** 点击慢必赔 */
- (void)submitConsumeLoanViewClickSlowPay;
/** 点击提交认证 */
- (void)submitConsumeLoanViewClickSubmitAuth;

@end

@interface LSSubmitConsumeLoanView : UIView
/** 提交按钮 */
@property (nonatomic, strong) ZTMXFButton *submitButton;

@property (nonatomic, weak) id<SubmitConsumeLoanViewDelegate> delegate;

@property (nonatomic, strong) LSPromoteCreditInfoModel *consumeLoanInfoModel;

@end
