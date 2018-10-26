//
//  ZTMXFFaceFailureAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickHandle)(void);

@interface ZTMXFFaceFailureAlertView : UIView

+ (void)showWithCountStr:(NSString *)countStr click:(clickHandle)click;

@end
