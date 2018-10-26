//
//  LSCreditAuthView.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPromoteCreditInfoModel;
@class LSAuthSupplyCertifyModel;
@class LSMallCreditInfoModel;

typedef NS_ENUM(NSInteger,LSCreditAuthType) {
    LSRealNameAuthType = 0, // 实名认证
    LSBindCardAuthType,     // 绑主卡
    LSZhiMaAuthType,        // 芝麻信用
    LSOperatorAuthType,     // 运营商认证
    LSCompanyAuthType,      // 公司认证
    LSSecurityAuthType,     // 社保认证
    LSFundAuthType,         // 公积金认证
    LSJingDongAuthType,     // 京东认证
    LSTaoBaoAuthType        // 淘宝认证
};

@protocol LSCreditAuthViewDelegete <NSObject>

@optional
/** 点击认证类型回调*/
- (void)clickAuthType:(LSCreditAuthType)creditAuthType;

@end

@interface LSCreditAuthView : UIView

@property (nonatomic, weak) id <LSCreditAuthViewDelegete> delegete;
/** 消费贷model */
@property (nonatomic, strong) LSPromoteCreditInfoModel *consumeLoanInfoModel;
/** 白领贷model */
@property (nonatomic, strong) LSAuthSupplyCertifyModel *whiteLoanInfoModel;
/** 消费分期model */
@property (nonatomic, strong) LSMallCreditInfoModel *mallLoanInfoModel;

@end
