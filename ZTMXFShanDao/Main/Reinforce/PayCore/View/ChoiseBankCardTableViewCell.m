//
//  ChoiseBankCardTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ChoiseBankCardTableViewCell.h"
#import "PayChannelModel.h"
#import "BankCardModel.h"

@interface ChoiseBankCardTableViewCell()
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation ChoiseBankCardTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ChoiseBankCardTableViewCell";
    ChoiseBankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ChoiseBankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    
    /** value */
    self.valueLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:12 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.valueLabel];
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_DEEPBORDER_STR];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    
    
    self.selectedImageView = [UIImageView setupImageViewWithImageName:@"my_selected" withSuperView:self.contentView];
    self.selectedImageView.contentMode = UIViewContentModeCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat leftMargin = 12.0;
    
    self.iconImageView.frame = CGRectMake(leftMargin, 13.0, 25.0, 25.0);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 10.0, 13.0, 200.0, 25.0);
    self.valueLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), SCREEN_WIDTH - 30.0, 17);
    if (self.showMarginLineView) {
        self.bottomLineView.frame = CGRectMake(leftMargin, cellHeight - 0.5, SCREEN_WIDTH - 2 * leftMargin, 0.5);
    } else {
        self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, SCREEN_WIDTH, 0.5);
    }
    
//    CGFloat valueLabelOriginX = 120.0;
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
    self.titleLabel.text = [NSString stringWithFormat:@"%@", _channelModel.channelName];
    if (_channelModel.isValid == 0) {
        self.valueLabel.text = [NSString stringWithFormat:@"暂不支持%@卡",_channelModel.channelName];
    } else {
        self.valueLabel.text = @"";
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_channelModel.channelIcon]];
}

- (void)setBankCardModel:(BankCardModel *)bankCardModel{
    if (_bankCardModel != bankCardModel) {
        _bankCardModel = bankCardModel;
        if (!kStringIsEmpty(_bankCardModel.bankName)) {
            NSString *lastFourNumber = [NSString bankCardLastFourNumber:_bankCardModel.cardNumber];
            if (kStringIsEmpty(lastFourNumber)) {
                self.titleLabel.text = [NSString stringWithFormat:@"%@",_bankCardModel.bankName];
            } else {
                self.titleLabel.text = [NSString stringWithFormat:@"%@ (尾号%@)",_bankCardModel.bankName, lastFourNumber];
            }
        } else {
            self.titleLabel.text = [NSString stringWithFormat:@""];
        }
        if (_bankCardModel.isValid == 0) {
            self.valueLabel.hidden = NO;
            self.valueLabel.text = _bankCardModel.invalidDesc;
        } else {
            if (!kStringIsEmpty(_bankCardModel.channelDesc)) {
                self.valueLabel.text = _bankCardModel.channelDesc;
            }else{
                self.valueLabel.hidden = YES;
            }

        }
        if ([_bankCardModel.bankIcon rangeOfString:@"http"].location != NSNotFound) {
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_bankCardModel.bankIcon]];
        } else {
            self.iconImageView.image = [UIImage imageNamed:_bankCardModel.bankIcon];
        }
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
