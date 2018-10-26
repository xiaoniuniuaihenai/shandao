//
//  IdentityBackInfoModel.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/24.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BackCardInfoModel;
@class BackImageInfoModel;

@interface IdentityBackInfoModel : NSObject

/** 正面信息 */
@property (nonatomic, strong) BackCardInfoModel *cardInfo;
/** 正面图片信息 */
@property (nonatomic, strong) BackImageInfoModel *imgInfo;

@end

@interface BackCardInfoModel : NSObject

/** 签发机关 */
@property (nonatomic, copy) NSString *agency;
/** 正反面 1: 正面,  2: 反面 */
@property (nonatomic, assign) long idcard_type;
/** 开始有效时间 */
@property (nonatomic, copy) NSString *valid_date_begin;
/** 结束有效时间 */
@property (nonatomic, copy) NSString *valid_date_end;

@end

@interface BackImageInfoModel : NSObject

/** 图片文件名 */
@property (nonatomic, copy) NSString *srcFileName;
/** 上传图片url */
@property (nonatomic, copy) NSString *url;

@end
