//
//  ALABankCardInfoView.m
//  ALAFanBei
//
//  Created by yangpenghua on 17/2/17.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ALABankCardInfoView.h"

@implementation ALABankCardInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}


//  添加子控件
- (void)setupViews{
    /** 银行icon ImageView */
    self.bankIconImageView = [UIImageView setupImageViewWithImageName:@"" withSuperView:self];
    self.bankIconImageView.contentMode = UIViewContentModeCenter;
    self.bankIconImageView.backgroundColor = [UIColor whiteColor];
    
    
    /** 银行账户 */
    self.bankAccountLabel = [UILabel labelWithTitleColorStr:@"111111" fontSize:17 alignment:NSTextAlignmentLeft];
    self.bankAccountLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bankAccountLabel];
    self.bankAccountLabel.text = @"收款账户";
    
    /** 银行名字 */
    self.bankNameLabel = [UILabel labelWithTitleColorStr:@"111111" fontSize:14 alignment:NSTextAlignmentLeft];
    self.bankNameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bankNameLabel];
    
    /** 尾号 */
    self.tailNumberLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:16 alignment:NSTextAlignmentRight];
    self.tailNumberLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tailNumberLabel];
    
}

//  布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat leftMargin = 12.0;
    
    /** 银行icon ImageView */
    CGFloat bankIconImageViewW = 60.0;
    CGFloat bankIconImageViewH = 60.0;
    CGFloat bankIconImageViewX = leftMargin;
    CGFloat bankIconImageViewY = (viewHeight - bankIconImageViewW) / 2.0;
    self.bankIconImageView.frame = CGRectMake(bankIconImageViewX, bankIconImageViewY, bankIconImageViewW, bankIconImageViewH);
    
    /** 银行账户 */
    CGFloat bankAccountLabelX = CGRectGetMaxX(self.bankIconImageView.frame) + leftMargin;
    CGFloat bankAccountLabelY = CGRectGetMinY(self.bankIconImageView.frame) + 4;
    CGFloat bankAccountLabelW = viewWidth - CGRectGetMaxX(self.bankIconImageView.frame) - 2 * leftMargin;
    CGFloat bankAccountLabelH = 20.0;
    self.bankAccountLabel.frame = CGRectMake(bankAccountLabelX, bankAccountLabelY, bankAccountLabelW, bankAccountLabelH);
  
    /** 银行名字 */
    CGFloat bankNameLabelW = viewWidth - CGRectGetMaxX(self.bankIconImageView.frame) - 2 * leftMargin;
    CGFloat bankNameLabelH = 20.0;
    CGFloat bankNameLabelX = CGRectGetMinX(self.bankAccountLabel.frame);
    CGFloat bankNameLabelY = CGRectGetMaxY(self.bankIconImageView.frame) - bankNameLabelH - 2.0;
    self.bankNameLabel.frame = CGRectMake(bankNameLabelX, bankNameLabelY, bankNameLabelW, bankNameLabelH);
    
    /** 尾号 */
    CGFloat tailNumberLabelW = 200.0;
    CGFloat tailNumberLabelH = viewHeight;
    CGFloat tailNumberLabelX = viewWidth - leftMargin - tailNumberLabelW;
    CGFloat tailNumberLabelY = 0.0;
    self.tailNumberLabel.frame = CGRectMake(tailNumberLabelX, tailNumberLabelY, tailNumberLabelW, tailNumberLabelH);

}

//  设置银行卡数据
- (void)configueBankCardInfoView:(NSDictionary *)infoData{
    
    self.bankNameLabel.text = infoData[kFanBeiBankCardInfoName];
    self.tailNumberLabel.text = infoData[kFanBeiBankCardInfoTailNumber];
    [self.bankIconImageView sd_setImageWithURL:[NSURL URLWithString:infoData[kFanBeiBankCardIconUrl]]];
}


@end
