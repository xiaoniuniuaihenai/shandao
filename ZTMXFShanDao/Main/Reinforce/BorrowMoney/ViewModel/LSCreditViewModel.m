//
//  LSCreditViewModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/3.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCreditViewModel.h"
#import "GetUserInfoApi.h"
#import "RealNameManager.h"

@interface LSCreditViewModel ()


@end

@implementation LSCreditViewModel

- (void)requestUserInfoData{
    
    if ([LoginManager loginState]) {
        // 登录状态
        if ([self isFirstLoginInOtherDay]) {
            // 每天的第一次登录
            GetUserInfoApi *api = [[GetUserInfoApi alloc] init];
            [api requestWithSuccess:^(NSDictionary *responseDict) {
                
                NSString *codeStr = [responseDict[@"code"] description];
                if ([codeStr isEqualToString:@"1000"]) {
                    NSDictionary *dataDict = responseDict[@"data"];
                    ZTMXFUserInfoModel *userInfoModel = [ZTMXFUserInfoModel mj_objectWithKeyValues:dataDict];
                    
                    if (self.delegete && [self.delegete respondsToSelector:@selector(requestUserInfoDataSuccess:)]) {
                        [self.delegete requestUserInfoDataSuccess:userInfoModel];
                    }
                }
            } failure:^(__kindof YTKBaseRequest *request) {
                
            }];
        }
    }
}

#pragma mark - 私有方法
- (BOOL)isFirstLoginInOtherDay{
    
    NSDictionary *infoDict = [[NSUserDefaults standardUserDefaults] valueForKey:kNotAuthentication];
    if (infoDict) {
        // 如果有推送过来的认证有礼的图片
        // 现在时间
        NSString *currentTime = [self getCurrentTime];
        // 上次时间
        NSString *lastTime = [[NSUserDefaults standardUserDefaults] valueForKey:kNotAuthenticationIsPop];
        if (lastTime && lastTime.length > 0) {
            if ([lastTime isEqualToString:currentTime]) {
                // 当天登录过,不弹出认证引导框
                
            }else{
                // 第二天登录第一次，弹出认证引导框
                [[NSUserDefaults standardUserDefaults] setValue:currentTime forKey:kNotAuthenticationIsPop];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                return YES;
            }
        }else{
            // 第一次登录，弹出认证引导框
            [[NSUserDefaults standardUserDefaults] setValue:currentTime forKey:kNotAuthenticationIsPop];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            return YES;
        }
    }
    return NO;
}

#pragma mark - 获取当前时间
-(NSString*)getCurrentTime {
    
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyMMdd"];
    NSString*dateTime = [formatter stringFromDate:[NSDate date]];
    
    return dateTime;
}

@end
