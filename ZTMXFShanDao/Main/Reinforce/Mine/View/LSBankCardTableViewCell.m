//
//  LSBankCardTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBankCardTableViewCell.h"
#import "BankCardModel.h"

@implementation LSBankCardTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSBankCardTableViewCell";
    LSBankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSBankCardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
//        self.backgroundColor = [UIColor whiteColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    /** 背景图片view */
    self.bgImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.contentView];
//    self.bgImageView.backgroundColor = [UIColor redColor];
//    self.bgImageView.layer.cornerRadius = 10.0;

    
    /** 银行卡Icon */
    self.iconImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self.bgImageView];
    
    /** 银行卡名称 */
    self.bankCardNameLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:18 alignment:NSTextAlignmentLeft];
    [self.bgImageView addSubview:self.bankCardNameLabel];
    
    /** 银行卡类型 */
    self.bankCardTypeLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:13 alignment:NSTextAlignmentLeft];
    [self.bgImageView addSubview:self.bankCardTypeLabel];
    
    /** 银行卡号 */
    self.bankCardNumberLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:18 alignment:NSTextAlignmentLeft];
    [self.bgImageView addSubview:self.bankCardNumberLabel];
    
    /** 删除按钮 */
    self.deleteButton = [UIButton setupButtonWithSuperView:self.bgImageView withObject:self action:@selector(deleteBankCard)];
    [self.deleteButton setImage:[UIImage imageNamed:@"bankCard_delete"] forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    
    /** 背景imageview */
    self.bgImageView.frame = CGRectMake(12.5, 0.0, cellWidth - 25.0, cellHeight - 10);
    /** 银行卡Icon */
    CGFloat iconImageViewW = 36.;
    CGFloat iconImageViewX = 15.0;
    CGFloat iconImageViewY = 16.0;
    self.iconImageView.frame = CGRectMake(iconImageViewX, iconImageViewY, iconImageViewW, iconImageViewW);
    /** 银行卡名称 */
    self.bankCardNameLabel.frame = CGRectMake(_iconImageView.right+10, 12.0, CGRectGetWidth(self.bgImageView.frame) - 100.0, 25.0);
    /** 银行卡类型 */
    self.bankCardTypeLabel.frame = CGRectMake(CGRectGetMinX(self.bankCardNameLabel.frame), CGRectGetMaxY(self.bankCardNameLabel.frame), 200.0, 18.0);
    /** 银行卡号 */
    self.bankCardNumberLabel.frame = CGRectMake(CGRectGetMinX(self.bankCardNameLabel.frame),_bankCardTypeLabel.bottom+10, CGRectGetWidth(self.bgImageView.frame) - 80.0, 25.0);
    /** 删除按钮 */
    self.deleteButton.frame = CGRectMake(CGRectGetWidth(self.bgImageView.frame) - 44.0, 0.0, 44.0, 50.0);
    
}

- (void)setBankCardModel:(BankCardModel *)bankCardModel{
    if (_bankCardModel != bankCardModel) {
        _bankCardModel = bankCardModel;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_bankCardModel.bankIcon]];
    NSInteger fromIndex = _bankCardModel.cardNumber.length - 4;
    NSString *bankCard = [NSString string];
    if (fromIndex > 0) {
        bankCard = [_bankCardModel.cardNumber substringFromIndex:fromIndex];
    }

    self.bankCardTypeLabel.text = @"储蓄卡";
    self.bankCardNumberLabel.text = [NSString stringWithFormat:@"****  ****  ****  %@",bankCard];
    if (bankCardModel.isMain == 1) {
        //  是主卡
        self.deleteButton.hidden = YES;
        self.bankCardNameLabel.text = [NSString stringWithFormat:@"%@(主卡)",_bankCardModel.bankName];
    } else {
        self.bankCardNameLabel.text = _bankCardModel.bankName;
        self.deleteButton.hidden = NO;
    }
        
}

#pragma mark - 删除银行卡
- (void)deleteBankCard{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bankCardTableViewCellDeleteBankCard:)]) {
        [self.delegate bankCardTableViewCellDeleteBankCard:self];
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
