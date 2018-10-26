//
//  LogisticsInfoView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LogisticsInfoView.h"
#import "MyOrderModel.h"

@interface LogisticsInfoView()
@property (nonatomic,strong) UILabel * lbNameTitle;
@property (nonatomic,strong) UILabel * lbName;
@property (nonatomic,strong) UIView * viLine;
@property (nonatomic,strong) UILabel * lbOrderTitle;
@property (nonatomic,strong) UILabel * lbOrderNumber;
@property (nonatomic,strong) UIButton * btnCopyBtn;


@end
@implementation LogisticsInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self configueSubViews];
        [self configueFrame];
    }
    return self;
}

-(void)configueSubViews{
    [self addSubview:self.lbNameTitle];
    [self addSubview:self.lbName];
    [self addSubview:self.viLine];
    [self addSubview:self.btnCopyBtn];
    [self addSubview:self.lbOrderTitle];
    [self addSubview:self.lbOrderNumber];
}
-(void)configueFrame{
    [_lbNameTitle setFrame:CGRectMake(AdaptedWidth(12), 0, AdaptedWidth(65), AdaptedWidth(50))];
    [_lbName setFrame:CGRectMake(AdaptedWidth(95), 0,AdaptedWidth(264), 50)];
    [_viLine setFrame:CGRectMake(0, _lbName.bottom, Main_Screen_Width, 1)];
    
    [_lbOrderTitle setFrame:CGRectMake(_lbNameTitle.left, _lbNameTitle.bottom, _lbNameTitle.width,_lbNameTitle.height)];
    [_lbOrderNumber setFrame:CGRectMake(_lbName.left, _lbName.bottom, _lbName.width, _lbName.height)];
    [_btnCopyBtn setFrame:CGRectMake(0, 0, AdaptedWidth(60), AdaptedWidth(24))];
    _btnCopyBtn.right = Main_Screen_Width - AdaptedWidth(17);
    _btnCopyBtn.centerY = _lbOrderNumber.centerY;
    _lbOrderNumber.width = _btnCopyBtn.left - _lbOrderNumber.left - AdaptedWidth(10);
    self.height = _lbOrderNumber.bottom;
}

#pragma mark --
-(void)btnCopyBtnClick:(UIButton*)btn{
    [kKeyWindow makeCenterToast:@"复制成功!"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.lbOrderNumber.text;
    
}
#pragma mark ---  set/Get
-(void)setOrderDetailModel:(MyOrderDetailModel *)orderDetailModel{
    _orderDetailModel = orderDetailModel;
    self.lbName.text = orderDetailModel.logisticsCompany;
    self.lbOrderNumber.text = orderDetailModel.logisticsNo;
}
-(UILabel *)lbNameTitle{
    if (!_lbNameTitle) {
        _lbNameTitle = [[UILabel alloc]init];
        [_lbNameTitle setFrame:CGRectMake(12, 0,70, 50)];
        _lbNameTitle.textAlignment = NSTextAlignmentLeft;
        _lbNameTitle.font = [UIFont systemFontOfSize:14.];
        _lbNameTitle.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _lbNameTitle.text = @"物流公司";
    }
    return _lbNameTitle;
}
-(UILabel *)lbName{
    if (!_lbName) {
        _lbName = [[UILabel alloc]init];
        _lbName.textAlignment = NSTextAlignmentLeft;
        _lbName.font = [UIFont systemFontOfSize:16.];
        _lbName.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    }
    return _lbName;
}
-(UIView *)viLine{
    if (!_viLine) {
        _viLine = [[UIView alloc]init];
        [_viLine setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    }
    return _viLine;
}
-(UILabel *)lbOrderTitle{
    if (!_lbOrderTitle) {
        _lbOrderTitle = [[UILabel alloc]init];
        _lbOrderTitle.textAlignment = NSTextAlignmentLeft;
        _lbOrderTitle.font = [UIFont systemFontOfSize:14.];
        _lbOrderTitle.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _lbOrderTitle.text = @"快递单号";
    }
    return _lbOrderTitle;
}
-(UILabel *)lbOrderNumber{
    if (!_lbOrderNumber) {
        _lbOrderNumber = [[UILabel alloc]init];
        _lbOrderNumber.textAlignment = NSTextAlignmentLeft;
        _lbOrderNumber.font = [UIFont systemFontOfSize:16.];
        _lbOrderNumber.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    }
    return _lbOrderNumber;
}
-(UIButton *)btnCopyBtn{
    if (!_btnCopyBtn) {
        _btnCopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCopyBtn.layer setCornerRadius:5];
        [_btnCopyBtn.layer setBorderWidth:1];
        [_btnCopyBtn.layer setBorderColor:[UIColor colorWithHexString:@"dedede"].CGColor];
        [_btnCopyBtn setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        _btnCopyBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        [_btnCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_btnCopyBtn addTarget:self action:@selector(btnCopyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCopyBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
