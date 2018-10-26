//
//  LSAuthSuccessViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ZTMXFAuthSuccessViewController.h"
#import "CYLTabBarController.h"
#import "ZTMXFServerStatisticalHelper.h"

@interface ZTMXFAuthSuccessViewController ()

/** 白色背景view */
@property (nonatomic, strong) UIView *whiteView;

/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** title describe */
@property (nonatomic, strong) UILabel *titleDescibe;

/** 细线图片 */
@property (nonatomic, strong) UIImageView *lineImageView;
/** amount label */
@property (nonatomic, strong) UILabel *amountLabel;

/** 借钱按钮 */
@property (nonatomic, strong) ZTMXFButton *loanButton;
//解决埋点问题
@property (nonatomic, assign) BOOL didPageStatistical;

@end

@implementation ZTMXFAuthSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"认证结果";
    [self configueSubViews];
}

- (void)clickReturnBackEvent{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    if (!_didPageStatistical) {
        [super viewDidDisappear:animated];
    }
}

#pragma mark - configueSubViews
- (void)configueSubViews{
    
    self.titleLabel.text = self.authDescribe;
    self.amountLabel.text = self.creditAmount;
    
    self.whiteView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    CGFloat titleLabelW = Main_Screen_Width - AdaptedWidth(50.0) * 2;
    CGFloat titleLabelH = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxW:titleLabelW].height + 20.0;
    self.titleLabel.frame = CGRectMake(0.0, AdaptedHeight(40.0), Main_Screen_Width, titleLabelH);
    self.titleDescibe.frame = CGRectMake(0.0, CGRectGetMaxY(self.titleLabel.frame) + AdaptedHeight(16.0), Main_Screen_Width, AdaptedHeight(20.0));
    self.lineImageView.frame = CGRectMake(0.0, CGRectGetMaxY(self.titleDescibe.frame), Main_Screen_Width, AdaptedHeight(90.0));
    self.amountLabel.frame = CGRectMake(0.0, CGRectGetMinY(self.lineImageView.frame), CGRectGetWidth(self.lineImageView.frame), CGRectGetHeight(self.lineImageView.frame));
    self.loanButton.frame = CGRectMake(AdaptedWidth(48.0), CGRectGetMaxY(self.lineImageView.frame) + AdaptedHeight(45.0), Main_Screen_Width - AdaptedWidth(48.0) * 2, AdaptedHeight(44.0));

    
    [self.view addSubview:self.whiteView];
    [self.whiteView addSubview:self.titleLabel];
    [self.whiteView addSubview:self.titleDescibe];
    [self.whiteView addSubview:self.lineImageView];
    [self.whiteView addSubview:self.amountLabel];
    [self.whiteView addSubview:self.loanButton];
 
    
    [self.loanButton addTarget:self action:@selector(boneButtonAction) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark - setter getter
- (UIView *)whiteView{
    if (_whiteView == nil) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:18 alignment:NSTextAlignmentCenter];
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

- (UILabel *)titleDescibe{
    if (_titleDescibe == nil) {
        _titleDescibe = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR fontSize:13 alignment:NSTextAlignmentCenter];
        _titleDescibe.text = @"您可享的额度是";
    }
    return _titleDescibe;
}

- (UIImageView *)lineImageView{
    if (_lineImageView == nil) {
        _lineImageView = [UIImageView setupImageViewWithImageName:@"borrow_money_lines"];
        _lineImageView.contentMode = UIViewContentModeCenter;
    }
    return _lineImageView;
}

- (UILabel *)amountLabel{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:64 alignment:NSTextAlignmentCenter];
        _amountLabel.font = [UIFont boldSystemFontOfSize:64];
        _amountLabel.text = self.creditAmount;
    }
    return _amountLabel;
}

- (ZTMXFButton *)loanButton{
    if (_loanButton == nil) {
        _loanButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
        [_loanButton setTitle:@"去借钱" forState:UIControlStateNormal];
    }
    return _loanButton;
}
#pragma mark - 按钮点击事件
//  点击返回首页
- (void)boneButtonAction{
    [ZTMXFServerStatisticalHelper loanStatisticalApiWithIoutTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
    _didPageStatistical = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cyl_tabBarController].selectedIndex = 1;
    });
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
