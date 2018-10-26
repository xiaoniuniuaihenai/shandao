//
//  LSPaySuccessViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSPaySuccessViewController.h"
#import "CYLTabBarController.h"

@interface LSPaySuccessViewController ()

/** 白色背景view */
@property (nonatomic, strong) UIView *whiteBgView;
@property (nonatomic, strong) UIImageView *successIconOne;
@property (nonatomic, strong) UIImageView *successIconSecond;

@property (nonatomic, strong) UIView *lineViewOne;
@property (nonatomic, strong) UIView *lineViewTwo;

/** successLabelOne Label */
@property (nonatomic, strong) UILabel *successLabelOne;
/** successLabelTwo Label */
@property (nonatomic, strong) UILabel *successLabelTwo;
/** successLabelThree Label */
@property (nonatomic, strong) UILabel *successLabelThree;
/** successLabelFour Label */
@property (nonatomic, strong) UILabel *successLabelFour;

@property (nonatomic, strong) UIButton *finishButton;

@end

@implementation LSPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.image = [UIImage imageWithColor:[UIColor clearColor]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftImageView];
    self.navigationItem.leftBarButtonItem = item;
    [self configueSubViews];
}

#pragma mark - 按钮点击事件
- (void)finishAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self cyl_tabBarController].selectedIndex = 0;
//    });
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.whiteBgView];
    [self.whiteBgView addSubview:self.successIconOne];
    [self.whiteBgView addSubview:self.successLabelOne];
    [self.whiteBgView addSubview:self.successLabelTwo];
    
    [self.whiteBgView addSubview:self.lineViewOne];
    [self.whiteBgView addSubview:self.lineViewTwo];
    
    [self.whiteBgView addSubview:self.successIconSecond];
    [self.whiteBgView addSubview:self.successLabelThree];
    [self.whiteBgView addSubview:self.successLabelFour];
    
    [self.whiteBgView addSubview:self.finishButton];
    
    if (_successResultType == PaySuccessResultRepaymentType) {
        //  还款成功
        self.navigationItem.title = @"还款提交反馈";
    } else if (_successResultType == PaySuccessResultRenewalType) {
        //  申请延期还款
        self.navigationItem.title = @"申请延期还款反馈";
    }
    if (!kStringIsEmpty(self.submitName)) {
        self.successLabelOne.text = self.submitName;
    } else {
        self.successLabelOne.text = @"";
    }
    if (!kStringIsEmpty(self.submitDesc)) {
        self.successLabelTwo.text = self.submitDesc;
    } else {
        self.successLabelTwo.text = @"";
    }
    if (!kStringIsEmpty(self.finishName)) {
        self.successLabelThree.text = self.finishName;
    } else {
        self.successLabelThree.text = @"";
    }
    if (!kStringIsEmpty(self.finishDesc)) {
        self.successLabelFour.text = self.finishDesc;
    } else {
        self.successLabelFour.text = @"";
    }
    
    self.whiteBgView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, AdaptedHeight(300.0));
    self.successIconOne.frame = CGRectMake(AdaptedWidth(18.0), AdaptedHeight(28.0), AdaptedHeight(30.0), AdaptedHeight(30.0));
    CGFloat labelWidth = Main_Screen_Width - CGRectGetMaxX(self.successIconOne.frame) - AdaptedWidth(25.0);

    CGFloat successLabelOneHeight = [self.successLabelOne.text sizeWithFont:self.successLabelOne.font maxW:labelWidth].height;
    self.successLabelOne.frame = CGRectMake(CGRectGetMaxX(self.successIconOne.frame) + AdaptedWidth(15), CGRectGetMinY(self.successIconOne.frame) + 5.0, labelWidth, successLabelOneHeight);
    CGFloat successLabelTwoHeight = [self.successLabelTwo.text sizeWithFont:self.successLabelTwo.font maxW:labelWidth].height;
    self.successLabelTwo.frame = CGRectMake(CGRectGetMinX(self.successLabelOne.frame), CGRectGetMaxY(self.successLabelOne.frame) + 6.0, labelWidth, successLabelTwoHeight);
    
    self.successIconSecond.frame = CGRectMake(CGRectGetMinX(self.successIconOne.frame),CGRectGetMaxY(self.successIconOne.frame) +  AdaptedHeight(47.0), CGRectGetWidth(self.successIconOne.frame), CGRectGetHeight(self.successIconOne.frame));
    CGFloat successLabelThreeHeight = [self.successLabelThree.text sizeWithFont:self.successLabelThree.font maxW:labelWidth].height;
    self.successLabelThree.frame = CGRectMake(CGRectGetMinX(self.successLabelOne.frame), CGRectGetMinY(self.successIconSecond.frame) + 5.0, labelWidth, successLabelThreeHeight);
    CGFloat successLabelFourHeight = [self.successLabelFour.text sizeWithFont:self.successLabelFour.font maxW:labelWidth].height;
    self.successLabelFour.frame = CGRectMake(CGRectGetMinX(self.successLabelOne.frame), CGRectGetMaxY(self.successLabelThree.frame) + 6.0, labelWidth, successLabelFourHeight);
    
    self.lineViewOne.frame = CGRectMake(CGRectGetMinX(self.successIconOne.frame) + (CGRectGetWidth(self.successIconOne.frame) / 2.0) - 0.5, CGRectGetMaxY(self.successIconOne.frame), 1, 24.0);
    self.lineViewTwo.frame = CGRectMake(CGRectGetMinX(self.lineViewOne.frame), CGRectGetMaxY(self.lineViewOne.frame), CGRectGetWidth(self.lineViewOne.frame), CGRectGetHeight(self.lineViewOne.frame));
    
    self.finishButton.frame = CGRectMake(28.0, CGRectGetHeight(self.whiteBgView.frame) - AdaptedHeight(69.0), SCREEN_WIDTH - 56.0, AdaptedHeight(44.0));

}

