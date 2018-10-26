//
//  DefaultAddressView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "DefaultAddressView.h"
#import "LSAddressModel.h"

@interface DefaultAddressView ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *modifyButton;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation DefaultAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self configueSubViews];
    }
    return self;
}

#pragma mark - setter
- (void)setDefaultAddress:(LSAddressModel *)defaultAddress{
    _defaultAddress = defaultAddress;
    
    self.nameLabel.text = _defaultAddress.consignee;
    self.phoneLabel.text = _defaultAddress.consigneeMobile;
    NSString *addressStr = [NSString stringWithFormat:@"%@%@%@%@",_defaultAddress.province,_defaultAddress.city,_defaultAddress.region,_defaultAddress.detailAddress];
    self.addressLabel.text = addressStr;
}

#pragma mark - 点击编辑按钮
- (void)clickEditButton:(UIButton *)sender{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickEditDefaultAddress)]) {
        [self.delegete clickEditDefaultAddress];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    CGSize labelSize = [@"" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(14)]} context:nil].size;
    
    CGFloat labelLeftSpace = X(18);
    CGFloat labelHeight    = X(49);
    CGFloat labelWidth     = KW - X(70) - X(18) - X(18) - X(10);
    UILabel *titleLabelOne = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    titleLabelOne.numberOfLines = 1;
    [titleLabelOne setFrame:CGRectMake(labelLeftSpace, 0, AdaptedWidth(70), labelHeight)];
    titleLabelOne.text = @"收货人:";
    [self addSubview:titleLabelOne];
//    [self setLabelSizeWithLabel:titleLabelOne title:titleLabelOne.text];
    self.nameLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.nameLabel setFrame:CGRectMake(titleLabelOne.right+X(10.0), 0, labelWidth, labelHeight)];
    [self addSubview:self.nameLabel];
    
    UIView *lineOne = [[UIView alloc]initWithFrame:CGRectMake(X(19), titleLabelOne.bottom, KW - X(19), X(1))];
    lineOne.backgroundColor = K_BackgroundColor;
    [self addSubview:lineOne];
    
    UILabel *titleLabelTwo = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    titleLabelTwo.numberOfLines = 1;
    [titleLabelTwo setFrame:CGRectMake(labelLeftSpace, lineOne.bottom, X(70), labelHeight)];
    titleLabelTwo.text = @"手机号:";
    [self addSubview:titleLabelTwo];
//    [self setLabelSizeWithLabel:titleLabelTwo title:titleLabelTwo.text];
    self.phoneLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.phoneLabel setFrame:CGRectMake(titleLabelTwo.right+X(10), lineOne.bottom, labelWidth, labelHeight)];
    [self addSubview:self.phoneLabel];
    
    UIView *lineTwo = [[UIView alloc]initWithFrame:CGRectMake(X(19), titleLabelTwo.bottom, KW - X(19), X(1))];
    lineTwo.backgroundColor = K_BackgroundColor;
    [self addSubview:lineTwo];
    
    UILabel *titleLabelThree = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    titleLabelThree.numberOfLines = 1;
    [titleLabelThree setFrame:CGRectMake(labelLeftSpace, lineTwo.bottom, X(70), labelHeight)];
    titleLabelThree.text = @"收货地址:";
    [self addSubview:titleLabelThree];
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelThree.right+X(10.0), lineTwo.bottom, labelWidth, labelHeight)];
    self.addressLabel.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    self.addressLabel.font = [UIFont systemFontOfSize:X(14)];
    self.addressLabel.numberOfLines = 1;
    [self addSubview:self.addressLabel];
    
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(19), titleLabelThree.bottom, KW - X(19), X(1.0))];
    [self.lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self addSubview:self.lineLabel];
    
    self.modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.modifyButton setFrame:CGRectMake(0, _lineLabel.bottom+AdaptedHeight(16), AdaptedWidth(100), labelSize.height)];
    self.modifyButton.right = SCREEN_WIDTH - 12;
    [self.modifyButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(15)]];
    [self.modifyButton setTitleColor:[UIColor colorWithHexString:@"2BADF0"] forState:UIControlStateNormal];
    [self.modifyButton setTitle:@"修改地址" forState:UIControlStateNormal];
//    [self.modifyButton setImage:[UIImage imageNamed:@"XL_address_edit"] forState:UIControlStateNormal];
    [self.modifyButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
//    [self.modifyButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self addSubview:self.modifyButton];
    [self.modifyButton addTarget:self action:@selector(clickEditButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setLabelSizeWithLabel:(UILabel *)label title:(NSString *)title{
    CGSize labelSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(14)]} context:nil].size;
    label.width = labelSize.width;
    labelSize.height = labelSize.height;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
