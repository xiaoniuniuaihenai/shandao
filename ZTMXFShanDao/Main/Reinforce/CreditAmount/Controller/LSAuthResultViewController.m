//
//  LSAuthResultViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSAuthResultViewController.h"
#import "CYLTabBarController.h"
#import "LSAuthInfoModel.h"
#import "RealNameManager.h"
#import "ZTMXFServerStatisticalHelper.h"

@interface LSAuthResultViewController ()

/** icon */
@property (nonatomic, strong) UIImageView *iconImgView;
/** title label */
@property (nonatomic, strong) UILabel *titleLabel;
/** title describe */
@property (nonatomic, strong) UILabel *titleDescibe;
/** sureButton */
@property (nonatomic, strong) UIButton *sureButton;
//解决埋点问题
@property (nonatomic, assign) BOOL didPageStatistical;
@end

@implementation LSAuthResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"审核结果";
    
    [self configueSubViews];
}


- (void)viewDidDisappear:(BOOL)animated{
    if (!_didPageStatistical) {
        [super viewDidDisappear:animated];
    }
}
#pragma mark - 点击返回按钮
- (void)clickReturnBackEvent{
    
    [RealNameManager realNameBackSuperVc:self];
}

#pragma mark - 点击确定按钮
- (void)clickSureButton:(UIButton *)sender
{
    if (self.authInfoModel.currentAuthStatus == -1 || self.authInfoModel.currentAuthStatus == 2) {
        // 认证失败、审核中
        [RealNameManager realNameBackSuperVc:self];
    } else if (self.authInfoModel.currentAuthStatus == 1) {
        [ZTMXFServerStatisticalHelper loanStatisticalApiWithIoutTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
        _didPageStatistical = YES;
        // 去借钱，跳转到借钱页面
        [self.navigationController popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.loanType == MallLoanType) {
                // 消费分期
                [self cyl_tabBarController].selectedIndex = 0;
            } else {
                [self cyl_tabBarController].selectedIndex = 1;
            }
        });
    }
}

#pragma mark - configueSubViews
- (void)configueSubViews{
    
    self.iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, k_Navigation_Bar_Height + AdaptedHeight(29), 80.0, 80.0)];
    self.iconImgView.centerX = Main_Screen_Width/2.;
    [self.view addSubview:self.iconImgView];
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(16.0) alignment:NSTextAlignmentCenter];
    [self.titleLabel setFrame:CGRectMake(AdaptedWidth(60.0), CGRectGetMaxY(self.iconImgView.frame)+AdaptedHeight(38.0), Main_Screen_Width-AdaptedWidth(120.0), AdaptedHeight(44.0))];
    [self.view addSubview:self.titleLabel];
//    self.titleLabel.numberOfLines = 0;
    
    self.titleDescibe = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] fontSize:AdaptedWidth(13.0) alignment:NSTextAlignmentCenter];
    [self.titleDescibe setFrame:CGRectMake(AdaptedWidth(80.0), CGRectGetMaxY(self.titleLabel.frame)+AdaptedHeight(15.0), Main_Screen_Width-AdaptedWidth(160.0), AdaptedHeight(36.0))];
    [self.view addSubview:self.titleDescibe];
//    self.titleDescibe.numberOfLines = 0;
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton setFrame:CGRectMake(0.0, CGRectGetMaxY(self.titleDescibe.frame)+AdaptedHeight(45.0), AdaptedWidth(140.0), AdaptedHeight(44.0))];
    self.sureButton.centerX = Main_Screen_Width/2.;
    [self.sureButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(14.0)]];
//    [self.sureButton setTitleColor:[UIColor colorWithHexString:COLOR_GRAY_STR] forState:UIControlStateNormal];
    self.sureButton.layer.cornerRadius = 3.;
    _sureButton.backgroundColor = K_MainColor;
//    self.sureButton.layer.borderWidth = 1.0;
//    self.sureButton.layer.borderColor = [UIColor colorWithHexString:COLOR_GRAY_STR].CGColor;
    self.sureButton.layer.masksToBounds = YES;
    [self.sureButton addTarget:self action:@selector(clickSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sureButton];
    
    if (_authInfoModel.currentAuthStatus == -1) {
        // 认证失败
        self.iconImgView.image = [UIImage imageNamed:@"JG_ShiBai"];
        [self.sureButton setTitle:@"我知道了" forState:UIControlStateNormal];
    } else if (_authInfoModel.currentAuthStatus == 1) {
        // 认证成功
        self.iconImgView.image = [UIImage imageNamed:@"JG_ChengGong"];
        [self.sureButton setTitle:@"去借钱" forState:UIControlStateNormal];
        if (self.loanType == MallLoanType) {
            [self.sureButton setTitle:@"去购物" forState:UIControlStateNormal];
        }
    } else if (_authInfoModel.currentAuthStatus == 2) {
        // 审核中
        self.iconImgView.image = [UIImage imageNamed:@"XL_mallAuth_progress"];
        [self.sureButton setTitle:@"我知道了" forState:UIControlStateNormal];
    }
    if (_authInfoModel.authRed == nil) {
        _authInfoModel.authRed = @"";
    }
    NSString *subTitleStr = [NSString stringWithFormat:@"%@%@",_authInfoModel.authRed,_authInfoModel.authTips];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:subTitleStr];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_RED_STR]} range:[subTitleStr rangeOfString:_authInfoModel.authRed]];
    
    CGSize titleSize = [_authInfoModel.authResult sizeWithFont:[UIFont systemFontOfSize:AdaptedWidth(16.0)] maxW:Main_Screen_Width-AdaptedWidth(120.0)];
    CGSize subSize = [subTitleStr sizeWithFont:[UIFont systemFontOfSize:AdaptedWidth(13.0)] maxW:Main_Screen_Width-AdaptedWidth(160.0)];
    self.titleLabel.frame = CGRectMake(AdaptedWidth(60.0), CGRectGetMaxY(self.iconImgView.frame)+AdaptedHeight(38.0), Main_Screen_Width-AdaptedWidth(120.0), titleSize.height);
    self.titleDescibe.frame = CGRectMake(AdaptedWidth(80.0), CGRectGetMaxY(self.titleLabel.frame)+AdaptedHeight(15.0), Main_Screen_Width-AdaptedWidth(160.0), subSize.height);
    
    self.titleLabel.text = _authInfoModel.authResult;
    self.titleDescibe.attributedText = attStr;
}
#pragma mark - setter
- (void)setAuthInfoModel:(LSAuthInfoModel *)authInfoModel
{
    _authInfoModel = authInfoModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
