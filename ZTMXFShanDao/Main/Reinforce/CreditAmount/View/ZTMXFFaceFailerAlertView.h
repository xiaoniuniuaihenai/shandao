//
//  ZTMXFFaceFailerAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickHandle)(void);

@interface ZTMXFFaceFailerAlertView : UIView


+ (void)showWithCountStr:(NSString *)countStr click:(ClickHandle)click;

@end
