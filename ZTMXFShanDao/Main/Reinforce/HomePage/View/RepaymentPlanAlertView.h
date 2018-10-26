//
//  RepaymentPlanAlertView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  还款计划

#import <UIKit/UIKit.h>

typedef void(^BlockBtnCloseClick)(void);
@interface RepaymentPlanAlertView : UIView
-(instancetype)initWithArrData:(NSArray *)arrData;
@property (nonatomic,copy) BlockBtnCloseClick blockCloseClick;
-(void)showAlertView;
@end
