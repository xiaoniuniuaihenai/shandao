//
//  LSChooseRechargeMoneyView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  选择充值金额

#import <UIKit/UIKit.h>
@class ZTMXFMobileRechargeMoneyModel;
@interface LSChooseRechargeMoneyView : UIView
@property (nonatomic,weak) id  delegate;
@property (nonatomic,strong) NSMutableArray * arrPayMoneyArr;
//
@property (nonatomic,assign) BOOL itemEditorState;
@end
@protocol  LSChooseRechargeMoneyViewDelegate<NSObject>

@optional
/**
 * 选择充值金额
 */
-(void)chooseRechargeMoneyView:(LSChooseRechargeMoneyView*)rechargeMoneyView didSelect:(ZTMXFMobileRechargeMoneyModel*)modelSelect;

@end
