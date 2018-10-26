//
//  LSCreditAuthModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BannerInfo;

@interface LSCreditAuthModel : NSObject

/** 是否走过认证的消费贷【0:未审核，-1:未通过审核，2: 审核中，1:已通过审核】 */
@property (nonatomic,assign ) NSInteger riskStatus;

/** 是否走过认证的白领贷【0:未审核，-1:未通过审核，2: 审核中，1:已通过审核】 */
@property (nonatomic,assign ) NSInteger whiteRisk;

/** 是否走过认证的消费分期【0:未审核，-1:未通过审核，2: 审核中，1:已通过审核】 */
@property (nonatomic,assign ) NSInteger mallStatus;

// 头部提示
/** 球状体描述文字 */
@property (nonatomic,copy  ) NSString * ballDesc;
/** 球状体里的数字描述 */
@property (nonatomic,copy  ) NSString * ballNum;
/** 认证总额度 */
@property (nonatomic,copy  ) NSString * ballAllNum;
/** 提示文案 */
@property (nonatomic,copy  ) NSString * reminder;

//底部广告
@property (nonatomic,strong) BannerInfo *banner;

@end

@interface BannerInfo : NSObject

/** 审核通过与否的配图路径 */
@property (nonatomic,copy  ) NSString * imageUrl;

/** 第二页名称 */
@property (nonatomic,copy  ) NSString * titleName;

/** 分类的值类型 跳转普通H5地址。如H5_URL 跳转商品详情 如GOODS_ID */
@property (nonatomic,copy  ) NSString * type;

/** type为H5_URL 则为H5链接地址 如果type为GOODS_ID则为商品id,如23 */
@property (nonatomic,copy  ) NSString * content;

/** 访问是否需要登录状态，1是，0 不需要 */
@property (nonatomic,assign ) NSInteger isNeedLogin;

@end

