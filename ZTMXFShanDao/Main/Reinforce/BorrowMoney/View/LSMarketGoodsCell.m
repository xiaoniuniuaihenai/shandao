//
//  LSMarketGoodsCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/17.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSMarketGoodsCell.h"
#import "LSLoanSupermarketModel.h"

@interface LSMarketGoodsCell ()

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *moneyLimitLabel;
@property (nonatomic, strong) UILabel *borrowLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UILabel *labelOne;
@property (nonatomic, strong) UILabel *labelTwo;

@end

@implementation LSMarketGoodsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加子视图
        [self setSubViews];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.leftImgView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.moneyLimitLabel];
        [self.contentView addSubview:self.borrowLabel];
        [self.contentView addSubview:self.lineLabel];
        [self.contentView addSubview:self.labelOne];
        [self.contentView addSubview:self.labelTwo];
        
    }
    return self;
}







- (void)setSubViews{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.leftImgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.moneyLimitLabel];
    [self.contentView addSubview:self.borrowLabel];
    [self.contentView addSubview:self.lineLabel];
    
    [self.contentView addSubview:self.labelOne];
    [self.contentView addSubview:self.labelTwo];
    
    self.iconImg.left = AdaptedWidth(8);
    self.iconImg.centerY = 75/2.0;
    _leftImgView.top = 0;
    _leftImgView.left = 0;
    self.titleLabel.top = 15;
    self.titleLabel.left = self.iconImg.right + AdaptedWidth(9);
    self.subTitleLabel.top = self.titleLabel.bottom + 5;
    self.subTitleLabel.left = self.titleLabel.left;
    self.moneyLimitLabel.top = self.titleLabel.top;
    self.moneyLimitLabel.right = Main_Screen_Width - AdaptedWidth(10);
    self.borrowLabel.top = self.moneyLimitLabel.bottom + 9;
    self.borrowLabel.right = self.moneyLimitLabel.right;
    self.subTitleLabel.width = Main_Screen_Width - 110 - _iconImg.right;
    self.lineLabel.bottom = 75;
    self.lineLabel.left = 10;
    
    _labelOne.left = _titleLabel.right + 2;
    _labelOne.centerY = _titleLabel.centerY;
    
    _labelTwo.left = _labelOne.right + 2;
    _labelTwo.centerY = _titleLabel.centerY;
}

- (void)setLoanSupermarketModel:(LSLoanSupermarketModel *)loanSupermarketModel{
    _loanSupermarketModel = loanSupermarketModel;
    
    if ([_loanSupermarketModel.iconUrl length]) {
        NSURL * icUrl = [NSURL URLWithString:_loanSupermarketModel.iconUrl];
        [_iconImg sd_setImageWithURL:icUrl placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                [_iconImg setBackgroundColor:[UIColor clearColor]];
                _iconImg.contentMode = UIViewContentModeScaleToFill;
            }else{
                [_iconImg setBackgroundColor:[UIColor colorWithHexString:@"e3e3e3"]];
                _iconImg.contentMode = UIViewContentModeScaleAspectFit;
            }
        }];
    }
    if (_loanSupermarketModel.iconLabel == 1) {
        _leftImgView.image = [UIImage imageNamed:@"recommend"];
    }else if (_loanSupermarketModel.iconLabel == 2){
        _leftImgView.image = [UIImage imageNamed:@"secondPass"];
    }else if (_loanSupermarketModel.iconLabel == 3){
        _leftImgView.image = [UIImage imageNamed:@"welfare"];
    }else if (_loanSupermarketModel.iconLabel == 4){
        _leftImgView.image = [UIImage imageNamed:@"publicPraise"];
    }
    
    _titleLabel.text = _loanSupermarketModel.lsmName;
    
    CGSize titleSize = [_titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(17)]} context:nil].size;
    _titleLabel.width = titleSize.width;
    
    if (_loanSupermarketModel.marketLabel.count >0) {
        if (_loanSupermarketModel.marketLabel.count >=1) {
            _labelOne.text = [_loanSupermarketModel.marketLabel objectAtIndex:0];
            CGSize labelOneSize = [_labelOne.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
            _labelOne.left = _titleLabel.right + 2;
            _labelOne.width = labelOneSize.width+4;
            _labelTwo.hidden = YES;
        }
        if (_loanSupermarketModel.marketLabel.count == 2) {
            _labelTwo.text = [_loanSupermarketModel.marketLabel objectAtIndex:1];
            CGSize labelTwoSize = [_labelTwo.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} context:nil].size;
            _labelTwo.left = _labelOne.right + 2;
            _labelTwo.width = labelTwoSize.width+4;
            _labelTwo.hidden = NO;
        }
    }else{
        _labelOne.hidden = YES;
        _labelTwo.hidden = YES;
    }
    
    _subTitleLabel.text = _loanSupermarketModel.lsmIntro;
    
    UIColor * redColor = [UIColor colorWithHexString:COLOR_RED_STR];
    
    NSArray *marketPoint = [_loanSupermarketModel.marketPoint componentsSeparatedByString:@","];
    if (marketPoint.count > 0) {
        NSString *moneyStr = [NSString stringWithFormat:@"%@ 额度",marketPoint[0]];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:moneyStr];
        [attStr addAttributes:@{NSForegroundColorAttributeName:redColor,NSFontAttributeName:[UIFont systemFontOfSize:17]} range:[moneyStr rangeOfString:marketPoint[0]]];
        _moneyLimitLabel.attributedText = attStr;
        _borrowLabel.text = marketPoint[1];
    }
}

