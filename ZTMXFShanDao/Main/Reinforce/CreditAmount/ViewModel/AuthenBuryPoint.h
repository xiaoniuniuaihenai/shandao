//
//  AuthenBuryPoint.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/23.
//  Copyright © 2017年 jibei. All rights reserved.
//  认证埋点

#import <Foundation/Foundation.h>
#import "LSAuthMaidianApi.h"

@interface AuthenBuryPoint : NSObject
/** 进入不同认证页面 埋点 */
+ (void)requestAuthBuryPointWithType:(AuthMaidianType)type;

/** 上传身份证图片埋点 */
/** type:正面身份证 1, 反面身份证 2.  results:上传成功 1, 上传失败 2  */
+ (void)requestUploadIdentityIdImageWithType:(NSString *)type result:(NSString *)result;

@end
