//
//  LSCouponListTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCouponListTableViewCell.h"
#import "CounponModel.h"

@implementation LSCouponListTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSCouponListTableViewCell";
    LSCouponListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSCouponListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    self.bgView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_WHITE_STR];
    self.bgView.layer.cornerRadius = 4.0;
    self.bgView.clipsToBounds = YES;
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    /** 优惠券左侧图片view */
    self.stateImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.bgView];
    
    /** 优惠券金额 */
    self.couponAmountLabel = [UILabel labelWithTitleColorStr:COLOR_RED_STR fontSize:72 alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.couponAmountLabel];
    self.couponAmountLabel.font = [UIFont boldSystemFontOfSize:64];
    
    /** 优惠券名称 */
    self.couponNameLabel = [UILabel labelWithTitleColorStr:@"c7c7c7" fontSize:15 alignment:NSTextAlignmentRight];
    [self.bgView addSubview:self.couponNameLabel];
    
    /** 优惠券使用规则 */
    self.couponRuleLabel = [UILabel labelWithTitleColorStr:@"c7c7c7" fontSize:12 alignment:NSTextAlignmentRight];
    [self.bgView addSubview:self.couponRuleLabel];
    
    /** 虚线图片view */
    self.dashImageView = [UIImageView setupImageViewWithImageName:@"XL_line_dash" withSuperView:self.bgView];

    /** 优惠券时间 */
    self.couponDateLabel = [UILabel labelWithTitleColorStr:@"c7c7c7" fontSize:12 alignment:NSTextAlignmentLeft];
    [self.bgView addSubview:self.couponDateLabel];
    
    /** 优惠券状态图片view */
    self.couponStateImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.bgView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    
    /** 背景view */
    self.bgView.frame = CGRectMake(10.0, 10.0, cellWidth - 20.0, cellHeight - 10);
    self.stateImageView.frame = CGRectMake(0.0, 0.0, 18.0, CGRectGetHeight(self.bgView.frame));
    /** 优惠券金额 */
    self.couponAmountLabel.frame = CGRectMake(CGRectGetMaxX(self.stateImageView.frame) + 20.0, 0.0, CGRectGetWidth(self.bgView.frame) - 140.0, 90.0);
    
    /** 优惠券名称 */
    self.couponNameLabel.frame = CGRectMake(100.0, 16.0, CGRectGetWidth(self.bgView.frame) - 112.0, 21.0);
    /** 优惠券使用规则 */
    self.couponRuleLabel.frame = CGRectMake(CGRectGetMinX(self.couponNameLabel.frame), CGRectGetMaxY(self.couponNameLabel.frame) + 5.0, CGRectGetWidth(self.couponNameLabel.frame), 17.0);
    
    self.dashImageView.frame = CGRectMake(CGRectGetMaxX(self.stateImageView.frame) + 12.0, CGRectGetHeight(self.bgView.frame) - 28.0, CGRectGetWidth(self.bgView.frame) - CGRectGetMaxX(self.stateImageView.frame) - 24.0, 0.5);
    
    /** 优惠券时间 */
    self.couponDateLabel.frame = CGRectMake(CGRectGetMinX(self.dashImageView.frame), CGRectGetMaxY(self.dashImageView.frame), CGRectGetWidth(self.dashImageView.frame), 26.0);

    self.couponStateImageView.frame = CGRectMake(CGRectGetWidth(self.bgView.frame) - 50.0 - 14.0, CGRectGetHeight(self.bgView.frame) - 50.0 - 8.0, 50.0, 50.0);

}

- (void)setCouponModel:(CounponModel *)couponModel{
    if (_couponModel != couponModel) {
        _couponModel = couponModel;
    }
    
    self.couponNameLabel.text = _couponModel.name;
    self.couponRuleLabel.text = _couponModel.useRule;
    self.couponAmountLabel.text = [NSString stringWithFormat:@"%.0f元", _couponModel.amount];
    UIFont *amountFont = [UIFont systemFontOfSize:13];
    self.couponAmountLabel.attributedText = [NSString changeStringWithStr:self.couponAmountLabel.text fontStr:@"元" withFont:amountFont];

    NSString *dateStart = [NSDate dateddStringFromLongDate:_couponModel.gmtStart];
    NSString *dateEnd = [NSDate dateddStringFromLongDate:_couponModel.gmtEnd];
    self.couponDateLabel.text = [NSString stringWithFormat:@"有效期: %@至%@",dateStart,dateEnd];
    /** 状态 【 2:过期 ; 0:未使用 ， 1:已使 */
    if (_couponModel.status == 0) {
        [self couponUsableState];
    } else if (_couponModel.status == 1) {
        [self couponUnusableState];
    } else if (_couponModel.status == 2) {
        [self couponUnusableState];
    }
}

- (void)couponUsableState{
    self.stateImageView.image = [UIImage imageNamed:@"coupon_orange"];
    self.couponStateImageView.image = nil;
    self.couponAmountLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
    self.couponNameLabel.textColor = [UIColor colorWithHexString:@"e56647"];
    self.couponDateLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    self.couponRuleLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    
}

- (void)couponUnusableState{
    self.stateImageView.image = [UIImage imageNamed:@"coupon_gray"];
    if (_couponModel.status == 1) {
        self.couponStateImageView.image = [UIImage imageNamed:@"mine_coupon_used"];
    } else if (_couponModel.status == 2) {
        self.couponStateImageView.image = [UIImage imageNamed:@"mine_coupon_failure"];
    }
    self.couponAmountLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
    self.couponNameLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
    self.couponDateLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
    self.couponRuleLabel.textColor = [UIColor colorWithHexString:@"c7c7c7"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
