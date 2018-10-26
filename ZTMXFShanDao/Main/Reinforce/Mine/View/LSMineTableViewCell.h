//
//  LSMineTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSMineTableViewCell : UITableViewCell

/** icon ImageView */
@property (nonatomic, strong) UIImageView *iconImageView;
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
