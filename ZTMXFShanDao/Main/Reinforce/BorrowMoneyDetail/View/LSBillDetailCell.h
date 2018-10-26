//
//  LSBillDetailCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/10.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBillDetailCell : UITableViewCell

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** value label */
@property (nonatomic, strong) UILabel *valueLabel;
/** row image view */
@property (nonatomic, strong) UIImageView *rowImageView;
/** bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
