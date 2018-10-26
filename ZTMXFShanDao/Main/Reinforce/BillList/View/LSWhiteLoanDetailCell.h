//
//  LSWhiteLoanDetailCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSWhiteLoanDetailCell : UITableViewCell

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;

/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImageView;

@property (nonatomic, strong) NSDictionary *loanDetailDict;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
