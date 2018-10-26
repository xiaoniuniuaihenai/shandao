//
//  LSThreeTitleTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSPromoteAmountModel;

@interface LSThreeTitleTableViewCell : UITableViewCell

/** first label */
@property (nonatomic, strong) UILabel *firstLabel;
/** second label */
@property (nonatomic, strong) UILabel *secondLabel;
/** third label */
@property (nonatomic, strong) UILabel *thirdLabel;

/** imageView */
@property (nonatomic, strong) UIImageView *circleImageView;

/** bottom line */
@property (nonatomic, strong) UIView *bottomLineView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 提升足迹Model */
@property (nonatomic, strong) LSPromoteAmountModel *promoteAmountModel;

@end
