//
//  ZTMXFCertificationPromptView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Success)(void);

@interface ZTMXFCertificationPromptView : UIView

@property (nonatomic, copy) Success success;
@property (nonatomic, assign) NSTimeInterval timerInterval;

+ (void)showCertificationPromptViewWithTimerInterval:(NSTimeInterval)timerInterval Success:(Success)success;

@end
