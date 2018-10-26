//
//  JBBorrowRateAlertView.h
//  tryTest
//
//  Created by 朱吉达 on 2017/12/1.
//  Copyright © 2017年 try. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WhiteLoanAlertViewType,
    ConsumeLoanAlertViewType,
} LoanAlertViewType;

@interface JBBorrowRateAlertView : UIView
-(void)updateWithProcedureRates:(NSString* )pRates dayRate:(NSString *)dayRate loanAlertType:(LoanAlertViewType)alertViewType;
-(void)show;
-(void)dismiss;
@end
