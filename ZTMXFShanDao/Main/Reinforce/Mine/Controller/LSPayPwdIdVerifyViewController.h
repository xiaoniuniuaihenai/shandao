//
//  LSPayPwdIdVerifyViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  支付密码验证身份证

#import "BaseViewController.h"

@interface LSPayPwdIdVerifyViewController : BaseViewController

/** 用户名字 */
@property (nonatomic, copy) NSString *userName;
/** 忘记支付密码设置新的密码的时候需要使用  验证码*/
@property (nonatomic, copy) NSString *verifyCode;

@end
