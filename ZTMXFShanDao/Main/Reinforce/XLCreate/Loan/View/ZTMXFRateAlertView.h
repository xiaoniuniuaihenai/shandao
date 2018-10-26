//
//  ZTMXFRateAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ZTMXFRateAlertViewDefault,//默认样式
    ZTMXFRateAlertViewNoNumber,//扫描次数上限
    ZTMXFRateAlertViewFailure,//识别失败
    ZTMXFRateAlertViewFailureH5//贷款超市
}ZTMXFRateAlertViewStyle;


@interface ZTMXFRateAlertView : UIView

@property (nonatomic, copy)NSString * descStr;

+ (void)showWithStr:(NSString *)str;

+ (void)showWithTitle:(NSString *)title message:(NSString *)message style:(ZTMXFRateAlertViewStyle)style;

+ (void)showWithTitle:(NSString *)title message:(NSString *)message style:(ZTMXFRateAlertViewStyle)style clickBlock:(void (^)())clickBlock;



@end
