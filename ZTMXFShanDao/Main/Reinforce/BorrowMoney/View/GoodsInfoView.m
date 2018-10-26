//
//  GoodsInfoView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "GoodsInfoView.h"
#import "MyOrderModel.h"
#import "LSBorrwingCashInfoModel.h"

@interface GoodsInfoView ()

@property (nonatomic, strong) UIImageView *goodsImgView;

@property (nonatomic, strong) UILabel *goodsNameLabel;

@property (nonatomic, strong) UILabel *reducedPriceLabel;

@property (nonatomic, strong) UILabel *originalPriceLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UIButton *goodsInfoBtn;

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation GoodsInfoView

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
-(void)setGoodsInfoType:(LSGoodsInfoType)goodsInfoType{
    _goodsInfoType = goodsInfoType;
}

- (void)setOrderDetailModel:(MyOrderDetailModel *)orderDetailModel{
    _orderDetailModel = orderDetailModel;
    if (_orderDetailModel) {
        _reducedPriceLabel.font = [UIFont systemFontOfSize:AdaptedWidth(18)];

        self.goodsImgView.top = 12;
        [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:_orderDetailModel.url] placeholderImage:[UIImage imageNamed:@""]];
        self.goodsNameLabel.text = _orderDetailModel.name;
        NSString * reducedStr = [NSString stringWithFormat:@"¥%@",[NSDecimalNumber stringWithFloatValue:[_orderDetailModel.price floatValue]]];
        CGSize reducedSize = [reducedStr sizeWithFont:_reducedPriceLabel.font maxW:AdaptedWidth(100)];
        _reducedPriceLabel.width = reducedSize.width;
        self.reducedPriceLabel.text = reducedStr;
        NSString *str = [NSString stringWithFormat:@"原价%@元",[NSDecimalNumber stringWithFloatValue:[_orderDetailModel.originPrice floatValue]]];
        CGSize size = [str sizeWithFont:_originalPriceLabel.font maxW:AdaptedWidth(100)];
        self.originalPriceLabel.left = _reducedPriceLabel.right+AdaptedWidth(5);
        self.originalPriceLabel.width = size.width;
        self.originalPriceLabel.text = str;
        self.lineLabel.left = _originalPriceLabel.left;
        self.lineLabel.width = _originalPriceLabel.width;
        self.countLabel.hidden = (self.goodsInfoType == LSGoodsInfoLoanType) ? YES : NO;
        self.goodsInfoBtn.hidden = !self.countLabel.hidden;
    }
}

-(void)setGoodsInfoModel:(GoodsInfoModel *)goodsInfoModel{
    _goodsInfoModel = goodsInfoModel;
    if (_goodsInfoModel) {
        self.goodsImgView.top = 12;
        [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:_goodsInfoModel.goodsIcon] placeholderImage:[UIImage imageNamed:@""]];
        self.goodsNameLabel.text = _goodsInfoModel.name;
        _reducedPriceLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        NSString *reducedStr = [NSString stringWithFormat:@"优惠价:%.2f元",[_goodsInfoModel.price floatValue]];
        CGSize reducedSize = [reducedStr sizeWithFont:_reducedPriceLabel.font maxW:AdaptedWidth(120)];

        self.reducedPriceLabel.width = reducedSize.width;
        self.reducedPriceLabel.text = reducedStr;
        
        
        NSString *originaStr = [NSString stringWithFormat:@"原价%@元",[NSDecimalNumber stringWithFloatValue:[_goodsInfoModel.originPrice floatValue]]];
        CGSize originaStrSize = [originaStr sizeWithFont:_originalPriceLabel.font maxW:AdaptedWidth(100)];
        self.originalPriceLabel.left = _reducedPriceLabel.right+AdaptedWidth(5);
        self.originalPriceLabel.width = originaStrSize.width;
        self.originalPriceLabel.text = originaStr;
        
        self.lineLabel.left = _originalPriceLabel.left;
        self.lineLabel.width = _originalPriceLabel.width;
        self.countLabel.hidden = (self.goodsInfoType == LSGoodsInfoLoanType) ? YES : NO;
        self.goodsInfoBtn.hidden = !self.countLabel.hidden;
    }
}

