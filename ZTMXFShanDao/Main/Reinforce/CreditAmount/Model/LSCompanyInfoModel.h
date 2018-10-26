//
//  LSCompanyInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/29.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCompanyInfoModel : NSObject

/** 行业 */
@property (nonatomic, copy) NSString * industry;
/** 公司名称 */
@property (nonatomic, copy) NSString * name;
/** 省 */
@property (nonatomic, copy) NSString * province;
/** 市 */
@property (nonatomic, copy) NSString * city;
/** 区 */
@property (nonatomic, copy) NSString * region;
/** 详细地址 */
@property (nonatomic, copy) NSString * detailAddress;
/** 公司电话 */
@property (nonatomic, copy) NSString * companyPhone;
/** 任职部门 */
@property (nonatomic, copy) NSString * department;
/** 任职岗位 */
@property (nonatomic, copy) NSString * position;

@end
