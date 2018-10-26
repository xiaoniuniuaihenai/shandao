//
//  LSCreditBasicsPassView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  基础认证 审核通过

#import <UIKit/UIKit.h>
@class LSCreditBasicsPassView;
@class LSCreditPassModel;
@protocol LSCreditBasicsPassViewDelegate<NSObject>
@optional
-(void)creditBasicePassGoBorrowMoney;

@end

@interface LSCreditBasicsPassView : UIView
@property (nonatomic,weak) id<LSCreditBasicsPassViewDelegate> delegate;
-(void)updateMoney:(double)money;
@property (nonatomic, strong) LSCreditPassModel *creditPassModel;
@end



