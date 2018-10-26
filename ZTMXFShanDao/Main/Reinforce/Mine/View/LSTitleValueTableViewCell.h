//
//  LSTitleValueTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTitleValueTableViewCell : UITableViewCell

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** value label */
@property (nonatomic, strong) UILabel *valueLabel;

/** row image view */
@property (nonatomic, strong) UIImageView *rowImageView;
/** bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

/** logo label */
@property (nonatomic, strong) UILabel *logoLabel;
/** 消息声音开关 */
@property (nonatomic, strong) UISwitch * voiceSwitch;


/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 设置认证状态 */
- (void)identityAuthWithState:(BOOL)state;

@end
