//
//  ZTMXFLsdAuthCenterConfigureList.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFLsdAuthCenterConfigureList : NSObject
/**
 电商认证数组
 */
@property (nonatomic , strong) NSArray              * eitherOrItems;
/**
 基础认证文字
 */
@property (nonatomic , copy) NSString              * basicsAuth;
/**
 电商认证文字
 */
@property (nonatomic , copy) NSString              * eitherOrAuth;
/**
 基础认证项数组
 */
@property (nonatomic , strong) NSArray              * basicsItems;
/**
 认证状态 0 未认证 1认证完成 2认证中 -1认证失败
 */
@property (nonatomic , assign) int               authTypeStatus;

@end

@interface XLCertificationStatus :NSObject
/**
 认证状态 0 未认证 1认证完成 2认证中 -1认证失败
 */
@property (nonatomic , assign) NSInteger               authStatus;
/**
 
 */
@property (nonatomic , copy) NSString              * authId;
/**
 是否必填
 */
@property (nonatomic , assign) BOOL               isRequired;
/**
 认证类型 1基础认证  2二选一认证
 */
@property (nonatomic , assign) NSInteger              * authType;
/**
 app认证类型  1消费贷认证 2消费分期认证
 */
@property (nonatomic , assign) NSInteger              * authAppType;
/**
 认证排序
 */
@property (nonatomic , assign) NSInteger               sortBy;
/**
 认证名称唯一标示
 */
@property (nonatomic , copy) NSString              * authNameUnique;
/**
 认证名称
 */
@property (nonatomic , copy) NSString              * authName;
/**
 是否启用
 */
@property (nonatomic , assign) BOOL               isEnable;

@end


