//
//  LSBorrwingCashInfoModel.h
//  ALAFanBei
//
//  Created by Try on 2017/3/27.
//  Copyright © 2017年 讯秒. All rights reserved.
//  确认借钱

#import <Foundation/Foundation.h>
@class GoodsInfoModel;
@class CounponModel;
@interface LSBorrwingCashInfoModel : NSObject
/** 是否绑卡【0:未绑卡  1：绑卡：-1：绑卡失败】*/
@property (nonatomic,assign) NSInteger isBind;
/** 上传身份证状态【0:未认证,-1:认证失败，1:已认证  临时状态 2.正面成功 ，3 正面失败 4反面成功 5.反面失败】 暂时无用	*/
@property (nonatomic,assign) NSInteger idNumberStatus;
/** 真实姓名*/
@property (nonatomic,copy) NSString * realName;
/** 身份证号 BASE64加过密的*/
@property (nonatomic,copy) NSString * idNumber;
/** 风控认为可借钱状态/认证状态：【0：未认证，1：已经认证， -1：认证失败】*/
@property (nonatomic, assign) NSInteger authStatus;
/** 白领贷认为可借钱状态/认证状态：【0：未认证，1：已经认证， -1：认证失败】 */
@property (nonatomic, assign) NSInteger whiteStatus;
/** 人脸识别状态【0:未认证,-1:认证失败，1:已认证】*/
@property (nonatomic,assign) NSInteger faceStatus;

/** 芝麻认证【0:未授权，-1:授权失败，1:已授权】 */
@property (nonatomic, assign) NSInteger zmStatus;
/** 公司认证【0：未认证，1：已经认证， -1：认证失败, 2:认证中】 */
@property (nonatomic, assign) NSInteger companyStatus;
/** 通讯录认证【0:未认证,1:已认证,-1:认证失败】 */
@property (nonatomic, assign) NSInteger contactsStatus;
/** 运营商认证【0:未认证,2:认证中,1:已认证,-1:认证失败】 */
@property (nonatomic, assign) NSInteger mobileStatus;
/** 社保认证状态【0:未认证，-1:认证失败，2:认证中，1:已通过认证】 */
@property (nonatomic, assign) NSInteger jinpoStatus;
/** 公积金认证状态【0:未认证，-1:认证失败，2:认证中，1:已通过认证】 */
@property (nonatomic, assign) NSInteger fundStatus;

#pragma mark - 当isBind 和isPromote都为Y时返回下面字段
/** 借款金额*/
@property (nonatomic,copy) NSString * amount;
/** 到账金额*/
@property (nonatomic,copy) NSString * arrivalAmount;
/** 银行卡名称*/
@property (nonatomic,copy) NSString * bankName;

/** 银行icon V1.1.0添加*/
@property (nonatomic,copy) NSString * bankIcon;
/** 银行卡号*/
@property (nonatomic,copy) NSString * bankCard;
/** 手续费*/
@property (nonatomic,copy) NSString * serviceAmount;
/** 天数 */
@property (nonatomic,copy) NSString * borrowDays;
//免息优惠券  赋值
@property (nonatomic,copy) NSString * couponId;
/*是否设置过支付密码【1设置过支付密码；0未设置过】*/
@property (nonatomic,assign) NSInteger isSetPwd;
/** v-1.3.0  */
@property (nonatomic, copy) NSString *warmPrompt;

/** 当borrowType 等于1，表示白领贷，2 表示消费贷，如果borrowType=2 时，返回的消费贷数据（v1.5.0） */
/** 【‘教育’，‘旅游’】 */
@property (nonatomic, strong) NSArray *borrowApplications;
/** 商品信息 */
@property (nonatomic, strong) GoodsInfoModel *goodDto;
/** 商品价格 */
@property (nonatomic, assign) CGFloat goodPrice;
/** 还款时间 */
@property (nonatomic, copy) NSString * planRepayDay;
/** 商品数组 */
@property (nonatomic, copy) NSArray * goodsDtoList;


//150新增
@property (nonatomic, strong) CounponModel *userCoupon;

//160新增(埋点用)
@property (nonatomic, assign) BOOL hasBorrowed;

@end

@interface GoodsInfoModel : NSObject

/** descUrl(商品详情) */
@property (nonatomic, copy) NSString *descUrl;
/** name（商品名称 */
@property (nonatomic, copy) NSString *name;
/** originPrice(原价) */
@property (nonatomic, copy) NSString *originPrice;
/** price(商品价格) */
@property (nonatomic, copy) NSString *price;
/** 商品ID */
@property (nonatomic, copy) NSString *goodsId;
/** 商品图片链接 */
@property (nonatomic, copy) NSString *goodsIcon;
/** 是否选中 */
@property (nonatomic, assign) BOOL selected;

@end
