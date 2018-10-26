//
//  LSBankCardTypeModel.h
//  ALAFanBei
//
//  Created by Try on 2017/3/1.
//  Copyright © 2017年 讯秒. All rights reserved.
// 银行卡类型名称

#import <Foundation/Foundation.h>

@interface LSBankCardTypeModel : NSObject
/** 账号*/
@property (nonatomic,strong) NSString * rid;
/** 银行编号*/
@property (nonatomic,strong) NSString * bankCode;
/** 银行名称	*/
@property (nonatomic,strong) NSString * bankName;
/** bankIcon*/
@property (nonatomic,strong) NSString * bankIcon;
/** 银行名称   版本1.2新增 */
@property (nonatomic,strong) NSString * invalidDesc;
/** 银行状态   版本1.2新增 */
@property (nonatomic,assign) BOOL isValid;

@end
