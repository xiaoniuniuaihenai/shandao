//
//  ZTMXFLoanHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanModel;
@interface ZTMXFLoanHeaderView : UIView

@property (nonatomic, strong)LoanModel * loanModel;

- (void)showMeaageCount;


@end
