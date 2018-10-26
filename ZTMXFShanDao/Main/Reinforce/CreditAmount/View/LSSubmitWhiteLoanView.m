//
//  LSSubmitWhiteLoanView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/15.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSSubmitWhiteLoanView.h"
#import "LSBasicsBottomView.h"
#import "LSWhiteLoanAuthView.h"

@interface LSSubmitWhiteLoanView ()<WhiteLoanAuthViewDelegate>
/** 慢必赔 */
@property (nonatomic, strong) LSBasicsBottomView  *basicsBottomView;
/** 白领信用认证 */
@property (nonatomic, strong) LSWhiteLoanAuthView *whiteLoanAuthView;

@end

@implementation LSSubmitWhiteLoanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.whiteLoanAuthView];
//    [self addSubview:self.basicsBottomView];
    [self addSubview:self.submitButton];
}

#pragma mark -

/** 点击公积金 */
- (void)whiteLoanAuthViewClickProvidentFund{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitWhiteLoanViewClickProvidentFund)]) {
        [self.delegate submitWhiteLoanViewClickProvidentFund];
    }
}
/** 公司电话 */
- (void)whiteLoanAuthViewClickCompanyPhone{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitWhiteLoanViewClickCompanyPhone)]) {
        [self.delegate submitWhiteLoanViewClickCompanyPhone];
    }
}

/** 慢必赔点击 */
- (void)btnBasicsBottomBtnClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitWhiteLoanViewClickSlowPay)]) {
        [self.delegate submitWhiteLoanViewClickSlowPay];
    }
}

/** 点击提交认证 */
- (void)submitButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitWhiteLoanViewClickSubmitAuth)]) {
        [self.delegate submitWhiteLoanViewClickSubmitAuth];
    }
}
/** 点击社保 */
- (void)whiteLoanAuthViewClickSocialSecurity{
    if (self.delegate && [self.delegate respondsToSelector:@selector(submitWhiteLoanViewClickSocialSecurity)]) {
        [self.delegate submitWhiteLoanViewClickSocialSecurity];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.whiteLoanAuthView.frame = CGRectMake(0.0, AdaptedHeight(10.0), Main_Screen_Width, AdaptedHeight(220.0));
//    self.basicsBottomView.frame = CGRectMake(0.0, CGRectGetMaxY(self.whiteLoanAuthView.frame) + AdaptedHeight(20.0), Main_Screen_Width, 100.0);
    self.submitButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.whiteLoanAuthView.frame) + AdaptedHeight(30), Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));
}

#pragma mark - setter getter
/** 慢必陪 */
- (LSBasicsBottomView *)basicsBottomView{
    if (_basicsBottomView == nil) {
        _basicsBottomView = [[NSBundle mainBundle] loadNibNamed:@"LSBasicsBottomView" owner:nil options:nil].firstObject;
        [_basicsBottomView.btnSubmitBtn addTarget:self action:@selector(btnBasicsBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _basicsBottomView;
}

/** 白领信用认证 */
- (LSWhiteLoanAuthView *)whiteLoanAuthView{
    if (_whiteLoanAuthView == nil) {
        _whiteLoanAuthView = [[LSWhiteLoanAuthView alloc] init];
        _whiteLoanAuthView.backgroundColor = [UIColor whiteColor];
        _whiteLoanAuthView.delegate = self;
    }
    return _whiteLoanAuthView;
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

- (void)setWhiteLoanModel:(LSAuthSupplyCertifyModel *)whiteLoanModel{
    if (_whiteLoanModel != whiteLoanModel) {
        _whiteLoanModel = whiteLoanModel;
    }
    
    if (_whiteLoanModel) {
        self.whiteLoanAuthView.whiteLoanInfoModel = _whiteLoanModel;
    } else {
        self.submitButton.hidden = NO;
        self.submitButton.enabled = NO;
        [self.submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        self.whiteLoanAuthView.whiteLoanInfoModel = nil;
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