#pragma mark - 点击商品详情按钮
- (void)clickDetailButton:(UIButton *)sender{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickGoodsDetailButton)]) {
        [self.delegete clickGoodsDetailButton];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(AdaptedWidth(12),AdaptedWidth(17),AdaptedWidth(68), AdaptedWidth(68))];
    [_goodsImgView.layer setBorderColor:[UIColor colorWithHexString:@"F2F4F5"].CGColor];
    [_goodsImgView.layer setBorderWidth:1];
    [self addSubview:self.goodsImgView];
    
    self.goodsNameLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(18) alignment:NSTextAlignmentLeft];
    [self.goodsNameLabel setFrame:CGRectMake(AdaptedWidth(95), AdaptedWidth(14),AdaptedWidth(264), AdaptedWidth(25))];
    [self addSubview:self.goodsNameLabel];
    
    self.reducedPriceLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(18) alignment:NSTextAlignmentLeft];
    [self.reducedPriceLabel setFrame:CGRectMake(_goodsNameLabel.left,_goodsNameLabel.bottom+15.0,AdaptedWidth(75), AdaptedWidth(25))];
    _reducedPriceLabel.bottom = _goodsImgView.bottom;
    [self addSubview:self.reducedPriceLabel];
    
    self.originalPriceLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:AdaptedWidth(12) alignment:NSTextAlignmentLeft];
    [self.originalPriceLabel setFrame:CGRectMake(_reducedPriceLabel.right+8.0,0.0, AdaptedWidth(100),AdaptedWidth(17))];
    self.originalPriceLabel.bottom = self.reducedPriceLabel.bottom;
    [self addSubview:self.originalPriceLabel];
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(_originalPriceLabel.left, 0, _originalPriceLabel.width, 1)];
    self.lineLabel.centerY = self.originalPriceLabel.centerY;
    [self.lineLabel setBackgroundColor:[UIColor colorWithHexString:@"CFCECE"]];
    [self addSubview:self.lineLabel];
    
    self.goodsInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.goodsInfoBtn setFrame:CGRectMake(0, 0, AdaptedWidth(75), AdaptedWidth(20))];
    [self.goodsInfoBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(14)]];
    [self.goodsInfoBtn setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] forState:UIControlStateNormal];
    [self.goodsInfoBtn setTitle:@"商品详情" forState:UIControlStateNormal];
    [self.goodsInfoBtn setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
    [self.goodsInfoBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -AdaptedWidth(20), 0, 0)];
    [self.goodsInfoBtn setImageEdgeInsets:UIEdgeInsetsMake(0, AdaptedWidth(65), 0, 0)];
    self.goodsInfoBtn.centerY = self.reducedPriceLabel.centerY;
    self.goodsInfoBtn.right = SCREEN_WIDTH - AdaptedWidth(10.0);
    [self addSubview:self.goodsInfoBtn];
    
    UIButton *goodsInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [goodsInfoButton setFrame:self.bounds];
    [goodsInfoButton addTarget:self action:@selector(clickDetailButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:goodsInfoButton];
    
    self.countLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:AdaptedWidth(12) alignment:NSTextAlignmentRight];
    [self.countLabel setFrame:CGRectMake(0, 0, 75, 20)];
    self.countLabel.text = @"x1";
    self.countLabel.bottom = self.reducedPriceLabel.bottom;
    self.countLabel.right = SCREEN_WIDTH - AdaptedWidth(12);
    [self addSubview:self.countLabel];
    self.countLabel.hidden = YES;
    self.height = AdaptedWidth(108);
}

@end
