//
//  AuthenBuryPoint.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/23.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "AuthenBuryPoint.h"
#import "LSUploadIdfImgeResultApi.h"

@implementation AuthenBuryPoint


/** 上传身份证图片埋点 */
/** type:正面身份证 1, 反面身份证 2.  results:上传成功 1, 上传失败 2  */
+ (void)requestUploadIdentityIdImageWithType:(NSString *)type result:(NSString *)result{
    LSUploadIdfImgeResultApi * resultMaiApi = [[LSUploadIdfImgeResultApi alloc]initUploadWithType:type andResult:result];
    [resultMaiApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}
/** 进入不同认证页面 埋点 */
+ (void)requestAuthBuryPointWithType:(AuthMaidianType)type{
    LSAuthMaidianApi * authMaidianApi = [[LSAuthMaidianApi alloc]initWithType:type];
    [authMaidianApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"提交成功");
    } failure:^(__kindof YTKBaseRequest *request) {
    }];
}
@end
