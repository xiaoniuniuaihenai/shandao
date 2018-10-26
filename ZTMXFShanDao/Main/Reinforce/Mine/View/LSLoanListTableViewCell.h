//
//  LSLoanListTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSLoanRecordModel;

@interface LSLoanListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView        *firstView;

/** 借钱金额icon */
@property (nonatomic, strong) UIImageView   *loanAmountIcon;
@property (nonatomic, strong) UILabel       *loanAmount;
@property (nonatomic, strong) UILabel       *loanAmountLabel;
@property (nonatomic, strong) UIImageView   *rowImageView;


@property (nonatomic, strong) UIView        *secondView;

/** 申请时间 */
@property (nonatomic, strong) UIImageView   *loanDateIcon;
@property (nonatomic, strong) UILabel       *loanDate;
@property (nonatomic, strong) UILabel       *loanDateLabel;

/** 借钱状态 */
@property (nonatomic, strong) UIImageView   *loanStateIcon;
@property (nonatomic, strong) UILabel       *loanState;
@property (nonatomic, strong) UILabel       *loanStateLabel;

/** 借款记录Model */
@property (nonatomic, strong) LSLoanRecordModel *loanRecordModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
