//
//  LSSubmitWhiteLoanView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBasicsBottomView;
@class LSWhiteLoanAuthView;
@class LSAuthSupplyCertifyModel;

@protocol SubmitWhiteLoanViewDelegate <NSObject>

@optional
/** 点击社保 */
- (void)submitWhiteLoanViewClickSocialSecurity;
/** 点击公积金 */
- (void)submitWhiteLoanViewClickProvidentFund;
/** 公司电话 */
- (void)submitWhiteLoanViewClickCompanyPhone;
/** 点击运营商 */
- (void)submitWhiteLoanViewClickSlowPay;
/** 点击提交认证 */
- (void)submitWhiteLoanViewClickSubmitAuth;

@end
@interface LSSubmitWhiteLoanView : UIView
/** 提交按钮 */
@property (nonatomic, strong) ZTMXFButton *submitButton;

@property (nonatomic, weak) id<SubmitWhiteLoanViewDelegate> delegate;

@property (nonatomic, strong) LSAuthSupplyCertifyModel *whiteLoanModel;

@end
