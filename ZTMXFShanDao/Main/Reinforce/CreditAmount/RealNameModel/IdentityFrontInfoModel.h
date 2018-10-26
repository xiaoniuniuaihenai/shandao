//
//  IdentityFrontInfoModel.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/24.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FrontCardInfoModel;
@class FrontImageInfoModel;

@interface IdentityFrontInfoModel : NSObject

/** 正面信息 */
@property (nonatomic, strong) FrontCardInfoModel *cardInfo;
/** 正面图片信息 */
@property (nonatomic, strong) FrontImageInfoModel *imgInfo;

@end

@interface FrontCardInfoModel : NSObject

/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 生日 */
@property (nonatomic, copy) NSString *birthday;
/** 身份证号 */
@property (nonatomic, copy) NSString *citizen_id;
/** 性别 */
@property (nonatomic, copy) NSString *gender;
/** 正反面 1: 正面,  2: 反面 */
@property (nonatomic, assign) long idcard_type;
/** 姓名 */
@property (nonatomic, copy) NSString *name;
/** 名族 */
@property (nonatomic, copy) NSString *nation;

@end

@interface FrontImageInfoModel : NSObject

/** 图片文件名 */
@property (nonatomic, copy) NSString *srcFileName;
/** 上传图片url */
@property (nonatomic, copy) NSString *url;

@end
