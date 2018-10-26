//
//  LSAlertImgCodeView.m
//  YWLTMeiQiiOS
//
//  Created by 朱吉达 on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFAlertImgCodeView.h"
//#import <SDWebImage/UIButton+WebCache.h>
#import "NSString+Base64.h"
#import "GainImgCodeApi.h"
#import "WJYAlertView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
@interface ZTMXFAlertImgCodeView()
@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) __block UITextField * textField;
@property (nonatomic,strong) UIButton * btnCodeBtn;
@property (nonatomic,strong) UIView * viLineView;
@property (nonatomic,strong) UILabel * lbPromptLb;
@property (nonatomic,strong) UIButton * btnSubmitBtn;
@property (nonatomic,copy  ) NSString * mobileStr;
@property (nonatomic,strong) __block WJYAlertView * alertView;


@property (nonatomic,strong) UIButton * closeBtn;


@property (nonatomic, copy)NSString * type;

@end
@implementation ZTMXFAlertImgCodeView
-(instancetype)initWithMobile:(NSString *)mobile type:(NSString *)type
{
    if (self = [super init]) {
        _mobileStr = mobile;
        _type = type;
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setCornerRadius:8];
        self.clipsToBounds = YES;
        [self configAddSubview];
        [self configSubviewFrame];
        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 100;
    }
    return self;
}

-(void)requestImgCodeUrl
{
    _btnCodeBtn.userInteractionEnabled = NO;
    GainImgCodeApi * imgCodeApi = [[GainImgCodeApi alloc] initWithMobile:_mobileStr type:_type];
    [imgCodeApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary * dicData = responseDict[@"data"];
            
            NSData * imgData = [ [dicData[@"image"]description] base64DecodedData];
            UIImage * img = [UIImage imageWithData:imgData];
            [_btnCodeBtn setBackgroundImage:img forState:UIControlStateNormal];
        }
        _btnCodeBtn.userInteractionEnabled = YES;
    } failure:^(__kindof YTKBaseRequest *request) {
        _btnCodeBtn.userInteractionEnabled = YES;
    }];
}
-(void)setImgDataStr:(NSString *)imgDataStr{
    _imgDataStr = imgDataStr;
    NSData * imgData = [_imgDataStr base64DecodedData];
    UIImage * img = [UIImage imageWithData:imgData];
    [self.btnCodeBtn setBackgroundImage:img forState:UIControlStateNormal];
}
#pragma mark -- Action
-(void)showAlertView{
    _alertView = [[WJYAlertView alloc]initWithCustomView:self dismissWhenTouchedBackground:NO];
    [_alertView show];
    
}
-(void)btnSubmitBtnClick{
    MJWeakSelf
    if (_textField.text.length == 0) {
        [kKeyWindow makeCenterToast:@"请输入图形验证码"];
        return;
    }
    [_alertView dismissWithCompletion:^{
        weakSelf.blockBtnClick(_textField.text);
    }];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 10;
}
-(void)btnCodeBtnClick
{
    _btnCodeBtn.userInteractionEnabled = NO;
    [self requestImgCodeUrl];
}
#pragma mark UI
-(void)configAddSubview{
    [self addSubview:self.lbTitleLb];
    [self addSubview:self.textField];
    [self addSubview:self.btnCodeBtn];
    [self addSubview:self.viLineView];
    [self addSubview:self.lbPromptLb];
    [self addSubview:self.btnSubmitBtn];
    [self addSubview:self.closeBtn];
}

- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"goods_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)closeBtnAction
{
    MJWeakSelf
    [_alertView dismissWithCompletion:^{
        weakSelf.blockBtnClick(@"");
    }];
}

-(void)configSubviewFrame{
    CGFloat width = AdaptedWidth(300);
    CGFloat height = AdaptedWidth(220);
    [self setFrame:CGRectMake(0, 0,width, height)];
    [_lbTitleLb setFrame:CGRectMake(AdaptedWidth(20), AdaptedWidth(10), width-AdaptedWidth(40), AdaptedWidth(30))];
    _lbTitleLb.centerX = width/2.;
    [_btnCodeBtn setFrame:CGRectMake(0,AdaptedWidth(74), AdaptedWidth(100), AdaptedWidth(40))];
    _btnCodeBtn.right = width-AdaptedWidth(28);
    [_textField setFrame:CGRectMake(AdaptedWidth(28), _btnCodeBtn.top, _btnCodeBtn.left-AdaptedWidth(42), _btnCodeBtn.height)];
    [_viLineView setFrame:CGRectMake(_textField.left, _textField.bottom+AdaptedWidth(2), _textField.width, 1)];
    [_lbPromptLb setFrame:CGRectMake(_btnCodeBtn.left, _btnCodeBtn.bottom+AdaptedWidth(4), _btnCodeBtn.width, AdaptedWidth(16))];
    [_btnSubmitBtn setFrame:CGRectMake(0, 0, AdaptedWidth(260), AdaptedWidth(44))];
    _btnSubmitBtn.bottom = height-AdaptedWidth(20);
    _btnSubmitBtn.centerX = _lbTitleLb.centerX;
    
    _closeBtn.frame = CGRectMake(width - 50, _lbTitleLb.top, 50, _lbTitleLb.height);
    
}
#pragma mark --- get/set
-(UILabel *)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        [_lbTitleLb setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
        [_lbTitleLb setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
        _lbTitleLb.textAlignment = NSTextAlignmentCenter;
        _lbTitleLb.text = @"请输入图形验证码";
    }
    return _lbTitleLb;
}
-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _textField.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [_textField addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventValueChanged];
    }
    return _textField;
}

- (void)textFieldChange
{
    if (_textField.text.length > 6) {
        [_textField.text substringFromIndex:6];
    }
}


-(UIButton *)btnCodeBtn{
    if (!_btnCodeBtn) {
        _btnCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCodeBtn.clipsToBounds = YES;
        [_btnCodeBtn addTarget:self action:@selector(btnCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCodeBtn;
}
-(UIView *)viLineView{
    if (!_viLineView) {
        _viLineView = [[UIView alloc]init];
        [_viLineView setBackgroundColor:[UIColor colorWithHexString:@"eeeeee"]];
    }
    return _viLineView;
}
-(UILabel *)lbPromptLb{
    if (!_lbPromptLb) {
        _lbPromptLb = [[UILabel alloc]init];
        [_lbPromptLb setFont:[UIFont systemFontOfSize:AdaptedWidth(10)]];
        [_lbPromptLb setTextColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR]];
        _lbPromptLb.textAlignment = NSTextAlignmentCenter;
        _lbPromptLb.text = @"点击刷新验证码";
    }
    return _lbPromptLb;
}
-(UIButton *)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_btnSubmitBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
        [_btnSubmitBtn addTarget:self action:@selector(btnSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_btnSubmitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _btnSubmitBtn.backgroundColor = K_MainColor;
        _btnSubmitBtn.layer.cornerRadius = X(22);
    }
    return _btnSubmitBtn;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [_textField becomeFirstResponder];
}


@end
