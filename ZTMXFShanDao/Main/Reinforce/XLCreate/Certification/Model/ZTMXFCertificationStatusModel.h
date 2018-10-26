//
//  ZTMXFCertificationStatusModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFCertificationStatusModel : NSObject
/** 是否走过认证的消费贷【0:未审核，-1:未通过审核，2: 审核中，1:已通过审核】 */
@property (nonatomic,assign ) NSInteger certificationStatus;

@property (nonatomic,copy ) NSString * certificationName;

@property (nonatomic,copy ) NSString * iconStr;

@property (nonatomic,copy ) NSString * detailsStr;




@end
