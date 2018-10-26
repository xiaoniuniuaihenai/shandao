//
//  OrderChoiseBankCardCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "OrderChoiseBankCardCell.h"
#import "BankCardModel.h"

@interface OrderChoiseBankCardCell ()

/** 银行卡icon */
@property (nonatomic, strong) UIImageView *bankCardIcon;
/** 银行名字 */
@property (nonatomic, strong) UILabel *bankNameLabel;
/** 银行卡号 */
@property (nonatomic, strong) UILabel *bankCardNumber;
/** 箭头 */
@property (nonatomic, strong) UIImageView *rowImageView;
/** 细线 */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation OrderChoiseBankCardCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"OrderChoiseBankCardCell";
    OrderChoiseBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OrderChoiseBankCardCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
    /** 银行卡icon */
    [self.contentView addSubview:self.bankCardIcon];
    /** 银行名字 */
    [self.contentView addSubview:self.bankNameLabel];
    /** 银行卡号 */
    [self.contentView addSubview:self.bankCardNumber];
    /** 箭头 */
    [self.contentView addSubview:self.rowImageView];
    /** 细线 */
    [self.contentView addSubview:self.lineView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    /** 银行卡icon */
    self.bankCardIcon.frame = CGRectMake(AdaptedWidth(15.0), AdaptedHeight(20.0), AdaptedWidth(35.0), AdaptedWidth(35.0));
    /** 银行名字 */
    self.bankNameLabel.frame = CGRectMake(CGRectGetMaxX(self.bankCardIcon.frame) + AdaptedWidth(15.0), AdaptedHeight(20.0), viewWidth - 100.0, AdaptedHeight(22.0));
    /** 银行卡号 */
    self.bankCardNumber.frame = CGRectMake(CGRectGetMinX(self.bankNameLabel.frame), CGRectGetMaxY(self.bankNameLabel.frame) + AdaptedHeight(2.0), CGRectGetWidth(self.bankNameLabel.frame), AdaptedHeight(22.0));
    /** 箭头 */
    CGFloat rowImageViewW = AdaptedWidth(8.0);
    self.rowImageView.frame = CGRectMake(viewWidth - rowImageViewW - AdaptedWidth(20.0), 0.0, rowImageViewW, viewHeight);
    /** 细线 */
    self.lineView.frame = CGRectMake(AdaptedWidth(20.0), viewHeight - 0.5, viewWidth - AdaptedWidth(20.0), 0.5);
}

/** 银行卡icon */
- (UIImageView *)bankCardIcon{
    if (_bankCardIcon == nil) {
        _bankCardIcon = [[UIImageView alloc] init];
        _bankCardIcon.userInteractionEnabled = YES;
        _bankCardIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bankCardIcon;
}
/** 银行名字 */
- (UILabel *)bankNameLabel{
    if (_bankNameLabel == nil) {
        _bankNameLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
    }
    return _bankNameLabel;
}
/** 银行卡号 */
- (UILabel *)bankCardNumber{
    if (_bankCardNumber == nil) {
        _bankCardNumber = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:16 alignment:NSTextAlignmentLeft];
    }
    return _bankCardNumber;
}
/** 箭头 */
- (UIImageView *)rowImageView{
    if (_rowImageView == nil) {
        _rowImageView = [[UIImageView alloc] init];
        _rowImageView.userInteractionEnabled = YES;
        _rowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rowImageView.image = [UIImage imageNamed:@"XL_common_right_arrow"];
    }
    return _rowImageView;
}

/** 细线 */
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

/** 设置银行卡数据 */
- (void)setBankCardModel:(BankCardModel *)bankCardModel{
    if (_bankCardModel != bankCardModel) {
        _bankCardModel = bankCardModel;
    }
    
    self.bankNameLabel.text = _bankCardModel.bankName;
    [self.bankCardIcon sd_setImageWithURL:[NSURL URLWithString:_bankCardModel.bankIcon]];
    NSInteger cardNumberLength = _bankCardModel.cardNumber.length;
    if (cardNumberLength > 4) {
        NSString *frontNumber = [_bankCardModel.cardNumber substringToIndex:4];
        NSString *lastNumber = [_bankCardModel.cardNumber substringFromIndex:(cardNumberLength - 4)];
        self.bankCardNumber.text = [NSString stringWithFormat:@"%@ **** **** %@", frontNumber, lastNumber];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
