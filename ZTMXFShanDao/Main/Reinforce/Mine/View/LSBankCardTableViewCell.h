//
//  LSBankCardTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSBankCardTableViewCell;
@class BankCardModel;

@protocol BankCardTableViewCellDelegate <NSObject>

- (void)bankCardTableViewCellDeleteBankCard:(LSBankCardTableViewCell *)cell;

@end

@interface LSBankCardTableViewCell : UITableViewCell

/** 背景imageview */
@property (nonatomic, strong) UIImageView *bgImageView;
/** 银行卡Icon */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 银行卡名称 */
@property (nonatomic, strong) UILabel *bankCardNameLabel;
/** 银行卡类型 */
@property (nonatomic, strong) UILabel *bankCardTypeLabel;
/** 银行卡号 */
@property (nonatomic, strong) UILabel *bankCardNumberLabel;
/** 删除按钮 */
@property (nonatomic, strong) UIButton *deleteButton;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<BankCardTableViewCellDelegate> delegate;

@property (nonatomic, strong) BankCardModel *bankCardModel;

@end
