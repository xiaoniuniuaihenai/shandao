//
//  ZTMXFLoanAddressCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/6/1.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSAddressModel;
@class ZTMXFLoanAddressCell;
@protocol ZTMXFLoanAddressCellDelegate <NSObject>

@optional
/**
 flag  1 编辑  2 选中地址
 */
- (void)loanAddressCell:(ZTMXFLoanAddressCell *)LoanAddressCell flag:(NSInteger)flag;

- (void)loanAddressCellWithAddressModel:(LSAddressModel *)addressModel flag:(NSInteger)flag;


@end

@interface ZTMXFLoanAddressCell : UITableViewCell

+ (ZTMXFLoanAddressCell *)loanAddressCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)UIButton * chooseBtn;

@property (nonatomic, strong)UILabel * nameLabel;

@property (nonatomic, strong)UILabel * phoneLabel;

@property (nonatomic, strong)UIButton * editBtn;

@property (nonatomic, strong)UILabel * addressLabel;

@property (nonatomic, strong) LSAddressModel *addressModel;

@property (nonatomic, weak) id<ZTMXFLoanAddressCellDelegate> delegete;


@end
