//
//  MobileRechargeInfoViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MobileRechargeInfoModel;
@class CreateRechargeOrderInfoModel;
@interface ZTMXFMobileRechargeInfoViewModel : NSObject
@property (nonatomic, weak) id delegate;

/**
 充值列表

 @param province 城市
 @param company 运营商
 */
-(void)requestRechargeInfoWithProvince:(NSString *)province company:(NSString*)company;
-(void)requestCreateRechargeOrderWithOrderInfoModel:(CreateRechargeOrderInfoModel *)orderInfoModel;
@end
@protocol MobileRechargeInfoViewModelDelegate <NSObject>

/** 获取充值列表成功 */
- (void)requestRechargeInfoSuccess:(MobileRechargeInfoModel *)rechargeInfoModel;

/**
 生成充值订单成功

 @param  orederInfoModel 订单详情
 */
- (void)requestCreateRechargeOrderSuccess:(CreateRechargeOrderInfoModel *)orederInfoModel;

@end
