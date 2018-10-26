//
//  LSSubmitConsumeLoanView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSubmitConsumeLoanView.h"
#import "LSBasicsBottomView.h"
#import "LSBaseAuthView.h"
#import "LSPromoteCreditInfoModel.h"

@interface LSSubmitConsumeLoanView ()<BaseAuthViewDelegate>
/** 基础认证 */
@property (nonatomic, strong) LSBaseAuthView      *baseAuthView;
/** 慢必赔 */
@property (nonatomic, strong) LSBasicsBottomView  *basicsBottomView;


@end

@implementation LSSubmitConsumeLoanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}



#pragma mark -
/** 点击芝麻信用 */
- (void)baseAuthViewClickZhiMaCredit{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitConsumeLoanViewClickZhiMaCredit)]) {
        [self.delegate submitConsumeLoanViewClickZhiMaCredit];
    }
}
/** 点击运营商 */
- (void)baseAuthViewClickPhoneOperation{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitConsumeLoanViewClickPhoneOperation)]) {
        [self.delegate submitConsumeLoanViewClickPhoneOperation];
    }
}

/** 慢必赔点击 */
- (void)btnBasicsBottomBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitConsumeLoanViewClickSlowPay)]) {
        [self.delegate submitConsumeLoanViewClickSlowPay];
    }
}

/** 点击提交认证 */
- (void)submitButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitConsumeLoanViewClickSubmitAuth)]) {
        [self.delegate submitConsumeLoanViewClickSubmitAuth];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.baseAuthView.frame = CGRectMake(0.0, AdaptedHeight(10.0), Main_Screen_Width, AdaptedHeight(120.0));
    self.basicsBottomView.frame = CGRectMake(0.0, CGRectGetMaxY(self.baseAuthView.frame) + AdaptedHeight(20.0), Main_Screen_Width, 100.0);
    self.submitButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.basicsBottomView.frame) + AdaptedHeight(30), Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
}


/** 慢必陪 */
- (LSBasicsBottomView *)basicsBottomView{
    if (_basicsBottomView == nil) {
        _basicsBottomView = [[NSBundle mainBundle] loadNibNamed:@"LSBasicsBottomView" owner:nil options:nil].firstObject;
        [_basicsBottomView.btnSubmitBtn addTarget:self action:@selector(btnBasicsBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _basicsBottomView.hidden = YES;
    }
    return _basicsBottomView;
}


/** 提交按钮 */
- (ZTMXFButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (void)setConsumeLoanInfoModel:(LSPromoteCreditInfoModel *)consumeLoanInfoModel{
    if (_consumeLoanInfoModel != consumeLoanInfoModel) {
        _consumeLoanInfoModel = consumeLoanInfoModel;
    }
    
    if (_consumeLoanInfoModel) {
        self.baseAuthView.consumeLoanInfoModel = _consumeLoanInfoModel;
        if (_consumeLoanInfoModel.riskStatus == 0 || _consumeLoanInfoModel.riskStatus == 2) {
            //  未审核或者审核中 显示
            self.basicsBottomView.hidden = NO;
        } else {
            self.basicsBottomView.hidden = YES;
        }
    } else {
        self.submitButton.hidden = NO;
        self.submitButton.enabled = NO;
        self.basicsBottomView.hidden = YES;
        [self.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        self.baseAuthView.consumeLoanInfoModel = nil;
    }
    
    //  重新设置按钮frame
    if (self.basicsBottomView.isHidden) {
        self.submitButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.baseAuthView.frame) + AdaptedHeight(30), Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
    } else {
        self.submitButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.basicsBottomView.frame) + AdaptedHeight(30), Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
    }
}
/** 基础认证 */
- (LSBaseAuthView *)baseAuthView{
    if (_baseAuthView == nil) {
        _baseAuthView = [[LSBaseAuthView alloc] init];
        _baseAuthView.backgroundColor = [UIColor whiteColor];
        _baseAuthView.delegate = self;
    }
    return _baseAuthView;
}

- (void)setupViews{
    [self addSubview:self.baseAuthView];
    [self addSubview:self.basicsBottomView];
    [self addSubview:self.submitButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
