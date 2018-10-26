//
//  UserInfoModel.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/21.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
/** 身份证 */
@property (nonatomic, copy) NSString *idNumber;
/** 绑卡状态 */
@property (nonatomic, assign) NSInteger bankStatus;
/** 真实名字 */
@property (nonatomic, copy) NSString *realName;
/** 人脸状态 */
@property (nonatomic, assign) NSInteger faceStatus;
/** 芝麻信用认证状态：【0:未授权，-1:授权失败，1:已授权】 */
@property (nonatomic, assign) NSInteger zmStatus;
/** 白领贷认证状态：【0:未审核，-1:未通过审核，2: 审核中，1:已通过审核】 */
@property (nonatomic, assign) NSInteger whiteRisk;

@end
