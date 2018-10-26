//
//  PayTypeTableViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayChannelModel;

@interface PayTypeTableViewCell : UITableViewCell

/** icon ImageView */
@property (nonatomic, strong) UIImageView *iconImageView;
/** title */
@property (nonatomic, strong) UILabel *titleLabel;
/** title describe */
@property (nonatomic, strong) UILabel *titleDescribeLabel;
/** value */
@property (nonatomic, strong) UILabel *valueLabel;
/** 细线 */
@property (nonatomic, strong) UIView *bottomLineView;
/** 箭头图片 */
@property (nonatomic, strong) UIImageView *rowImageView;
/** 打钩选中图片 */
@property (nonatomic, strong) UIImageView *selectedImageView;

/** 推荐  图片  */
@property (nonatomic, strong) UIImageView *recommendedImageView;

/** 显示有间距的底部细线 */
@property (nonatomic, assign) BOOL showMarginLineView;

/** 是否显示箭头 */
@property (nonatomic, assign) BOOL showRowImage;
/** 是否显示选中图片 */
@property (nonatomic, assign) BOOL showSelectedImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 设置model数据 */
@property (nonatomic, strong) PayChannelModel *channelModel;

@end
