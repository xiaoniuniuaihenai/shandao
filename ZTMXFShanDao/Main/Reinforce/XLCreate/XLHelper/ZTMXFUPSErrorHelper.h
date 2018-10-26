//
//  ZTMXFUPSErrorHelper.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/21.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    ZTMXFUPSErrorHelperDelayPay,          //  延期还款
    ZTMXFUPSErrorHelperPay,                //  立即还款
    ZTMXFUPSErrorHelperGetCode,            //  绑卡获取验证码
    ZTMXFUPSErrorHelperBankCardBinding      //  绑卡
} ZTMXFUPSErrorHelperType;

@interface ZTMXFUPSErrorHelper : NSObject


+ (void)showAlterWithUPSErrorHelperType:(ZTMXFUPSErrorHelperType)UPSErrorHelperType
                               ErrorDic:(NSDictionary *)UPSErrorDic
                                infoDic:(NSDictionary *)infoDic;




@end
