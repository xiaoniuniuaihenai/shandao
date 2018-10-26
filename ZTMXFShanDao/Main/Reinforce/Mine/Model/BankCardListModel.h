//
//  BankCardListModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardListModel : NSObject

/** 银行卡列表 */
@property (nonatomic, strong) NSArray *bankCardList;

/** 绑卡状态 */
@property (nonatomic, assign) NSInteger bankCardStatus;

/** 真实姓名 */
@property (nonatomic, copy) NSString *realName;
/** 身份证号 */
@property (nonatomic, copy) NSString *idNumber;
/** 人脸识别状态  1：已认证，0：未认证 */
@property (nonatomic, assign) NSInteger faceStatus;

@end
