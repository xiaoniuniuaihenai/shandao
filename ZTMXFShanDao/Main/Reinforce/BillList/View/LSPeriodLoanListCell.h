//
//  LSPeriodLoanListCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeriodBillListModel;
@class LSBillListModel;

typedef NS_ENUM(NSInteger, LSPeriodLoanListCellType){
    LSPeriodLoanMonthType,        // 本月账单类型
    LSPeriodLoanResidueType,      // 剩余账单类型
    LSPeriodLoanProgressType,     // 还款中类型
    LSPeriodLoanHistoryType       // 历史账单
};

@protocol PeriodLoanListCellDelegete <NSObject>

@optional
- (void)selectedCellButtonClick:(PeriodBillListModel *)selectedBillModel;

@end

@interface LSPeriodLoanListCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, weak) id <PeriodLoanListCellDelegete> delegete;

@property (nonatomic, strong) PeriodBillListModel *billListModel;
/**  */
@property (nonatomic, strong) LSBillListModel *billModel;
/** cell 类型 */
@property (nonatomic, assign) LSPeriodLoanListCellType loanCellType;

+ (instancetype)cellWithTableView:(UITableView *)tableView Type:(LSPeriodLoanListCellType)loanCellType;

@end
