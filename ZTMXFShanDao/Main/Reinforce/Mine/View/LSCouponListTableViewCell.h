//
//  LSCouponListTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CounponModel;

@interface LSCouponListTableViewCell : UITableViewCell

/** 背景imageview */
@property (nonatomic, strong) UIView *bgView;
/** 优惠券是否有效图片 */
@property (nonatomic, strong) UIImageView *stateImageView;
/** 优惠券金额 */
@property (nonatomic, strong) UILabel *couponAmountLabel;

/** 优惠券名称 */
@property (nonatomic, strong) UILabel *couponNameLabel;
/** 优惠券使用规则 */
@property (nonatomic, strong) UILabel *couponRuleLabel;
/** 优惠券时间 */
@property (nonatomic, strong) UILabel *couponDateLabel;

/** 虚线图片 */
@property (nonatomic, strong) UIImageView *dashImageView;
/** 优惠券使用状态图片 */
@property (nonatomic, strong) UIImageView *couponStateImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CounponModel *couponModel;

@end
