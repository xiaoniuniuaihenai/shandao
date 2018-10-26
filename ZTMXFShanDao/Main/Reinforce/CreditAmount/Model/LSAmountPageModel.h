//
//  LSAmountPageModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAmountPageModel : NSObject

@property (nonatomic, strong) NSArray *bannerList;

/** 基础认证强风控审核状态【0:未审核，-1:未通过审核，2: 审核中，1:已通过审核】(登陆后才有) */
@property (nonatomic, assign) NSInteger riskStatus;
/** 球状体描述文字 */
@property (nonatomic, copy) NSString *ballDesc;
/** 球状体里的数字描述 */
@property (nonatomic, copy) NSString *ballNum;
/** 下面按钮的提示文案 */
@property (nonatomic, copy) NSString *barreDesc;
/** 借款天数 */
@property (nonatomic, assign) NSInteger borrowDays;
/**提示文案  金额下面提示文案*/
@property (nonatomic,copy)  NSString * reminder;
//人脸识别状态【0:未认证,-1:认证失败，1:已认证】
@property (nonatomic,assign) NSInteger faceStatus;
//是否绑卡状态【0:未绑卡  1：绑卡：-1：绑卡失败】
@property (nonatomic,assign) NSInteger bindCardStatus;
@end

