//
//  LSPeriodAuthView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPeriodAuthView.h"
#import "LSPeriodAuthCellView.h"
#import "LSBasicsBottomView.h"
#import "LSCreditAuthModel.h"

@interface LSPeriodAuthView ()

/** 消费贷认证 */
@property (nonatomic, strong) LSPeriodAuthCellView *consumeAuthView;
/** 白领贷认证 */
@property (nonatomic, strong) LSPeriodAuthCellView *whiteAuthView;
/** 消费分期认证 */
@property (nonatomic, strong) LSPeriodAuthCellView *consumePeriodAuthView;

@property (nonatomic, strong) UIView *topView;

/** 慢必赔 */
@property (nonatomic, strong) LSBasicsBottomView  *basicsBottomView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIImageView *urlImgView;

@end

@implementation LSPeriodAuthView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:COLOR_WHITE_STR];
    
        self.layer.cornerRadius = 4.0;
        
        [self configueSubViews];
    }
    return self;
}

#pragma mark - 点击认证按钮


/** 慢必赔点击 */
- (void)btnBasicsBottomBtnClick{
    if (self.delegete && [self.delegete respondsToSelector:@selector(submitConsumeLoanViewClickSlowPay)]) {
        [self.delegete submitConsumeLoanViewClickSlowPay];
    }
}

#pragma mark - setter
- (void)setCreditAuthModel:(LSCreditAuthModel *)creditAuthModel{
    _creditAuthModel = creditAuthModel;
    
    if (_creditAuthModel) {
        self.consumeAuthView.authStatus = creditAuthModel.riskStatus;
        self.whiteAuthView.authStatus = creditAuthModel.whiteRisk;
        self.consumePeriodAuthView.authStatus = creditAuthModel.mallStatus;
        [self.urlImgView sd_setImageWithURL:[NSURL URLWithString:_creditAuthModel.banner.imageUrl] placeholderImage:[UIImage imageNamed:@"crditAuth_poster"]];
    }
}
- (void)clickAuthButton:(UIButton *)sender
{
    LoanType periodType = ConsumeLoanType;
    if (sender.tag == 1) {
        // 点击消费贷认证
        periodType = ConsumeLoanType;
    } else if (sender.tag == 2) {
        // 点击白领贷认证
        periodType = WhiteLoanType;
    } else if (sender.tag == 3) {
        // 点击消费贷分期
        periodType = MallLoanType;
    }
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickPeriodAuthWithType:)]) {
        [self.delegete clickPeriodAuthWithType:periodType];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews
{
    CGFloat height = AdaptedHeight(215)/3.;
    
    // 消费贷认证
    self.consumeAuthView = [[LSPeriodAuthCellView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.width, height) title:@"消费贷认证" icon:@"consumeAuth_icon"];
//    [self addSubview:self.consumeAuthView];
    UIButton *consumeAuthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [consumeAuthButton setFrame:self.consumeAuthView.bounds];
    consumeAuthButton.tag = 1;
    [consumeAuthButton addTarget:self action:@selector(clickAuthButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.consumeAuthView addSubview:consumeAuthButton];
    
    // 白领贷贷认证
    self.whiteAuthView = [[LSPeriodAuthCellView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.consumeAuthView.frame), self.width, 0) title:@"白领贷认证" icon:@"whiteAuth_icon"];
    _whiteAuthView.clipsToBounds = YES;
//    [self addSubview:self.whiteAuthView];
    UIButton *whiteAuthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [whiteAuthButton setFrame:self.whiteAuthView.bounds];
    whiteAuthButton.tag = 2;
    [whiteAuthButton addTarget:self action:@selector(clickAuthButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteAuthView addSubview:whiteAuthButton];
    
    // 消费分期商城认证
    self.consumePeriodAuthView = [[LSPeriodAuthCellView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.whiteAuthView.frame), self.width, height) title:@"消费分期认证" icon:@"consumePeriodAuth_icon"];
    self.consumePeriodAuthView.lineLabel.hidden = YES;
//    [self addSubview:self.consumePeriodAuthView];
    UIButton *consumePeriodAuthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [consumePeriodAuthButton setFrame:self.consumePeriodAuthView.bounds];
    consumePeriodAuthButton.tag = 3;
    [consumePeriodAuthButton addTarget:self action:@selector(clickAuthButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.consumePeriodAuthView addSubview:consumePeriodAuthButton];
    
    [self.topView addSubview:self.consumeAuthView];
    [self.topView addSubview:self.whiteAuthView];
    [self.topView addSubview:self.consumePeriodAuthView];
    
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
}

/** 慢必陪 */
- (LSBasicsBottomView *)basicsBottomView{
    if (_basicsBottomView == nil) {
        _basicsBottomView = [[NSBundle mainBundle] loadNibNamed:@"LSBasicsBottomView" owner:nil options:nil].firstObject;
        [_basicsBottomView.btnSubmitBtn addTarget:self action:@selector(btnBasicsBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        _basicsBottomView.hidden = YES;
    }
    return _basicsBottomView;
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.width, AdaptedHeight(215))];
        _topView.backgroundColor = [UIColor whiteColor];
        
        _topView.layer.cornerRadius = 4.f;
//        _topView.layer.borderWidth = 1.f;
//        _topView.layer.borderColor = [UIColor whiteColor].CGColor;
        _topView.layer.shadowColor = [UIColor colorWithHexString:@"b7b7b7"].CGColor;
        _topView.layer.shadowOpacity = 0.35f;
        _topView.layer.shadowRadius = 4.f;
        _topView.layer.shadowOffset = CGSizeMake(0,4);
    }
    return _topView;
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.consumePeriodAuthView.frame) + AdaptedHeight(12.0), self.width, AdaptedHeight(100))];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        
        self.urlImgView = [[UIImageView alloc] initWithFrame:_bottomView.bounds];
        self.urlImgView.image = [UIImage imageNamed:@"crditAuth_poster"];
//        self.urlImgView.contentMode = UIViewContentModeScaleAspectFit;
        self.urlImgView.layer.cornerRadius = 4.0;
        self.urlImgView.layer.masksToBounds = YES;
        [_bottomView addSubview:self.urlImgView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:_bottomView.bounds];
        [button addTarget:self action:@selector(btnBasicsBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
    }
    return _bottomView;
}


@end
