//
//  ALATitleValueTableViewCell.h
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/16.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALATitleValueTableViewCell : UITableViewCell

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** value label */
@property (nonatomic, strong) UILabel *valueLabel;

/** row image view */
@property (nonatomic, strong) UIImageView *rowImageView;
/** bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

/** bottom dash line */
@property (nonatomic, strong) UIImageView *dashImageView;

/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