-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        _iconImg.layer.cornerRadius = _iconImg.width/2.;
        _iconImg.layer.masksToBounds = YES;
    }
    return _iconImg;
}

- (UIImageView *)leftImgView{
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53, 46)];
    }
    return _leftImgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(17) alignment:NSTextAlignmentLeft];
        [_titleLabel setFrame:CGRectMake(0, 0, 80, 24)];
        
    }
    return _titleLabel;
}

- (UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"2aadf0"] fontSize:11 alignment:NSTextAlignmentCenter];
        [_labelOne setFrame:CGRectMake(0, 0, 50, 16)];
        _labelOne.text = @"极快贷";
        _labelOne.layer.cornerRadius = 2.0;
        _labelOne.layer.borderWidth = 1;
        _labelOne.layer.borderColor = [UIColor colorWithHexString:@"2aadf0"].CGColor;
        _labelOne.layer.masksToBounds = YES;
    }
    return _labelOne;
}

-(UILabel *)labelTwo{
    if (!_labelTwo) {
        _labelTwo = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"f6a623"] fontSize:11 alignment:NSTextAlignmentCenter];
        [_labelTwo setFrame:CGRectMake(0, 0, 50, 16)];
        _labelTwo.text = @"不查征信";
        _labelTwo.layer.cornerRadius = 2.0;
        _labelTwo.layer.borderWidth = 1;
        _labelTwo.layer.borderColor = [UIColor colorWithHexString:@"f6a623"].CGColor;
        _labelTwo.layer.masksToBounds = YES;
    }
    return _labelTwo;
}

-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
        [_subTitleLabel setFrame:CGRectMake(0, 0, 160, 20)];
    }
    return _subTitleLabel;
}

-(UILabel *)moneyLimitLabel{
    if (!_moneyLimitLabel) {
        _moneyLimitLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:14 alignment:NSTextAlignmentRight];
        [_moneyLimitLabel setFrame:CGRectMake(0, 0, 100, 20)];
    }
    return _moneyLimitLabel;
}

- (UILabel *)borrowLabel{
    if (!_borrowLabel) {
        _borrowLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:12 alignment:NSTextAlignmentRight];
        [_borrowLabel setFrame:CGRectMake(0, 0, 100, 20)];
    }
    return _borrowLabel;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-18, 1)];
        _lineLabel.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    }
    return _lineLabel;
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
