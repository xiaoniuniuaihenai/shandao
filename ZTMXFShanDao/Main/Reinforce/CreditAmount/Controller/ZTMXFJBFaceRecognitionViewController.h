//
//  JBFaceRecognitionViewController.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//  活体认证

#import "BaseViewController.h"

@interface ZTMXFJBFaceRecognitionViewController : BaseViewController

/** 身份证正面URL */
@property (nonatomic, copy) NSString *frontUrl;
/** 姓名 */
@property (nonatomic, copy) NSString *realName;
/** 身份证ID */
@property (nonatomic, copy) NSString *citizen_id;

/** 实名认证类型 */
@property (nonatomic, assign) RealNameAuthenticationType authType;

/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

/** 开始人脸识别 */
- (void)startFaceRecognition;

/** 是否我的页面进入 */
@property (nonatomic, assign) BOOL isAddBankCard;

@end
