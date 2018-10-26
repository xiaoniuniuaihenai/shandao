//
//  ZTMXFSetPasswordAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickHandle)(void);


@interface ZTMXFSetPasswordAlertView : UIView

+ (void)showMessage:(NSString *)message ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click;


@end
