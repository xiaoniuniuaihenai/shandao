//
//  LSPromoteCreditInfoModel.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/3/30.
//  Copyright © 2017年 讯秒. All rights reserved.
//  基础认证信息

#import <Foundation/Foundation.h>
@class CreditModel;
@class ZmModel;

//  信用基础信息
@interface CreditModel : NSObject
/*额度*/
@property (nonatomic,assign) double quota;
/** 信用等级 */
@property (nonatomic, copy) NSString *creditLevel;

/**
 信用评估时间
 */
@property (nonatomic,assign )  long long creditAssessTime;
@end



//  芝麻信用
@interface ZmModel : NSObject
/**
 芝麻授权状态【0:未授权，-1:授权失败，1:已授权】
 */
@property (nonatomic,assign) NSInteger zmStatus;
/**
 芝麻信用分
 */
@property (nonatomic,assign ) NSInteger  zmScore;

/**
 芝麻信用授权url（针对zmStatus为N是才有值）
 */
@property (nonatomic,copy  ) NSString * zmxyAuthUrl;
@end

@interface LSPromoteCreditInfoModel : NSObject
/** 信用基础信息 */
@property (nonatomic, strong) CreditModel *creditModel;

/** 芝麻信用 */
@property (nonatomic, strong) ZmModel *zmModel;

/**
 手机运营商认证：【0:未认证N,2:认证中W,1:已认证Y,-1:认证失败】
 */
@property (nonatomic,assign) NSInteger mobileStatus;
/**
 通讯录状态【0:未认证,1:已认证,-1:认证失败】
 */
@property (nonatomic,assign) NSInteger contactsStatus;
/**

 是否走过认证的强风控【0:未审核A，-1:未通过审核N，2: 审核中P，1:已通过审核Y】
 */
@property (nonatomic,assign) NSInteger riskStatus;

//底部广告
/**
 审核通过与否的配图路径
 */
@property (nonatomic,copy  ) NSString * url;

/**
 是否调转到H5【NO(不跳)，H5(跳转到H5)，SC(跳转到补充认证)】
 */
@property (nonatomic,copy  ) NSString * isSkipH5;
/**
 isSkipH5为Y才会有这个字段
 */
@property (nonatomic,copy  ) NSString * h5Url;

/**
 强风控重审提示信息 如果riskStatus为0，有以下字段
 */
@property (nonatomic,copy  ) NSString * riskRetrialRemind;

/** 人脸识别状态【0:未认证,-1:认证失败，1:已认证】 */
@property (nonatomic, assign) NSInteger faceStatus;
/** 是否绑卡状态【0:未绑卡  1：绑卡：-1：绑卡失败】 */
@property (nonatomic, assign) NSInteger bindCardStatus;

/** 慢比配间隔时间戳（如30分钟的时间戳） V1.1.2*/
@property (nonatomic,assign) CGFloat compensateTime;

/** 慢比配活动描述：倒计时内未认证，您将获得10元补偿  */
@property (nonatomic,copy  ) NSString * compensateDesc;

/** 慢比配活动时间：适应用工作时间段：10:00-23:00 */
@property (nonatomic,copy  ) NSString * compensateTimeDesc;

/** 点击慢必陪跳转H5页面链接地址 */
@property (nonatomic,copy  ) NSString * compensateUrl;

/** 慢必陪的金额：如10元 */
@property (nonatomic,assign ) double compensateAmount;

@end




