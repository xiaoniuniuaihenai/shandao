//
//  LSUserInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFUserInfoModel : NSObject

/** 身份证 */
@property (nonatomic, copy) NSString *idNumber;
/** 绑卡状态 */
@property (nonatomic, assign) NSInteger bankStatus;
/** 真实名字 */
@property (nonatomic, copy) NSString *realName;
/** 人脸状态 */
@property (nonatomic, assign) NSInteger faceStatus;
/** 强风控状态 */
@property (nonatomic, assign) NSInteger riskStatus;

@end
