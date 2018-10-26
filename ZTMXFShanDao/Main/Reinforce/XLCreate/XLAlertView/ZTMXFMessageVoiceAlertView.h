//
//  ZTMXFMessageVoiceAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

//  借钱类型
typedef enum : NSUInteger {
    XLMessageVoiceAlertDefault,        // 消息
    XLMessageVoiceAlertCertification,          //  认证
    XLMessageVoiceAlertLoan,          //  借钱
    
} XLMessageVoiceAlertType;
typedef void(^ActionBlock)(void);

@interface ZTMXFMessageVoiceAlertView : UIView

+ (void)showVoiceWithConfirmBlock:(ActionBlock )confirmBlock cancelBlock:(ActionBlock )cancelBlock;

+ (void)showVoiceWithMessageVoiceAlertType:(XLMessageVoiceAlertType)messageVoiceAlertType ConfirmBlock:(ActionBlock )confirmBlock cancelBlock:(ActionBlock )cancelBlock;

@end
