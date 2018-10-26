//
//  ZTMXFConfirmLoanViewGoodCellTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/6/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFConfirmLoanViewGoodCell.h"
#import "UIButton+JKImagePosition.h"
#import "LSBorrwingCashInfoModel.h"

@interface ZTMXFConfirmLoanViewGoodCell ()
@property (nonatomic, strong) UIButton    *seletedButton;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *priceLabel;
@property (nonatomic, strong) UILabel     *oldPriceLabel;
@end

@implementation ZTMXFConfirmLoanViewGoodCell



+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFConfirmLoanViewGoodCell";
    ZTMXFConfirmLoanViewGoodCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFConfirmLoanViewGoodCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}
- (void)setGoodsInfoModel:(GoodsInfoModel *)goodsInfoModel{
    if (_goodsInfoModel != goodsInfoModel) {
        _goodsInfoModel = goodsInfoModel;
        _seletedButton.selected = goodsInfoModel.selected;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:_goodsInfoModel.goodsIcon] placeholderImage:nil];
        _titleLabel.text = _goodsInfoModel.name;
        _priceLabel.text = [NSString stringWithFormat:@"优惠价: %@元", [NSDecimalNumber decimalNumberWithString:_goodsInfoModel.price]];
        
        NSString *oldPrice = [NSString stringWithFormat:@"原价:%@元", [NSDecimalNumber decimalNumberWithString:_goodsInfoModel.originPrice]];
        NSUInteger length = [oldPrice length];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
        [attri addAttribute:NSStrikethroughColorAttributeName value:COLOR_SRT(@"#CFCECE") range:NSMakeRange(0, length)];
        [_oldPriceLabel setAttributedText:attri];
    }
}
- (void)configUI{
    UILabel *seletedGoodsLabel = [[UILabel alloc]init];
    seletedGoodsLabel.font = FONT_Regular(X(14));
    seletedGoodsLabel.textColor = K_888888;
    seletedGoodsLabel.text = @"选择商品";
    [self addSubview:seletedGoodsLabel];
    [seletedGoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(@(X(16)));
        make.centerY.mas_equalTo(self.mas_top).mas_offset(@(X(20)));
        make.width.mas_equalTo(@(X(60)));
    }];
    
    [self addSubview:self.seletedButton];
    [self.seletedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(seletedGoodsLabel.mas_right).mas_offset(@0);
        make.centerY.mas_equalTo(seletedGoodsLabel.mas_centerY);
        make.height.mas_equalTo(@(X(40)));
        make.width.mas_equalTo(@(X(40)));
    }];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"更多商品" forState:UIControlStateNormal];
    [moreButton setTitle:@"更多商品" forState:UIControlStateHighlighted];
    [moreButton setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateHighlighted];
    [moreButton setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
    [moreButton setTitleColor:K_888888 forState:UIControlStateHighlighted];
    [moreButton setTitleColor:K_888888 forState:UIControlStateNormal];
    moreButton.titleLabel.font = FONT_Regular(X(14));
    [moreButton jk_setImagePosition:LXMImagePositionRight spacing:X(5)];
    [moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(@(X(-5)));
        make.centerY.mas_equalTo(seletedGoodsLabel.mas_centerY);
        make.width.mas_equalTo(@(X(80)));
        make.height.mas_equalTo(@34);
    }];
    
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = [COLOR_SRT(@"#FAB179") colorWithAlphaComponent:.06];
    [self addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(seletedGoodsLabel.mas_centerY).mas_offset(@(X(20)));
    }];
    
    [grayView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(grayView.mas_centerY);
        make.centerX.mas_equalTo(grayView.mas_left).mas_offset(@(X(43)));
        make.height.width.mas_equalTo(@(X(55)));
    }];
    
    [grayView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(@(X(13)));
        make.centerY.mas_equalTo(grayView.mas_top).mas_offset(@(X(24)));
        make.height.mas_equalTo(@(X(22)));
        make.width.mas_equalTo(@(X(200)));
    }];
    
    [grayView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY).mas_offset(@(X(30)));
        make.height.mas_equalTo(@(X(22)));
    }];
    
    [grayView addSubview:self.oldPriceLabel];
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(@(X(10)));
        make.centerY.mas_equalTo(self.priceLabel.mas_centerY);
        make.height.mas_equalTo(@(X(17)));
        
    }];
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailButton setTitleColor:K_MainColor forState:UIControlStateHighlighted];
    [detailButton setTitleColor:K_MainColor forState:UIControlStateNormal];
    [detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [detailButton setTitle:@"查看详情" forState:UIControlStateHighlighted];
    detailButton.titleLabel.font = FONT_Regular(X(14));
    [detailButton addTarget:self action:@selector(detailButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [grayView addSubview:detailButton];
    [detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(grayView);
        make.width.mas_equalTo(@(X(80)));
    }];
}

- (void)moreButtonClick{
    if (self.moreButtonClickBlock) {
        self.moreButtonClickBlock();
    }
}



- (void)seletedButtonClick:(UIButton *)sender{
    if (self.seletedBlock) {
        sender.selected = !sender.isSelected;
        self.seletedBlock(sender.isSelected);
    }
}
- (void)detailButtonClick{
    if (self.detailButtonClickBlock) {
        self.detailButtonClickBlock();
    }
}
- (UIButton *)seletedButton{
    if (!_seletedButton) {
        _seletedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_seletedButton setImage:[UIImage imageNamed:@"XL_Confirm_Loan_Un_Seleted"] forState:UIControlStateNormal];
        [_seletedButton setImage:[UIImage imageNamed:@"XL_Confirm_Loan_Seleted"] forState:UIControlStateSelected];
        [_seletedButton addTarget:self action:@selector(seletedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seletedButton;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = K_333333;
        _titleLabel.font = FONT_Regular(X(16));
    }
    return _titleLabel;
}



- (UILabel *)oldPriceLabel{
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc]init];
        _oldPriceLabel.textColor = K_B8B8B8;
        _oldPriceLabel.font = FONT_Regular(X(12));
    }
    return _oldPriceLabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = K_333333;
        _priceLabel.font = FONT_Regular(X(14));
    }
    return _priceLabel;
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
