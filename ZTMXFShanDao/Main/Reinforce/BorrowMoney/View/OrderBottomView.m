//
//  OrderBottomView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "OrderBottomView.h"
#import "MyOrderModel.h"

@interface OrderBottomView ()

@property (nonatomic, strong) UILabel *orderNumLabel;

@property (nonatomic, strong) UILabel *orderTimeLabel;

@property (nonatomic, strong) UILabel *deliverTimeLabel;

@property (nonatomic, strong) UILabel *transactionTimeLabel;

@property (nonatomic, strong) UILabel *titleLabelThree;

@property (nonatomic, strong) UILabel *titleLabelFour;

@end

@implementation OrderBottomView

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
- (void)setOrderDetailModel:(MyOrderDetailModel *)orderDetailModel{
    _orderDetailModel = orderDetailModel;
    if (_orderDetailModel) {
        self.orderNumLabel.text = _orderDetailModel.orderNo;
        self.orderTimeLabel.text = _orderDetailModel.purchaseTime;
        self.deliverTimeLabel.text = _orderDetailModel.gmtDeliverStr;
        self.transactionTimeLabel.text = _orderDetailModel.transactionTime;
        
        if (_orderDetailModel.gmtDeliverStr.length == 0) {
            // 暂无发货时间
            self.titleLabelThree.hidden = YES;
            self.deliverTimeLabel.hidden = YES;
            self.titleLabelFour.frame = CGRectMake(AdaptedWidth(12), self.orderTimeLabel.bottom+AdaptedHeight(10), AdaptedWidth(65),_orderNumLabel.height);
            self.transactionTimeLabel.frame = CGRectMake(_orderNumLabel.left, self.titleLabelFour.top,_orderNumLabel.width,_orderNumLabel.height);
        }else{
            self.titleLabelThree.hidden = NO;
            self.deliverTimeLabel.hidden = NO;
            self.titleLabelThree.frame = CGRectMake(AdaptedWidth(12), self.orderTimeLabel.bottom+AdaptedHeight(10), AdaptedWidth(65), _orderNumLabel.height);
            self.deliverTimeLabel.frame = CGRectMake(_orderNumLabel.left, self.titleLabelThree.top, _orderNumLabel.width, 20);
            [self.titleLabelFour setFrame:CGRectMake(AdaptedWidth(12), self.titleLabelThree.bottom+AdaptedHeight(10), AdaptedWidth(65), _orderNumLabel.height)];
            [self.transactionTimeLabel setFrame:CGRectMake(_orderNumLabel.left, self.titleLabelFour.top, _orderNumLabel.width, _orderNumLabel.height)];
        }
        if (_orderDetailModel.transactionTime.length == 0) {
            self.titleLabelFour.hidden = YES;
            self.height = _titleLabelThree.bottom+AdaptedWidth(12);
        }else{
            self.titleLabelFour.hidden = NO;
            self.height = _titleLabelFour.bottom+AdaptedWidth(12);
        }
        
//        [self layoutIfNeeded];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1.0)];
    [lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self addSubview:lineLabel];
    
    UILabel *titleLabelOne = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [titleLabelOne setFrame:CGRectMake(AdaptedWidth(12),AdaptedWidth(12), AdaptedWidth(65), AdaptedWidth(20))];
    titleLabelOne.text = @"订单编号";
    [self addSubview:titleLabelOne];
    
    self.orderNumLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.orderNumLabel setFrame:CGRectMake(AdaptedWidth(95), titleLabelOne.top,AdaptedWidth(264), AdaptedWidth(20))];
    [self addSubview:self.orderNumLabel];
    
    UILabel *titleLabelTwo = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [titleLabelTwo setFrame:CGRectMake(titleLabelOne.left, titleLabelOne.bottom+AdaptedHeight(10), titleLabelOne.width,titleLabelOne.height)];
    titleLabelTwo.text = @"下单时间";
    [self addSubview:titleLabelTwo];
    
    self.orderTimeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.orderTimeLabel setFrame:CGRectMake(_orderNumLabel.left, titleLabelTwo.top,_orderNumLabel.width, AdaptedWidth(20))];
    [self addSubview:self.orderTimeLabel];
    
    self.titleLabelThree = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.titleLabelThree setFrame:CGRectMake(titleLabelOne.left, titleLabelTwo.bottom+AdaptedHeight(10),titleLabelOne.width, AdaptedWidth(20))];
    self.titleLabelThree.text = @"发货时间";
    [self addSubview:self.titleLabelThree];
    
    self.deliverTimeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.deliverTimeLabel setFrame:CGRectMake(_orderNumLabel.left, self.titleLabelThree.top,_orderNumLabel.width, AdaptedWidth(20))];
    [self addSubview:self.deliverTimeLabel];
    
    self.titleLabelFour = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.titleLabelFour setFrame:CGRectMake(titleLabelOne.left, self.titleLabelThree.bottom+AdaptedHeight(10), titleLabelOne.width, AdaptedWidth(20))];
    self.titleLabelFour.text = @"成交时间";
    [self addSubview:self.titleLabelFour];
    
    self.transactionTimeLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.transactionTimeLabel setFrame:CGRectMake(_orderNumLabel.left, self.titleLabelFour.top,_orderNumLabel.width,AdaptedWidth(20))];
    [self addSubview:self.transactionTimeLabel];
    
    self.height = self.titleLabelFour.bottom + AdaptedWidth(15);
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
