//
//  MyOrderCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MyOrderCell.h"
#import "MyOrderModel.h"

@interface MyOrderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodspriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *linelabel;

@property (weak, nonatomic) IBOutlet UILabel *purchaseTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@property (weak, nonatomic) IBOutlet UIButton *orderStatusButton;

@end

@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.goodsNameLabel setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
    [self.goodsNameLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
    [self.goodspriceLabel setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
    [self.goodspriceLabel setFont:[UIFont boldSystemFontOfSize:AdaptedWidth(18)]];
    [self.linelabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self.purchaseTimeLabel setTextColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR]];
    [self.orderStatusLabel setTextColor:[UIColor colorWithHexString:COLOR_RED_STR]];
    [self.orderStatusButton setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateNormal];
    self.orderStatusButton.layer.borderWidth = 1.0;
    self.orderStatusButton.layer.borderColor = [UIColor colorWithHexString:@"f85c38"].CGColor;
    self.orderStatusButton.layer.cornerRadius = 4.0;
    self.orderStatusButton.layer.masksToBounds = YES;
    self.orderStatusButton.hidden = YES;
}

- (IBAction)clickWriteAddress:(UIButton *)sender {
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickWriteAddress:)]) {
        [self.delegete clickWriteAddress:self.orderModel];
    }
}

- (void)setOrderModel:(MyOrderModel *)orderModel{
    _orderModel = orderModel;
    
    if (_orderModel) {
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:_orderModel.url] placeholderImage:[UIImage imageNamed:@""]];
        self.goodsNameLabel.text = _orderModel.name;
        self.goodspriceLabel.text = [NSString stringWithFormat:@"¥%@元",[NSDecimalNumber stringWithFloatValue:[_orderModel.price floatValue]]];
        self.purchaseTimeLabel.text = _orderModel.purchaseTime;
        if (_orderModel.orderStatus == -1) {
            // 待填写地址
            self.orderStatusLabel.hidden = YES;
            self.orderStatusButton.hidden = NO;
            [self.orderStatusButton setTitle:_orderModel.orderStatusStr forState:UIControlStateNormal];
        }else{
            self.orderStatusButton.hidden = YES;
            self.orderStatusLabel.hidden = NO;
            self.orderStatusLabel.text = _orderModel.orderStatusStr;
            if ([_orderModel.orderStatusStr isEqualToString:@"已完成"]) {
                [self.orderStatusLabel setTextColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR]];
            }else{
                [self.orderStatusLabel setTextColor:[UIColor colorWithHexString:COLOR_RED_STR]];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
