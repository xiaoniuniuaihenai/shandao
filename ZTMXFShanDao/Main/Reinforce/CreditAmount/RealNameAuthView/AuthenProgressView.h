//
//  AuthenProgressView.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AuthenProgressScanIdentifyId,   //  扫描身份证
    AuthenProgressFaceRecognition,  //  人脸识别
    AuthenProgressBindingBankCard,  //  绑定银行卡
    AuthenProgressSesameCredit,     //  芝麻信用
    AuthenProgressOperators,        //  运营商
    AuthenProgressConsumeLoan,      //  提交消费贷认证
    AuthenProgressCompany,          //  公司认证
    AuthenProgressSheBaoGongJiJing, //  社保/公积金 认证
    AuthenProgressNoSubmitWhiteLoan, //  白领贷认证(不可以提交)
    AuthenProgressSubmitWhiteLoan,    // 白领贷认证(可以提交)
    AuthenProgressSubmitMallLoan,     // 消费分期认证(可以提交)

} AuthenProgressType;

@interface AuthenProgressView : UIView

/** 认证进度类型 */
@property (nonatomic, assign) AuthenProgressType progressType;

- (void)startAnimationWithProgessType:(AuthenProgressType)progressType;

@end
