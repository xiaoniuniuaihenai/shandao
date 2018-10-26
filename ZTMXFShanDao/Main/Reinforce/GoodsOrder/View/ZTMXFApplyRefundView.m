//
//  ApplyRefundView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFApplyRefundView.h"
#import "OrderGoodsInfoView.h"
#import "ALATitleValueCellView.h"
#import "UIPlaceHolderTextView.h"
#import "ZTMXFYPPickerView.h"

#import "ApplyRefundInfoModel.h"

@interface ZTMXFApplyRefundView ()<YPPickerViewDelegate, UITextViewDelegate>
/** 商品信息view */
@property (nonatomic, strong) OrderGoodsInfoView *goodsInfoView;
/** 退款原因 */
@property (nonatomic, strong) ALATitleValueCellView *refundReasonView;
/** 退款金额 */
@property (nonatomic, strong) ALATitleValueCellView *refundAmountView;

/** 退款说明背景view */
@property (nonatomic, strong) UIView *refundDescribeBgView;
/** 退款说明 */
@property (nonatomic, strong) UIPlaceHolderTextView *refundDescribeTextView;
/** 提交按钮 */
@property (nonatomic, strong) UIButton *submitButton;

/** 选择退款原因 */
@property (nonatomic, copy) NSString *refundReason;

@end

@implementation ZTMXFApplyRefundView



