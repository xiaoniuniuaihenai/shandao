//
//  RealNameManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//
typedef NS_ENUM(NSInteger,RealNameProgress) {
    RealNameProgressIdf = 0, // 实名认证
    RealNameProgressBindCardMian, // 绑主卡
    RealNameProgressBindCard,   // 普通绑卡
    RealNameProgressCreditPromote, // 提升信用(显示消费贷认证页面)
    RealNameProgressSetPayPaw,  // 设置支付密码(忘记密码获取验证码页面)
    RealNameProgressCreditReplenishment, // 补充认证(显示白领嗲认证页面)
    RealNameProgressSetPayPawBackRoot, // 忘记密码获取验证码 返回根部
    RealNameProgressSetPayPawBackCurrent, // 忘记密码获取验证码 返回当前
    RealNameProgressConsumeLoan,    // 消费贷
    RealNameProgressWhiteLoan,      // 白领贷
    RealNameProgressMallLoan,       // 消费分期
    RealNameProgressZhiMaAuth,      // 芝麻信用
    RealNameProgressOperatorAuth,   // 运营商认证
    RealNameProgressCompanyAuth,    // 公司认证
    RealNameProgressSecurityAuth,   // 社保、公积金认证
    RealNameProgressSumitAuth,      // 认证表单页
    
};
#import <Foundation/Foundation.h>

@interface RealNameManager : NSObject
/**
 实名认证跳转

 @param currentVc  当前的视图控制器
 @param realProgress 进入的实名类型
 @param isSave 是否保存返回的类名
 */
+(void)realNameWithCurrentVc:(UIViewController*)currentVc andRealNameProgress:(RealNameProgress)realProgress isSaveBackVcName:(BOOL)isSave;

/**
 实名认证跳转
 
 @param currentVc  当前的视图控制器
 @param realProgress 进入的实名类型
 @param isSave 是否保存返回的类名
 */
+(void)realNameWithCurrentVc:(UIViewController*)currentVc andRealNameProgress:(RealNameProgress)realProgress isSaveBackVcName:(BOOL)isSave loanType:(LoanType)loanType;

/**
 返回
 @param superVc 当前所在的视图
 */
+(void)realNameBackSuperVc:(UIViewController*)superVc;
@end
