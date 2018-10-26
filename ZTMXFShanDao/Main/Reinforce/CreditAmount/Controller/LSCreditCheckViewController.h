//
//  LSCreditCheckViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/20.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  信用认证等待中

#import "BaseViewController.h"

@interface LSCreditCheckViewController : BaseViewController
@property (nonatomic,assign) NSInteger  animationTime;
@property (nonatomic,assign) BOOL isJumpPage;// 是否要跳转
@property (nonatomic,strong) NSDictionary *creditDict;
@end
