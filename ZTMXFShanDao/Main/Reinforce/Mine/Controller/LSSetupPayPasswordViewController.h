//
//  LSSetupPayPasswordViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  设置支付密码

#import "BaseViewController.h"

typedef enum : NSUInteger {
    InputOriginalPassword,              //  输入原生支付密码
    ModifyPasswordSetupPassword,        //  修改支付密码设置新的支付密码
    ForgetPasswordSetupPassowrd,        //  忘记密码设置新的支付密码
    
} SetupPasswordType;

@interface LSSetupPayPasswordViewController : BaseViewController

@property (nonatomic, assign) SetupPasswordType passwordType;

/** 原先支付密码 */
@property (nonatomic, copy) NSString *originalPassword;

/** 忘记支付密码的时候需要传(验证码和身份证(base64)) */
@property (nonatomic, copy) NSString *verifyCode;
/** 身份证 */
@property (nonatomic, copy) NSString *idNumber;

@end
