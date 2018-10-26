//
//  LSMallCreditInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSMallCreditInfoModel : NSObject

/**实名认证状态 【0:未认证，-1:认证失败，2:认证中，1:已通过认证】 */
@property (nonatomic,assign)  NSInteger realnameStatus;
/**办卡认证状态*/
@property (nonatomic,assign) NSInteger  bindCard;
/**芝麻认证状态*/
@property (nonatomic,assign) NSInteger  zmStatus;
/**通讯录认证状态*/
@property (nonatomic,assign) NSInteger  contactsStatus;
/**运营商认证状态*/
@property (nonatomic,assign) NSInteger  mobileStatus;
/**公司认证状态*/
@property (nonatomic,assign) NSInteger  companyStatus;
/**淘宝认证状态*/
@property (nonatomic,assign) NSInteger  taobaoStatus;
/**京东认证状态*/
@property (nonatomic,assign) NSInteger  jingdongStatus;
/**分期商城认证状态*/
@property (nonatomic,assign) NSInteger  mallStatus;


@end
