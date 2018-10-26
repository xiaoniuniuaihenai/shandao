//
//  PayTypeTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PayTypeTableViewCell.h"
#import "PayChannelModel.h"

@implementation PayTypeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PayTypeTableViewCell";
    PayTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[PayTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        self.backgroundColor = [UIColor whiteColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    /** icon imageView */
    self.iconImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.contentView];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    /** title */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:15 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    /** title describe */
    self.titleDescribeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:12 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleDescribeLabel];
    
    /** value */
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:12 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.valueLabel];
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_DEEPBORDER_STR];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    self.selectedImageView = [UIImageView setupImageViewWithImageName:@"my_selected" withSuperView:self.contentView];
    self.selectedImageView.contentMode = UIViewContentModeCenter;
    
    self.recommendedImageView = [UIImageView setupImageViewWithImageName:@"XL_PayType_Recommended" withSuperView:self];
    self.recommendedImageView.contentMode = UIViewContentModeTopRight;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    CGFloat leftMargin = 12.0;
    
    self.iconImageView.frame = CGRectMake(leftMargin, 13.0, 25.0, 25.0);
    
    CGFloat titleLabelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxW:MAXFLOAT].width;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10.0, 13.0, titleLabelWidth, 25.0);
    
    self.valueLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10.0, CGRectGetMaxY(self.titleLabel.frame), KW - 37 - 15, 17);
    self.titleDescribeLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 20.0, CGRectGetMinY(self.titleLabel.frame), cellWidth - CGRectGetMaxX(self.titleLabel.frame) - 40.0, 25.0);
    [self.recommendedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self);
        make.width.mas_equalTo(X(67));
        make.height.mas_equalTo(X(56));
    }];
    
    if (self.showMarginLineView) {
        self.bottomLineView.frame = CGRectMake(leftMargin, cellHeight - 0.5, SCREEN_WIDTH - 2 * leftMargin, 0.5);
    } else {
        self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, SCREEN_WIDTH, 0.5);
    }
    
    if (_showRowImage) {
        //  显示箭头
        self.rowImageView.frame = CGRectMake(SCREEN_WIDTH - 20.0, 0.0, 8.0, cellHeight);
        self.rowImageView.hidden = NO;
    } else {
        //  不显示箭头
        self.rowImageView.frame = CGRectMake(SCREEN_WIDTH - 20.0, 0.0, 8.0, cellHeight);
        self.rowImageView.hidden = YES;
    }
    
    if (_showSelectedImage) {
        //  显示勾选图片
        self.selectedImageView.frame = CGRectMake(SCREEN_WIDTH - 33.0, 0.0, 21.0, cellHeight);
        self.selectedImageView.hidden = NO;
    } else {
        //  不显示勾选图片
        self.selectedImageView.hidden = YES;
    }
    
}

//  是否显示箭头
- (void)setShowRowImage:(BOOL)showRowImage{
    _showRowImage = showRowImage;
}

//  设置是否显示勾选图片
- (void)setShowSelectedImage:(BOOL)showSelectedImage{
    _showSelectedImage = showSelectedImage;
}

//  是否选中细线
- (void)setShowMarginLineView:(BOOL)showMarginLineView{
    _showMarginLineView = showMarginLineView;
}

// 设置数据
- (void)setChannelModel:(PayChannelModel *)channelModel{
    if (_channelModel != channelModel) {
        _channelModel = channelModel;
    }
    
    if (!kStringIsEmpty(_channelModel.channelNumber)) {
        NSString *lastFourNumber = [NSString bankCardLastFourNumber:_channelModel.channelNumber];
        if (kStringIsEmpty(lastFourNumber)) {
            self.titleLabel.text = [NSString stringWithFormat:@"%@",_channelModel.channelName];
        } else {
            self.titleLabel.text = [NSString stringWithFormat:@"%@ (尾号%@)",_channelModel.channelName, lastFourNumber];
        }
    } else {
        self.titleLabel.text = [NSString stringWithFormat:@"%@",_channelModel.channelName];
    }
    self.titleDescribeLabel.text = @"";

//    if (kStringIsEmpty(_channelModel.channelDesc)) {
//        self.titleDescribeLabel.text = @"";
//    } else {
//        self.titleDescribeLabel.text = _channelModel.channelDesc;
//    }
    if (_channelModel.isValid == 0) {
        self.valueLabel.hidden = NO;
        self.valueLabel.text = _channelModel.inValidDesc;
        self.showRowImage = NO;
    } else {
        if (!kStringIsEmpty(_channelModel.channelDesc)) {
            self.valueLabel.text = _channelModel.channelDesc;
        }else{
            self.valueLabel.hidden = YES;
        }
        self.showRowImage = YES;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_channelModel.channelIcon]];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.recommendedImageView.hidden = !_channelModel.alipay;
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
