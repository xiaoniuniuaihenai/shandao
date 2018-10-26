//
//  ZTMXFCertificationResultViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@interface ZTMXFCertificationResultViewController : BaseViewController

@property (nonatomic, assign)BOOL isSuccessful;

/** 认证描述 */
@property (nonatomic, copy) NSString *authDescribe;
/** 额度 */
@property (nonatomic, copy) NSString *creditAmount;

@end
