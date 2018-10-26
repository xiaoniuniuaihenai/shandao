//
//  ChoiseBankCardTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayChannelModel;
@class BankCardModel;


@interface ChoiseBankCardTableViewCell : UITableViewCell

/** icon ImageView */
@property (nonatomic, strong) UIImageView *iconImageView;
/** title */
@property (nonatomic, strong) UILabel *titleLabel;
/** value */
@property (nonatomic, strong) UILabel *valueLabel;
/** 细线 */
@property (nonatomic, strong) UIView *bottomLineView;
/** 箭头图片 */
@property (nonatomic, strong) UIImageView *rowImageView;
/** 打钩选中图片 */
@property (nonatomic, strong) UIImageView *selectedImageView;

/** 显示有间距的底部细线 */
@property (nonatomic, assign) BOOL showMarginLineView;

/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImage;
/** 是否显示选中图片 */
@property (nonatomic, assign) BOOL showSelectedImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 渠道Model */
@property (nonatomic, strong) PayChannelModel *channelModel;

/** 银行卡Model */
@property (nonatomic, strong) BankCardModel   *bankCardModel;

@end
