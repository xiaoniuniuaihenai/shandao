//
//  LoginoutView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/11/30.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LoginoutView.h"
#import "LogoutApi.h"

@interface LoginoutView ()

/** app Name Label */
@property (nonatomic, strong) UILabel *appNameLabel;
/** app Company Label */
@property (nonatomic, strong) UILabel *appCompanyLabel;

@property (nonatomic, strong) UIView *footView;

@end

@implementation LoginoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.loginoutBtn];
        [self addSubview:self.footView];
        _loginoutBtn.centerX = self.centerX;
        _loginoutBtn.top = 34;
        _footView.top = _loginoutBtn.bottom + 40;
    }
    return self;
}

- (UIButton *)loginoutBtn{
    if (!_loginoutBtn) {
        _loginoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginoutBtn setFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeight(50))];
        [_loginoutBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [_loginoutBtn setTitle:@"退出登录" forState:UIControlStateSelected];
        [_loginoutBtn setBackgroundColor:[UIColor whiteColor]];
        [_loginoutBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_loginoutBtn setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateNormal];
        [_loginoutBtn addTarget:self action:@selector(clickLoginoutBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginoutBtn;
}

- (UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 70)];
        [_footView setBackgroundColor:[UIColor clearColor]];
        [_footView addSubview:self.appNameLabel];
        [_footView addSubview:self.appCompanyLabel];
    }
    return _footView;
}

- (UILabel *)appNameLabel{
    if (_appNameLabel == nil) {
        _appNameLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:12 alignment:NSTextAlignmentCenter];
        _appNameLabel.font = AdaptedFontSize(12);
        _appNameLabel.frame = CGRectMake(0.0, 0, Main_Screen_Width, 20.0);
//        _appNameLabel.text = @"讯秒";
    }
    return _appNameLabel;
}

- (UILabel *)appCompanyLabel{
    if (_appCompanyLabel == nil) {
        _appCompanyLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:12 alignment:NSTextAlignmentCenter];
        _appCompanyLabel.font = AdaptedFontSize(12);
        _appCompanyLabel.frame = CGRectMake(0.0, CGRectGetMaxY(_appNameLabel.frame), Main_Screen_Width, 20.0);
//        _appCompanyLabel.text = [NSString stringWithFormat:@"@2012 %@",kCompanyName];
    }
    return _appCompanyLabel;
}

- (void)clickLoginoutBtn:(UIButton *)sender{
    if (sender.selected) {
        // 登录状态，点击退出登录
        LogoutApi *logoutApi = [[LogoutApi alloc] init];
        [SVProgressHUD showLoading];
        [logoutApi requestWithSuccess:^(NSDictionary *responseDict) {
            [SVProgressHUD dismiss];
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                
                _loginoutBtn.selected = NO;
                [_loginoutBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [_loginoutBtn setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateNormal];
                //  清除个人账号信息
                [LoginManager clearUserInfo];
                
                // 发送退出登录通知(把我的页面信息置空)
                [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccess object:nil];
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }else{
        // 未登录，点击立即登录
        if (self.delegete && [self.delegete respondsToSelector:@selector(mineLoginOutViewClickLogin)]) {
            [self.delegete mineLoginOutViewClickLogin];
        }
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
