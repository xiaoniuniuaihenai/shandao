//
//  MyLoanListCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/9.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBillListModel;

typedef NS_ENUM(NSInteger, LSLoanListCellType){
    LSLoanNotReturnType,
    LSLoanHistoryType
};

@protocol MyLoanListCellDelegete <NSObject>

@optional
- (void)selectedCellButtonClick:(LSBillListModel *)selectedBillModel;

@end

@interface MyLoanListCell : UITableViewCell

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, weak) id <MyLoanListCellDelegete> delegete;

@property (nonatomic, strong) LSBillListModel *billListModel;

@property (nonatomic, assign) LSLoanListCellType loanCellType;

+ (instancetype)cellWithTableView:(UITableView *)tableView Type:(LSLoanListCellType)loanCellType;

@end
