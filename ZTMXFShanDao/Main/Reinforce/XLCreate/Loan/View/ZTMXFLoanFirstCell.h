//
//  LoanFirstCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoanModel;
@interface ZTMXFLoanFirstCell : UITableViewCell

@property (nonatomic, strong)LoanModel * loanModel;

@property (nonatomic, strong)UIButton * submitBtn;


@end
