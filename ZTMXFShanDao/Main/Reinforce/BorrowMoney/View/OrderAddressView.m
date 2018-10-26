//
//  OrderAddressView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "OrderAddressView.h"
#import "LSAddressModel.h"

@interface OrderAddressView ()

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation OrderAddressView

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
- (void)setOrderAddressModel:(LSOrderAddressModel *)orderAddressModel{
    _orderAddressModel = orderAddressModel;
    
    self.nameLabel.text = _orderAddressModel.consignee;
    self.phoneLabel.text = _orderAddressModel.consigneeMobile;
    NSString *addressStr = _orderAddressModel.address;
    CGSize size = [addressStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-AdaptedWidth(112), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(14)]} context:nil].size;
    self.addressLabel.height = size.height;
    self.addressLabel.text = addressStr;
    self.lineLabel.top = self.addressLabel.bottom + 19.0;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    CGSize labelSize = [@"" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AdaptedWidth(14)]} context:nil].size;
    
    UILabel *titleLabelOne = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [titleLabelOne setFrame:CGRectMake(AdaptedWidth(12), AdaptedHeight(12), AdaptedWidth(65),AdaptedWidth(20))];
    titleLabelOne.text = @"收货人";
    [self addSubview:titleLabelOne];
    
    self.nameLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.nameLabel setFrame:CGRectMake(AdaptedWidth(95), AdaptedHeight(12), AdaptedWidth(263), labelSize.height)];
    self.nameLabel.centerY = titleLabelOne.centerY;
    [self addSubview:self.nameLabel];
    
    UILabel *titleLabelTwo = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [titleLabelTwo setFrame:CGRectMake(titleLabelOne.left, titleLabelOne.bottom+AdaptedHeight(10), titleLabelOne.width, labelSize.height)];
    titleLabelTwo.text = @"手机号";
    [self addSubview:titleLabelTwo];
    
    self.phoneLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.phoneLabel setFrame:CGRectMake(_nameLabel.left, 0,_nameLabel.width,AdaptedWidth(20))];
    self.phoneLabel.centerY = titleLabelTwo.centerY;
    [self addSubview:self.phoneLabel];
    
    UILabel *titleLabelThree = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [titleLabelThree setFrame:CGRectMake(12, titleLabelTwo.bottom+AdaptedHeight(10),titleLabelOne.width, labelSize.height)];
    titleLabelThree.text = @"收货地址";
    [self addSubview:titleLabelThree];
    
    self.addressLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.addressLabel setFrame:CGRectMake(AdaptedWidth(100), titleLabelThree.top,_nameLabel.width, labelSize.height)];
    self.addressLabel.numberOfLines = 0;
    [self addSubview:self.addressLabel];
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.addressLabel.bottom + 19.0, SCREEN_WIDTH, 1.0)];
    [self.lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self addSubview:self.lineLabel];
    
    self.height = self.addressLabel.bottom + AdaptedWidth(20.);
    _lineLabel.bottom = self.height;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.height = self.addressLabel.bottom + 20.0;
}

@end
