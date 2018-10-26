//
//  ShanDaoVerificationCodeLoginController.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"
#import "ZTMXFVerificationCodeLoginView.h"
/*验证码登录页面*/
@interface ShanDaoVerificationCodeLoginController : BaseViewController

- (instancetype)initWithType:(XL_VERIFICATION_OR_PASSWORD)type;

@end
