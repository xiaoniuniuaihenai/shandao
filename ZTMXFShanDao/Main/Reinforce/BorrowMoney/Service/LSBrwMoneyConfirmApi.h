//
//  LSBrwMoneyConfirmApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  借钱申请 确认

#import "BaseRequestSerivce.h"

@interface LSBrwMoneyConfirmApi : BaseRequestSerivce
-(instancetype)initWithBrwMoneyConfirmWithAmount:(NSString*)amount andDay:(NSString*)borrowDays andPwd:(NSString*)pwd andLatitude:(NSString*)latitude andLongitude:(NSString*)longitude andProvince:(NSString*)province andCity:(NSString*)city andCounty:(NSString*)county andAddress:(NSString*)address  borrowType:(NSString *)borrowType borrowUse:(NSString *)borrowUse goodsPrice:(NSString *)goodsPrice goodsId:(NSString *)goodsId couponId:(NSString *)couponId;
@end
