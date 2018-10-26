//
//  LSPeriodDetaiCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBillListModel;
@class MallBillListModel;

typedef NS_ENUM(NSInteger, LSPeriodDetailCellType){
    LSPeriodDetailReturnType,     // 应还类型
    LSPeriodDetailPaidType,       // 已还类型
};

@protocol PeriodLoanDetailCellDelegete <NSObject>

@optional
- (void)selectedCellButtonClick:(MallBillListModel *)selectedMallBillModel;

@end

@interface LSPeriodDetaiCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, weak) id <PeriodLoanDetailCellDelegete> delegete;

@property (nonatomic, strong) LSBillListModel *billListModel;

@property (nonatomic, strong) MallBillListModel *mallBillModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
