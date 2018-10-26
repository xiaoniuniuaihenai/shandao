//
//  LSPayFailureViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSPayFailureViewController.h"
#import "CYLTabBarController.h"
#import "ZTMXFServerStatisticalHelper.h"

@interface LSPayFailureViewController ()

/** 白色背景view */
@property (nonatomic, strong) UIView *whiteBgView;

@property (nonatomic, strong) UIImageView *failureIconOne;

/** failureLabelOne Label */
@property (nonatomic, strong) UILabel *failureLabelOne;
/** failureLabelTwo Label */
@property (nonatomic, strong) UILabel *failureLabelTwo;

/** 返回首页 */
@property (nonatomic, strong) UIButton *goBackHomeButton;
/** 尝试其他还款方式 */
@property (nonatomic, strong) UIButton *otherPayButton;
//解决埋点问题
@property (nonatomic, assign) BOOL didPageStatistical;

@end

@implementation LSPayFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    [self configueSubViews];

}

#pragma mark - 按钮点击事件
//  回到首页
- (void)goBackHomeButtonAction{
    [ZTMXFServerStatisticalHelper loanStatisticalApiWithIoutTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
    _didPageStatistical = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cyl_tabBarController].selectedIndex = 1;
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (!_didPageStatistical) {
        [super viewDidDisappear:animated];
    }
}

//  其他还款方式
- (void)otherPayButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.whiteBgView];
    [self.whiteBgView addSubview:self.failureIconOne];
    [self.whiteBgView addSubview:self.failureLabelOne];
    [self.whiteBgView addSubview:self.failureLabelTwo];
    
    [self.whiteBgView addSubview:self.goBackHomeButton];
    [self.whiteBgView addSubview:self.otherPayButton];
    
    if (!kStringIsEmpty(self.payName)) {
        self.failureLabelOne.text = self.payName;
    } else {
        self.failureLabelOne.text = @"";
    }
    if (!kStringIsEmpty(self.payDesc)) {
        self.failureLabelTwo.text = self.payDesc;
    } else {
        self.failureLabelTwo.text = @"";
    }
    
    self.whiteBgView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, AdaptedHeight(300.0));
    self.failureIconOne.frame = CGRectMake((Main_Screen_Width - AdaptedHeight(50.0)) / 2.0,AdaptedWidth(26.0), AdaptedHeight(50.0), AdaptedHeight(50.0));
    CGFloat labelWidth = Main_Screen_Width - 116.0;
    CGFloat labelX = 58.0;
    
    CGFloat failureLabelOneHeight = [self.failureLabelOne.text sizeWithFont:self.failureLabelOne.font maxW:labelWidth].height;
    self.failureLabelOne.frame = CGRectMake(labelX, CGRectGetMaxY(self.failureIconOne.frame) + AdaptedHeight(16), labelWidth, failureLabelOneHeight);
    CGFloat failureLabelTwoHeight = [self.failureLabelTwo.text sizeWithFont:self.failureLabelTwo.font maxW:labelWidth].height;
    self.failureLabelTwo.frame = CGRectMake(labelX, CGRectGetMaxY(self.failureLabelOne.frame) + AdaptedHeight(15), labelWidth, failureLabelTwoHeight);
    
    CGFloat leftMargin = 30.0;
    CGFloat buttomMargin = 35.0;
    CGFloat buttonWidth = (Main_Screen_Width - 2 * leftMargin - buttomMargin) / 2.0;
    CGFloat buttonHeight = 40.0;
    self.goBackHomeButton.frame = CGRectMake(leftMargin, CGRectGetHeight(self.whiteBgView.frame) - 86.0, buttonWidth, buttonHeight);
    self.otherPayButton.frame = CGRectMake(CGRectGetMaxX(self.goBackHomeButton.frame) + buttomMargin, CGRectGetMinY(self.goBackHomeButton.frame), buttonWidth, buttonHeight);

    if (_failureResultType != PayFailureResultRenewalPayType) {
        //  还款失败
        self.navigationItem.title = @"还款提交反馈";
    } else {
        //  延期还款失败
        self.navigationItem.title = @"申请延期还款反馈";
        self.otherPayButton.hidden = YES;
        CGRect goBackHomeButtonRect = self.goBackHomeButton.frame;
        goBackHomeButtonRect.size.width = 200.0;
        goBackHomeButtonRect.origin.x = (Main_Screen_Width - 200.0) / 2.0;
        self.goBackHomeButton.frame = goBackHomeButtonRect;
    }

}

#pragma mark - getters and setters
- (UIView *)whiteBgView{
    if (_whiteBgView == nil) {
        _whiteBgView = [[UIView alloc] init];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBgView;
}

- (UIImageView *)failureIconOne{
    if (_failureIconOne == nil) {
        _failureIconOne = [[UIImageView alloc] init];
        _failureIconOne.image = [UIImage imageNamed:@"XL_payResult_failure"];
    }
    return _failureIconOne;
}

- (UILabel *)failureLabelOne{
    if (_failureLabelOne == nil) {
        _failureLabelOne = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentCenter];
    }
    return _failureLabelOne;
}

- (UILabel *)failureLabelTwo{
    if (_failureLabelTwo == nil) {
        _failureLabelTwo = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:14 alignment:NSTextAlignmentCenter];
    }
    return _failureLabelTwo;
}


- (UIButton *)goBackHomeButton{
    if (_goBackHomeButton == nil) {
        _goBackHomeButton = [UIButton setupButtonWithSuperView:self.view withTitle:@"返回首页" titleFont:14.0 corner:0.0 withObject:self action:@selector(goBackHomeButtonAction)];
//        [_goBackHomeButton setTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] forState:UIControlStateNormal];
        [_goBackHomeButton.layer setCornerRadius:3.0];
        _goBackHomeButton.backgroundColor = K_MainColor;
//        _goBackHomeButton.layer.borderColor = [UIColor colorWithHexString:COLOR_LIGHT_STR].CGColor;
//        _goBackHomeButton.layer.borderWidth = 1;
        _goBackHomeButton.clipsToBounds = YES;
    }
    return _goBackHomeButton;
}

- (UIButton *)otherPayButton{
    if (_otherPayButton == nil) {
        _otherPayButton = [UIButton setupButtonWithSuperView:self.view withTitle:@"尝试其他还款方式" titleFont:14.0 corner:0.0 withObject:self action:@selector(otherPayButtonAction)];
        [_otherPayButton setTitleColor:[UIColor colorWithHexString:@"e35b42"] forState:UIControlStateNormal];
        [_otherPayButton.layer setCornerRadius:20.0];
        _otherPayButton.layer.borderColor = [UIColor colorWithHexString:@"e35b42"].CGColor;
        _otherPayButton.layer.borderWidth = 1;
        _otherPayButton.clipsToBounds = YES;
    }
    return _otherPayButton;
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
