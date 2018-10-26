//
//  LSAlipayProofTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/1.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAlipayProofTableViewCell.h"

@implementation AlipayProofModel

@end

@interface LSAlipayProofTableViewCell ()

@property (nonatomic, strong) UIView         *grayView;
@property (nonatomic, strong) UIImageView    *iconImageView;
@property (nonatomic, strong) UILabel        *titleLabel;
@property (nonatomic, strong) UILabel        *valueLabel;

@end

@implementation LSAlipayProofTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSAlipayProofTableViewCell";
    LSAlipayProofTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSAlipayProofTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    self.grayView = [UIView setupViewWithSuperView:self.contentView withBGColor:@"edeff0"];
    
    self.iconImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.grayView];
    
    self.titleLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
    [self.grayView addSubview:self.titleLabel];
    
    self.valueLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:12 alignment:NSTextAlignmentLeft];
    [self.grayView addSubview:self.valueLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    self.grayView.frame = CGRectMake(10.0, 0.0, viewWidth - 20.0, viewHeight - 10.0);
    self.iconImageView.frame = CGRectMake(27.0, 10, 90.0, 150.0);
    CGFloat labelWidth = CGRectGetWidth(self.grayView.frame) - CGRectGetMaxX(self.iconImageView.frame) - 80.0;
    CGFloat titleLabelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxW:labelWidth].height;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 40.0, CGRectGetMinY(self.iconImageView.frame) + 20.0, labelWidth, titleLabelHeight);
    CGFloat valueLabelHeight = [self.valueLabel.text sizeWithFont:self.valueLabel.font maxW:labelWidth].height;
    self.valueLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame) + 15.0, CGRectGetWidth(self.titleLabel.frame), valueLabelHeight);
}

- (void)setAlipayProofModel:(AlipayProofModel *)alipayProofModel{
    if (_alipayProofModel != alipayProofModel) {
        _alipayProofModel = alipayProofModel;
        
        self.iconImageView.image = [UIImage imageNamed:_alipayProofModel.proofImageStr];
        self.titleLabel.text = _alipayProofModel.proofTitle;
        self.valueLabel.text = _alipayProofModel.proofValue;
        
        if ([_alipayProofModel.proofTitle isEqualToString:@"第1步"]) {
            self.titleLabel.attributedText = [NSString changeStringFromStr:self.titleLabel.text colorStr:@"1" withColor:[UIColor colorWithHexString:COLOR_RED_STR]];
            self.valueLabel.attributedText = [NSString changeStringFromStr:self.valueLabel.text colorStr:@"[账单]" withColor:[UIColor colorWithHexString:COLOR_BLUE_STR]];

        } else if ([_alipayProofModel.proofTitle isEqualToString:@"第2步"]) {
            self.titleLabel.attributedText = [NSString changeStringFromStr:self.titleLabel.text colorStr:@"2" withColor:[UIColor colorWithHexString:COLOR_RED_STR]];
            self.valueLabel.attributedText = [NSString changeStringFromStr:self.valueLabel.text colorStr:@"还款记录" withColor:[UIColor colorWithHexString:COLOR_BLUE_STR]];

        } else if ([_alipayProofModel.proofTitle isEqualToString:@"第3步"]) {
            self.titleLabel.attributedText = [NSString changeStringFromStr:self.titleLabel.text colorStr:@"3" withColor:[UIColor colorWithHexString:COLOR_RED_STR]];
            self.valueLabel.attributedText = [NSString changeStringFromStr:self.valueLabel.text colorStr:@"账单详情" withColor:[UIColor colorWithHexString:COLOR_BLUE_STR]];

        }

        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
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
