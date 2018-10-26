//
//  ZTMXFLoanStatisticalApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"



@interface ZTMXFLoanStatisticalApi : BaseRequestSerivce
/**
 
 借款页面必填 借款流程步骤 1.借钱页面 2.消费贷认证页 3.实名认证页面 4.银行卡认证 5.芝麻认证页面 6.运营商认证页 7.审核等待页 8.确认借款页 9.商品选择页 10.支付密码输 11.借款成功页
 
 还款页面 必填 还钱流程步骤 1.借钱页面（待还款状态） 2.立即还款页面 3.支付方式选择弹窗 4.支付密码输入框 5.支付宝还款页面 6.还款反馈页面
 
 
 */
- (id)initWithLoanStatisticalCurrentPage:(int)CurrentPage previousPage:(int)previousPage residenceTime:(double)residenceTime;

@end
