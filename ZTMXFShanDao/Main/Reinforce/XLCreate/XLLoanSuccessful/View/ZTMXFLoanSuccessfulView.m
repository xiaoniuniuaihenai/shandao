//
//  ZTMXFLoanSuccessfulView.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/1.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanSuccessfulView.h"

@interface ZTMXFLoanSuccessfulView ()


@property (nonatomic, strong)UILabel * descLabel;

@end


@implementation ZTMXFLoanSuccessfulView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView * imgView = [UIImageView new];
        imgView.image = [UIImage imageNamed:@"XL_Loan_ results"];
        [self addSubview:imgView];
        
        UILabel * titleLabel = [UILabel new];
        titleLabel.textColor = K_333333;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = FONT_Regular(18 * PX);
        titleLabel.text = @"恭喜您，借款成功";
        [self addSubview:titleLabel];
        
        UILabel * subLabel = [UILabel new];
        subLabel.textColor = K_666666;
        subLabel.textAlignment = NSTextAlignmentCenter;
        subLabel.font = FONT_Regular(14 * PX);
        subLabel.text = @"我们将在3分钟之内完成放款，请关注账单";
        [self addSubview:subLabel];
        
        _descLabel = [UILabel new];
        [self addSubview:_descLabel];
        _descLabel.backgroundColor = COLOR_SRT(@"#FFEAAB");
        _descLabel.textColor = K_666666;
        _descLabel.font = FONT_Regular(14 * PX);
        
        _descLabel.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .bottomEqualToView(self)
        .heightIs(40 * PX);
        
        
        
        
        
        imgView.sd_layout
        .topSpaceToView(self, 25 * PX)
        .heightIs(75 * PX)
        .widthIs(180 * PX)
        .centerXEqualToView(self);
        
        titleLabel.sd_layout
        .topSpaceToView(imgView, 13 * PX)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(20 * PX);
        
        subLabel.sd_layout
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(18 * PX)
        .topSpaceToView(titleLabel, 10 * PX);
        
    }
    return self;
}

- (void)setDescStr:(NSString *)descStr
{
    _descStr = descStr;
    _descLabel.text = [NSString stringWithFormat:@"    %@", descStr];
    [_descLabel sizeToFit];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

