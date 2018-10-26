//
//  LSLoanRecordTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  借款记录里面使用的cell

#import <UIKit/UIKit.h>
@class LSLoanRecordModel;
@class ZTMXFRenewRecordModel;
@class LSRepaymentListModel;

@interface LSLoanRecordTableViewCell : UITableViewCell

/** 还款类型 */
@property (nonatomic, strong) UILabel *loanTypeLabel;
/** 借款金额 */
@property (nonatomic, strong) UILabel *loanAmountLabel;
/** 借款日期 */
@property (nonatomic, strong) UILabel *loanDateLabel;
/** 借款状态 */
@property (nonatomic, strong) UILabel *loanStateLabel;
/** 延期还款支付费用 */
@property (nonatomic, strong) UILabel *renewAmountLabel;
/** 细线 */
@property (nonatomic, strong) UIView *bottomLineView;

/** 箭头图片 */
@property (nonatomic, strong) UIImageView *rowImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 借款记录Model */
@property (nonatomic, strong) LSLoanRecordModel *loanRecordModel;

/** 延期还款记录Model */
@property (nonatomic, strong) ZTMXFRenewRecordModel *renewRecordModel;

/** 还款记录Model */
@property (nonatomic, strong) LSRepaymentListModel *repaymentListModel;

@end
