//
//  CertificationProssView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    CertificationProssIdCard,       //身份证
    CertificationProssBankCard,     // 银行卡
    CertificationProssZhiMa,   //芝麻信用授权
    CertificationProssOperator   //运营商
} CertificationProssType;


@interface CertificationProssView : UIView

@property (nonatomic, assign)CertificationProssType  prossType;

@end
