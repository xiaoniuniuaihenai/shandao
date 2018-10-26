//
//  LSAuthInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAuthInfoModel : NSObject

/** 实名认证状态 【0:未认证，-1:认证失败，2:认证中，1:已通过认证】 */
@property (nonatomic,assign)  NSInteger idnumberStatus;
/** 人脸识别状态 */
@property (nonatomic,assign) NSInteger  facesStatus;
/** 办卡认证状态 */
@property (nonatomic,assign) NSInteger  bindCard;
/** 芝麻认证状态 */
@property (nonatomic,assign) NSInteger  zmStatus;
/** 当前风控认证状态【0:未认证 1已认证 2认证中 -1认证失败】*/
@property (nonatomic,assign) NSInteger  currentAuthStatus;

/** 认证（失败或成功或认证中）文案 */
@property (nonatomic, copy) NSString *authResult;
/** 红色文案 */
@property (nonatomic, copy) NSString *authRed;
/** 认证提示 */
@property (nonatomic, copy) NSString *authTips;


@end
