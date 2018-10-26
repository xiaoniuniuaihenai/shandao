//
//  OrderDetailStyleOneCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderDetailStyleOneCellDelegate <NSObject>

/** 点击ValueButton */
- (void)orderDetailStyleOneCellClickValueButtonAction;

@end

@interface ZTMXFOrderDetailStyleOneCell : UITableViewCell

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** value label */
@property (nonatomic, strong) UILabel *valueLabel;
/** value Button */
@property (nonatomic, strong) UIButton *valueButton;
/** top rowImageView */
@property (nonatomic, strong) UIImageView *topRowImageView;
/** bottom lineView */
@property (nonatomic, strong) UIView *lineView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 显示valueButton */
- (void)showValueButton:(BOOL)show;
/** 细线左边间距 */
- (void)showLineLeftMargin:(CGFloat)leftMargin;

@property (nonatomic, weak) id<OrderDetailStyleOneCellDelegate> delegate;

@end