- (void)setupViews{
    /** 商品信息view */
    [self addSubview:self.goodsInfoView];
    /** 退款原因 */
    [self addSubview:self.refundReasonView];
    /** 退款金额 */
    [self addSubview:self.refundAmountView];
    /** 退款说明背景view */
    [self addSubview:self.refundDescribeBgView];
    /** 退款说明 */
    [self addSubview:self.refundDescribeTextView];
    /** 提交按钮 */
    [self addSubview:self.submitButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;

    /** 商品信息view */
    self.goodsInfoView.frame = CGRectMake(0.0, 0.0, viewWidth, AdaptedHeight(90.0));
    /** 退款原因 */
    self.refundReasonView.frame = CGRectMake(0.0, CGRectGetMaxY(self.goodsInfoView.frame) + AdaptedHeight(10.0), viewWidth, AdaptedHeight(49.0));
    /** 退款金额 */
    self.refundAmountView.frame = CGRectMake(0.0, CGRectGetMaxY(self.refundReasonView.frame), viewWidth, AdaptedHeight(49.0));
    /** 退款说明背景view */
    self.refundDescribeBgView.frame = CGRectMake(0.0, CGRectGetMaxY(self.refundAmountView.frame), viewWidth, AdaptedHeight(120.0));
    /** 退款说明 */
    self.refundDescribeTextView.frame = CGRectMake(AdaptedWidth(8.0), CGRectGetMaxY(self.refundAmountView.frame), viewWidth - AdaptedWidth(8.0) * 2, AdaptedHeight(120.0));
    /** 提交按钮 */
    self.submitButton.frame = CGRectMake(0.0, viewHeight - AdaptedHeight(50.0) - TabBar_Addition_Height, viewWidth, AdaptedHeight(50.0));

}

/** 商品信息view */
- (OrderGoodsInfoView *)goodsInfoView{
    if (_goodsInfoView == nil) {
        _goodsInfoView = [[OrderGoodsInfoView alloc] init];
        _goodsInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _goodsInfoView;
}
/** 退款原因 */
- (ALATitleValueCellView *)refundReasonView{
    if (_refundReasonView == nil) {
        _refundReasonView = [[ALATitleValueCellView alloc] initWithTitle:@"退款原因" value:@"请选择" target:self action:@selector(choiseRefundReason)];
        _refundReasonView.backgroundColor = [UIColor whiteColor];
        _refundReasonView.titleColorStr = COLOR_BLACK_STR;
        _refundReasonView.valueColorStr = COLOR_GRAY_STR;
        _refundReasonView.titleFont = [UIFont systemFontOfSize:14];
        _refundReasonView.valueFont = [UIFont systemFontOfSize:14];
        _refundReasonView.showRowImageView = YES;
        _refundReasonView.showBottomLineView = YES;
    }
    return _refundReasonView;
}
/** 退款金额 */
- (ALATitleValueCellView *)refundAmountView{
    if (_refundAmountView == nil) {
        _refundAmountView = [[ALATitleValueCellView alloc] initWithTitle:@"退款金额 (含运费)" value:@"" target:nil action:nil];
        _refundAmountView.backgroundColor = [UIColor whiteColor];
        _refundAmountView.titleColorStr = COLOR_BLACK_STR;
        _refundAmountView.valueColorStr = COLOR_BLACK_STR;
        _refundAmountView.titleFont = [UIFont systemFontOfSize:14];
        _refundAmountView.valueFont = [UIFont systemFontOfSize:14];
        _refundAmountView.showRowImageView = NO;
        _refundAmountView.showBottomLineView = YES;
    }
    return _refundAmountView;
}
/** 退款说明背景view */
- (UIView *)refundDescribeBgView{
    if (_refundDescribeBgView == nil) {
        _refundDescribeBgView = [[UIView alloc] init];
        _refundDescribeBgView.backgroundColor = [UIColor whiteColor];
    }
    return _refundDescribeBgView;
}
/** 退款说明 */
- (UIPlaceHolderTextView *)refundDescribeTextView{
    if (_refundDescribeTextView == nil) {
        _refundDescribeTextView = [[UIPlaceHolderTextView alloc] init];
        _refundDescribeTextView.placeholder = @"退款说明";
        _refundDescribeTextView.placeHolderLabel.font = [UIFont systemFontOfSize:14];
        _refundDescribeTextView.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _refundDescribeTextView.font = [UIFont systemFontOfSize:14];
        _refundDescribeTextView.delegate = self;
    }
    return _refundDescribeTextView;
}
/** 提交按钮 */
- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = [UIColor colorWithHexString:COLOR_RED_STR];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

//  设置页面数据
- (void)setApplyRefundInfoModel:(ApplyRefundInfoModel *)applyRefundInfoModel{
    _applyRefundInfoModel = applyRefundInfoModel;

    //  设置商品信息数据
    self.goodsInfoView.applyRefundGoodsInfoModel = _applyRefundInfoModel.goodsInfo;

    //  退款金额
    self.refundAmountView.valueStr = [NSString stringWithFormat:@"￥%.2f",_applyRefundInfoModel.amount];
    
}

#pragma mark - 按钮点击事件
- (void)submitButtonAction{
    NSLog(@"点击提交");
    
    if (kStringIsEmpty(self.refundReason)) {
        [kKeyWindow makeCenterToast:@"请选择退款原因"];
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(applyRefundViewSubmitApplyRefundWithRefundCode:refundDesc:refundAmount:)]) {
        
        NSString *refundCode = [NSString string];
        for (ApplyRefundReasonModel *refundReasonModel in self.applyRefundInfoModel.reasonList) {
            NSString *reason = refundReasonModel.label;
            if ([self.refundReason isEqualToString:reason]) {
                refundCode = refundReasonModel.code;
                break;
            }
        }

        if (kStringIsEmpty(refundCode)) {
            [kKeyWindow makeCenterToast:@"请选择退款原因"];
            return;
        }
        
        [self.delegate applyRefundViewSubmitApplyRefundWithRefundCode:refundCode refundDesc:self.refundDescribeTextView.text refundAmount:[NSString stringWithFormat:@"%.2f",self.applyRefundInfoModel.amount]];
    }
}

//  选择退款原因
- (void)choiseRefundReason{
    [self endEditing:YES];
    
    NSMutableArray *reasonArray = [NSMutableArray array];
    for (ApplyRefundReasonModel *refundReasonModel in self.applyRefundInfoModel.reasonList) {
        NSString *reason = refundReasonModel.label;
        if (!kStringIsEmpty(reason)) {
            [reasonArray addObject:reason];
        }
    }
    [ZTMXFYPPickerView showPickerViewWithData:reasonArray pickerDelegate:self];
}

#pragma mark - YPPickerViewDelegate
/** 选中当前value */
- (void)pickerViewSelectValue:(NSString *)currentValue{
    if (currentValue) {
        self.refundReasonView.valueStr = currentValue;
        self.refundReason = currentValue;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self refundDescribeContentLitmit];
}

- (void)textViewDidChange:(UITextView *)textView{
    [self refundDescribeContentLitmit];
}

- (void)refundDescribeContentLitmit{
    NSString *content = self.refundDescribeTextView.text;
    if (content.length > 200) {
        self.refundDescribeTextView.text = [content substringToIndex:200];
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
