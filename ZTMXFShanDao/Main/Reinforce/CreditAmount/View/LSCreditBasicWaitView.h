//
//  LSCreditBasicWaitView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  提交强风控  等待

#import <UIKit/UIKit.h>
typedef void(^TimerEndBlock)();
@interface LSCreditBasicWaitView : UIView
-(void)startCountdownWithTimerOut:(NSUInteger)timeOut block:(TimerEndBlock)endBlock;
-(void)removeTimer;
@end
