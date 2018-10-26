//
//  LSAuthMaidianApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/28.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"
typedef NS_ENUM(NSInteger,AuthMaidianType) {
    AuthMaidianTypeBeforeSubmitIdInfo = 0,        //    进入提交身份提交信息页面(beforeSubmitIdInfo)
    AuthMaidianTypeIdFrontScan,               //    进入身份证扫描正面页面(idFrontScan)
    AuthMaidianTypeIdBackScan,                //    进入身份证扫描反面页面(idBackScan)、
    AuthMaidianTypeFaceRecognition,           //    进入人脸识别页面(faceRecognition)、
    AuthMaidianTypeBindBankCard,              //    进入绑定银行卡页面(bindBankCard)
    AuthMaidianTypeFaceIdFrontScan,               //    进入身份证扫描正面页面(idFrontScan)
    AuthMaidianTypeFaceIdBackScan,                //    进入身份证扫描反面页面(idBackScan)、
    AuthMaidianTypeFaceFaceRecognition,           //    进入人脸识别页面(faceRecognition)、
    
};
@interface LSAuthMaidianApi : BaseRequestSerivce
-(instancetype)initWithType:(AuthMaidianType)authType;
@end
