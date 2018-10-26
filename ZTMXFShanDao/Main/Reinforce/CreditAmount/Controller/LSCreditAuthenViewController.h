//
//  LSCreditAuthenViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    ConsumeCreditAuthen,    //  消费贷认证
    WhiteCreditAuthen,      //  白领贷认证
} CreditAuthenType;

@interface LSCreditAuthenViewController : BaseViewController

@property (nonatomic, assign) CreditAuthenType authenType;

@end
