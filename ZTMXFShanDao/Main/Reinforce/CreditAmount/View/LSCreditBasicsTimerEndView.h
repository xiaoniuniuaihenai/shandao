//
//  LSCreditBasicsTimerEndView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  基础认证  倒计时结束

#import <UIKit/UIKit.h>
@class LSCreditBasicsTimerEndView;
@protocol LSCreditBasicsTimerEndViewDelegate<NSObject>
@optional
-(void)creditBasiceTimerEndSubmitClick;

@end
@interface LSCreditBasicsTimerEndView : UIView
@property (nonatomic,weak) id<LSCreditBasicsTimerEndViewDelegate> delegate;

@end

