//
//  ShanDaoCheckLoginViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  校验登录

#import "BaseViewController.h"
/*可信登录*/
@interface ShanDaoCheckLoginViewController : BaseViewController

/** 手机号 */
@property (nonatomic, copy) NSString *phoneNumber;
/** 密码 */
@property (nonatomic, copy) NSString *password;

@end
