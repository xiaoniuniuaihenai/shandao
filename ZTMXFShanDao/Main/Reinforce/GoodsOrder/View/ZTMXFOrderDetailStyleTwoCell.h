//
//  OrderDetailStyleTwoCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTMXFOrderDetailStyleTwoCell : UITableViewCell

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** value label */
@property (nonatomic, strong) UILabel *valueLabel;
/** value Button */
@property (nonatomic, strong) UIButton *valueButton;
/** bottom line View */
@property (nonatomic, strong) UIView *lineView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 细线左边间距 */
- (void)showLineLeftMargin:(CGFloat)leftMargin;

@end
