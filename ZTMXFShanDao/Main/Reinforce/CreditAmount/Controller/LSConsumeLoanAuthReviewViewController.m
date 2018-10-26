//
//  LSConsumeLoanAuthReviewViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSConsumeLoanAuthReviewViewController.h"
#import "CYLTabBarController.h"
#import "LSSubmitAuthViewController.h"
#import "UILabel+Attribute.h"
#import "NTalker.h"
#import "ZTMXFServerStatisticalHelper.h"
@interface LSConsumeLoanAuthReviewViewController ()

/** 白色背景view */
@property (nonatomic, strong) UIView        *whiteBgView;
@property (nonatomic, strong) UIImageView   *iconImageView;

/** successLabelOne Label */
@property (nonatomic, strong) UILabel *successLabelOne;
/** successLabelTwo Label */
@property (nonatomic, strong) UILabel *successLabelTwo;

@property (nonatomic, strong) UIImageView *dashImageView;

/** successLabelThree Label */
@property (nonatomic, strong) UILabel *successLabelThree;
/** successLabelFour Label */
@property (nonatomic, strong) UILabel *successLabelFour;

@property (nonatomic, strong) ZTMXFButton *continueAuthButton;
/** 返回首页 */
@property (nonatomic, strong) UIButton *goBackHomeButton;
//解决埋点问题
@property (nonatomic, assign) BOOL didPageStatistical;

@end

@implementation LSConsumeLoanAuthReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"认证结果";
    self.fd_interactivePopDisabled = YES;
    [self configueSubViews];
    //134新增埋点友盟已添加
    [ZTMXFUMengHelper mqEvent:k_credit_ing2_pv];
}


- (void)viewDidDisappear:(BOOL)animated{
    if (!_didPageStatistical) {
        [super viewDidDisappear:animated];
    }
}

- (void)goBack
{
    [ZTMXFServerStatisticalHelper loanStatisticalApiWithIoutTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
    _didPageStatistical = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cyl_tabBarController].selectedIndex = 1;
    });
}
- (void)clickReturnBackEvent{
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    [self goBack];
    [ZTMXFUMengHelper mqEvent:k_credit_ing2_return];
}
#pragma mark - 按钮点击事件


- (void)goBackHomeButtonAction{
    [ZTMXFUMengHelper mqEvent:k_credit_ing2_iknow_click];
    [self goBack];
}
//  跳转到在线客服
- (void)continueAuthButtonAction{
    //  客服
    NTalkerChatViewController *chat = [[NTalker standardIntegration] startChatWithSettingId:kXNSettingId];
    chat.pushOrPresent = YES;
    chat.isHaveVoice = NO;
    [self.navigationController pushViewController:chat animated:YES];
    
}
//  继续认证
//- (void)continueAuthButtonAction{
//    LSSubmitAuthViewController *submitAuthVC = [[LSSubmitAuthViewController alloc] init];
//    submitAuthVC.authType = WhiteLoanType;
//    [self.navigationController pushViewController:submitAuthVC animated:YES];
//}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    if (!kStringIsEmpty(self.authTitle)) {
        self.successLabelOne.text = self.authTitle;
    } else {
        self.successLabelOne.text = @"";
    }
    if (!kStringIsEmpty(self.authDescribe)) {
        self.successLabelTwo.text = self.authDescribe;
    } else {
        self.successLabelTwo.text = @"";
    }
    
    if (!kStringIsEmpty(self.whiteLoanTitle)) {
        self.successLabelThree.text = self.whiteLoanTitle;
    } else {
        self.successLabelThree.text = @"";
    }
    if (!kStringIsEmpty(self.whiteLoanAmount)) {
        self.successLabelFour.text = self.whiteLoanAmount;
        UIColor *orangeColor = [UIColor colorWithHexString:COLOR_ORANGE_STR];
        [UILabel attributeWithLabel:self.successLabelFour text:self.successLabelFour.text textColor:COLOR_GRAY_STR attributes:@[@"10000元"] attributeColors:@[orangeColor]];
    } else {
        self.successLabelFour.text = @"";
    }

    
    self.whiteBgView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    //CGFloat iconImageViewWidth = AdaptedHeight(80.0);
    self.iconImageView.frame = CGRectMake((Main_Screen_Width - X(145)) / 2.0, AdaptedHeight(25.0), X(145), X(171));
    CGFloat labelLeftMarign = AdaptedWidth(0.0);
    CGFloat successLabelW = Main_Screen_Width - labelLeftMarign * 2;
    CGFloat successLabelOneH = [self.successLabelOne.text sizeWithFont:self.successLabelOne.font maxW:successLabelW].height;
    self.successLabelOne.frame = CGRectMake(labelLeftMarign, CGRectGetMaxY(self.iconImageView.frame) + AdaptedHeight(36.0), successLabelW, successLabelOneH);
    CGFloat successLabelTwoH = [self.successLabelTwo.text sizeWithFont:self.successLabelTwo.font maxW:successLabelW].height;
    self.successLabelTwo.frame = CGRectMake(labelLeftMarign, CGRectGetMaxY(self.successLabelOne.frame) + AdaptedHeight(20), successLabelW, successLabelTwoH);
    self.dashImageView.frame = CGRectMake(20.0, CGRectGetMaxY(self.successLabelTwo.frame) + AdaptedHeight(30.0), Main_Screen_Width - 40.0, 0);
    
    CGFloat successLabelThreeH = [self.successLabelThree.text sizeWithFont:self.successLabelThree.font maxW:successLabelW].height;
    self.successLabelThree.frame = CGRectMake(labelLeftMarign, CGRectGetMaxY(self.dashImageView.frame) + AdaptedHeight(20.0), successLabelW, successLabelThreeH);
    CGFloat successLabelFourH = [self.successLabelThree.text sizeWithFont:self.successLabelThree.font maxW:successLabelW].height;
    self.successLabelFour.frame = CGRectMake(labelLeftMarign, CGRectGetMaxY(self.successLabelThree.frame) + AdaptedHeight(10), successLabelW, successLabelFourH);
    
    
    self.goBackHomeButton.frame = CGRectMake(X(75), _successLabelFour.bottom + 10 * PX, KW - X(150), 44 * PX);
    self.goBackHomeButton.layer.cornerRadius = self.goBackHomeButton.height/2;
    self.goBackHomeButton.layer.masksToBounds = YES;
    
    self.continueAuthButton.frame = CGRectMake(X(75), CGRectGetMaxY(self.goBackHomeButton.frame) + AdaptedHeight(10.0), KW - X(150), 44 * PX);
    self.continueAuthButton.layer.cornerRadius = self.continueAuthButton.height/2;
    self.continueAuthButton.layer.masksToBounds = YES;
    
    
    
    
    [self.view addSubview:self.whiteBgView];
    [self.whiteBgView addSubview:self.iconImageView];
    [self.whiteBgView addSubview:self.successLabelOne];
    [self.whiteBgView addSubview:self.successLabelTwo];
    
    [self.whiteBgView addSubview:self.dashImageView];
    
    [self.whiteBgView addSubview:self.successLabelThree];
    [self.whiteBgView addSubview:self.successLabelFour];
    
    [self.whiteBgView addSubview:self.continueAuthButton];
    //self.continueAuthButton.hidden = YES;
    [self.whiteBgView addSubview:self.goBackHomeButton];

}