#pragma mark - getters and setters
- (UIView *)whiteBgView{
    if (_whiteBgView == nil) {
        _whiteBgView = [[UIView alloc] init];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBgView;
}

- (UIImageView *)successIconOne{
    if (_successIconOne == nil) {
        _successIconOne = [[UIImageView alloc] init];
        _successIconOne.image = [UIImage imageNamed:@"XL_payResult_success"];
    }
    return _successIconOne;
}

- (UIImageView *)successIconSecond{
    if (_successIconSecond == nil) {
        _successIconSecond = [[UIImageView alloc] init];
        _successIconSecond.image = [UIImage imageNamed:@"XL_payResult_money"];
    }
    return _successIconSecond;
}

- (UIView *)lineViewOne{
    if (_lineViewOne == nil) {
        _lineViewOne = [[UIView alloc] init];
        _lineViewOne.backgroundColor = [UIColor colorWithHexString:@"7ED321"];
    }
    return _lineViewOne;
}

- (UIView *)lineViewTwo{
    if (_lineViewTwo == nil) {
        _lineViewTwo = [[UIView alloc] init];
        _lineViewTwo.backgroundColor = [UIColor colorWithHexString:@"7ED321"];
    }
    return _lineViewTwo;
}

- (UILabel *)successLabelOne{
    if (_successLabelOne == nil) {
        _successLabelOne = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
    }
    return _successLabelOne;
}

- (UILabel *)successLabelTwo{
    if (_successLabelTwo == nil) {
        _successLabelTwo = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
    }
    return _successLabelTwo;
}

- (UILabel *)successLabelThree{
    if (_successLabelThree == nil) {
        _successLabelThree = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
    }
    return _successLabelThree;
}

- (UILabel *)successLabelFour{
    if (_successLabelFour == nil) {
        _successLabelFour = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
    }
    return _successLabelFour;
}

- (UIButton *)finishButton{
    if (_finishButton == nil) {
        _finishButton = [UIButton setupButtonWithSuperView:self.view withTitle:@"我知道了" titleFont:15.0 corner:0.0 withObject:self action:@selector(finishAction:)];
        _finishButton.backgroundColor = K_MainColor;
        [_finishButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        [_finishButton.layer setCornerRadius:5];
        _finishButton.clipsToBounds = YES;
    }
    return _finishButton;
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
