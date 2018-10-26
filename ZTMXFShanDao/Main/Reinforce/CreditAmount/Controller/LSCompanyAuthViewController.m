//
//  LSCompanyAuthViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCompanyAuthViewController.h"
#import "LSCompanyAuthView.h"
#import "ZTMXFIndustryViewController.h"
#import "ZTMXFPositionViewController.h"
#import "ZTMXFSecurityAuthViewController.h"
#import "LSCreditAuthViewModel.h"
#import "RealNameManager.h"
#import "AuthenProgressView.h"
#import "LSCompanyInfoModel.h"

@interface LSCompanyAuthViewController () <LSCompanyAuthViewDelegete,LSChooseIndustryDelegete,LSChoosePositionDelegete,LSCreditAuthViewModelDelegete>

/**  1.6版本*/
@property (nonatomic, strong) AuthenProgressView *progressView;

@property (nonatomic, strong) LSCompanyAuthView *companyAuthView;

@property (nonatomic, strong) LSCreditAuthViewModel *creditAuthViewModel;

/** 选择省市区 */
@property (nonatomic, copy) NSString *provice;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *region;

@end

@implementation LSCompanyAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"公司认证"];
    [self set_Title:titleStr];
    
    [self configueSubViews];
    
    if (self.companyAuthStatus == 1 || self.companyAuthStatus == -1) {
        // 获取公司认证信息
        [self.creditAuthViewModel getCompanyAuthInfo];
    }
    
    //  设置不让侧滑
    self.fd_interactivePopDisabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.progressView.progressType = AuthenProgressCompany;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.progressView startAnimationWithProgessType:AuthenProgressCompany];
}




#pragma mark - LSCreditAuthViewModelDelegete
#pragma mark - 获取公司认证信息成功
- (void)getCompanyAuthInfoSuccess:(LSCompanyInfoModel *)companyInfoModel{
    if (companyInfoModel) {
        self.companyAuthView.companyInfoModel = companyInfoModel;
        self.provice = companyInfoModel.province;
        self.city = companyInfoModel.city;
        self.region = companyInfoModel.region;
    }
}

#pragma mark - 提交公司认证信息成功
- (void)sumitCompanyAuthSuccess{
    if (self.isBackLastVC) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        // 跳转到社保公积金认证
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSecurityAuth isSaveBackVcName:NO loanType:self.loanType];
    }
}
#pragma mark-  按钮方法
-(void)clickReturnBackEvent{
    if (self.isBackLastVC) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //        直接返回根视图
        [RealNameManager realNameBackSuperVc:self];
    }
}
#pragma mark - LSCompanyAuthViewDelegete
- (void)clickTextFieldButon:(NSInteger)tag{
//    隐藏键盘
    [self.view endEditing:YES];

    if (tag == 1) {
        // 点击行业选择
        ZTMXFIndustryViewController *industryVC = [[ZTMXFIndustryViewController alloc] init];
        industryVC.delegete = self;
        [self.navigationController pushViewController:industryVC animated:YES];
        
    }else if (tag == 2){
        // 点击岗位选择
        ZTMXFPositionViewController *positionVC = [[ZTMXFPositionViewController alloc] init];
        positionVC.industryName = self.companyAuthView.industryField.text;
        positionVC.delegete = self;
        [self.navigationController pushViewController:positionVC animated:YES];
    }
}

#pragma mark - 选择省市区
- (void)chooseAeraWithProvice:(NSString *)provice city:(NSString *)city region:(NSString *)region{
    self.provice = provice;
    self.city = city;
    self.region = region;
}

#pragma mark 点击下一步按钮
- (void)clickNextStep{
    // 1.后台提交公司信息，2.跳转到公积金、社保认证
    if (self.companyAuthView.industryField.text.length == 0) {
        [self.view makeCenterToast:@"请填写行业！"];
        return;
    }
    NSString *industryStr = self.companyAuthView.industryField.text;
    if ([self.companyAuthView.industryField.text isEqualToString:@"其他"]) {
        if (self.companyAuthView.otherIndustryField.text.length == 0) {
            [self.view makeCenterToast:@"请填写行业！"];
            return;
        }
        industryStr = self.companyAuthView.otherIndustryField.text;
    }
    if (self.companyAuthView.companyField.text.length == 0) {
        [self.view makeCenterToast:@"请填写公司名称！"];
        return;
    }
    if (self.companyAuthView.addressField.text.length == 0) {
        [self.view makeCenterToast:@"请填写公司地址！"];
        return;
    }
    if (self.companyAuthView.detailAddressField.text.length == 0) {
        [self.view makeCenterToast:@"请填写详细地址！"];
        return;
    }
    if (self.companyAuthView.phoneField.text.length == 0) {
        [self.view makeCenterToast:@"请填写公司电话！"];
        return;
    }
    if (self.companyAuthView.departmentField.text.length == 0) {
        [self.view makeCenterToast:@"请填写任职部门！"];
        return;
    }
    if (self.companyAuthView.positionField.text.length == 0) {
        [self.view makeCenterToast:@"请填写任职岗位！"];
        return;
    }
    NSString *positionStr = self.companyAuthView.positionField.text;
    if ([self.companyAuthView.positionField.text isEqualToString:@"其他"]) {
        if (self.companyAuthView.otherPositionField.text.length == 0) {
            [self.view makeCenterToast:@"请填写任职岗位！"];
            return;
        }
        positionStr = self.companyAuthView.otherPositionField.text;
    }
    NSString *authType = @"";
    if (self.companyAuthStatus == 0) {
        authType = @"add";
    }else {
        authType = @"update";
    }
    NSDictionary *params = @{@"industry":industryStr,@"name":self.companyAuthView.companyField.text,@"province":self.provice,@"city":self.city,@"region":self.region,@"detailAddress":self.companyAuthView.detailAddressField.text,@"companyPhone":self.companyAuthView.phoneField.text,@"department":self.companyAuthView.departmentField.text,@"position":positionStr,@"authType":authType};
    [self.creditAuthViewModel sumitCompanyAuthInfoWithDict:params];
}

-(void)hideKeyboard{

}
#pragma mark - LSChooseIndustryDelegete
- (void)chooseIndustry:(NSString *)industryTitle{
    
    self.companyAuthView.industryField.text = industryTitle;
    [self.companyAuthView chooseIndustry];
}

#pragma mark - LSChoosePositionDelegete
- (void)choosePosition:(NSString *)positionTitle{
    
    self.companyAuthView.positionField.text = positionTitle;
    [self.companyAuthView chooseIndustry];
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.companyAuthView];
    self.companyAuthView.top = _progressView.bottom;
}

#pragma mark - setter getter
- (AuthenProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[AuthenProgressView alloc] init];
        _progressView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 45.0);
    }
    return _progressView;
}

#pragma mark - setter
-(LSCompanyAuthView *)companyAuthView{
    if (!_companyAuthView) {
        _companyAuthView = [[LSCompanyAuthView alloc] initWithFrame:CGRectMake(0,0.0, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height-_progressView.height)];
        _companyAuthView.delegete = self;
        
    }
    return _companyAuthView;
}

- (LSCreditAuthViewModel *)creditAuthViewModel{
    if (_creditAuthViewModel == nil) {
        _creditAuthViewModel = [[LSCreditAuthViewModel alloc] init];
        _creditAuthViewModel.delegete = self;
    }
    return _creditAuthViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
