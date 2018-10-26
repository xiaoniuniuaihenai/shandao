//
//  MobileRechargeInfoView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  手机充值信息

#import <UIKit/UIKit.h>
@class CreateRechargeOrderInfoModel;
@class MobileRechargeInfoModel;
@interface MobileRechargeInfoView : UIView
-(instancetype)initWithDelegate:(id)delegate;
/**可充值信息 */
@property (nonatomic,strong) MobileRechargeInfoModel * rechargeInfoModel;
@end
@protocol MobileRechargeInfoViewDelegate <NSObject>

/**
 充值手机号变更

 @param province 城市  浙江
 @param company 运营商 移动
 */
-(void)changeMobileInfoWithProvince:(NSString *)province company:(NSString*)company;

/**
 创建充值订单

 @param orderInfoModel 充值信息
 */
-(void)createMobileRechargeOrder:(CreateRechargeOrderInfoModel *)orderInfoModel;
@end
