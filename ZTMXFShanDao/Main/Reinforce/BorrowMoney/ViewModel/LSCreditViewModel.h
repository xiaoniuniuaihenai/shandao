//
//  LSCreditViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/3.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZTMXFUserInfoModel.h"

@protocol LSCreditViewModelDelegate<NSObject>

@optional
/** 成功获取个人信息 */
- (void)requestUserInfoDataSuccess:(ZTMXFUserInfoModel *)userInfoModel;

@end

@interface LSCreditViewModel : NSObject

@property (nonatomic, weak) id <LSCreditViewModelDelegate> delegete;

- (void)requestUserInfoData;

@end