#pragma mark - getters and setters


- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"XL_mallAuth_progress_New"];
    }
    return _iconImageView;
}

- (UIImageView *)dashImageView{
    if (_dashImageView == nil) {
        _dashImageView = [UIImageView setupImageViewWithImageName:@"XL_line_dash"];
        _dashImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _dashImageView;
}

- (UILabel *)successLabelOne{
    if (_successLabelOne == nil) {
        _successLabelOne = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:X(16) alignment:NSTextAlignmentCenter];
        _successLabelOne.font = FONT_Regular(X(16));
    }
    return _successLabelOne;
}
- (UIView *)whiteBgView{
    if (_whiteBgView == nil) {
        _whiteBgView = [[UIView alloc] init];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBgView;
}
- (UILabel *)successLabelTwo{
    if (_successLabelTwo == nil) {
        _successLabelTwo = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:X(13) alignment:NSTextAlignmentCenter];
        _successLabelTwo.font = FONT_Regular(X(13));
    }
    return _successLabelTwo;
}

- (UILabel *)successLabelThree{
    if (_successLabelThree == nil) {
        _successLabelThree = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:X(16) alignment:NSTextAlignmentCenter];
        _successLabelThree.font = [UIFont boldSystemFontOfSize:X(16)];
    }
    return _successLabelThree;
}

- (UILabel *)successLabelFour{
    if (_successLabelFour == nil) {
        _successLabelFour = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:14 alignment:NSTextAlignmentCenter];
    }
    return _successLabelFour;
}

//- (ZTMXFButton *)continueAuthButton{
//    if (_continueAuthButton == nil) {
//        _continueAuthButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
//        [_continueAuthButton setTitle:@"继续认证" forState:UIControlStateNormal];
//        _continueAuthButton.userInteractionEnabled = NO;
//        [_continueAuthButton addTarget:self action:@selector(continueAuthButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _continueAuthButton;
//}
- (ZTMXFButton *)continueAuthButton{
    if (_continueAuthButton == nil) {
        _continueAuthButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
        [_continueAuthButton setTitle:@"在线客服" forState:UIControlStateNormal];
        //        _continueAuthButton.userInteractionEnabled = NO;
        [_continueAuthButton addTarget:self action:@selector(continueAuthButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _continueAuthButton.layer.borderColor = K_MainColor.CGColor;
        _continueAuthButton.layer.borderWidth = 1;
        _continueAuthButton.backgroundColor = UIColor.whiteColor;
        [_continueAuthButton setTitleColor:K_MainColor forState:UIControlStateNormal];
        [_continueAuthButton setTitleColor:K_MainColor forState:UIControlStateHighlighted];

    }
    return _continueAuthButton;
}
- (UIButton *)goBackHomeButton{
    if (_goBackHomeButton == nil) {
        _goBackHomeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackHomeButton addTarget:self action:@selector(goBackHomeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_goBackHomeButton setTitle:@"我知道了" forState:UIControlStateNormal];
//        [_goBackHomeButton setTitleColor:K_MainColor forState:UIControlStateNormal];
//        _goBackHomeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _goBackHomeButton.layer.cornerRadius = 3.0;
        _goBackHomeButton.backgroundColor = K_MainColor;
//        _goBackHomeButton.layer.borderColor = K_MainColor.CGColor;
//        _goBackHomeButton.layer.borderWidth = 1.0;
    }
    return _goBackHomeButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
