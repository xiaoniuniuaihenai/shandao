//
//  LSSettingViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  设置页面

#import "LSSettingViewController.h"
#import "LSTitleValueTableViewCell.h"
#import "LSVersionViewController.h"
#import "LogoutApi.h"
#import "ShanDaoLoginViewController.h"
#import "ShanDaoVerificationCodeLoginController.h"
#import "LSWebViewController.h"
#import "NTalker.h"
#import "LSModifyPasswordViewController.h"
#import "ShanDaoForgetPasswordViewController.h"
#import "LSSetupPayPasswordViewController.h"
#import "GetUserInfoApi.h"
#import "ZTMXFUserInfoModel.h"
#import "RealNameManager.h"
#import "NSString+Base64.h"
#import "LSFeedbackViewController.h"
#import "AppDelegate.h"
@interface LSSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** titleArray */
@property (nonatomic, strong) NSArray           *titleArray;
/** 登录 */
@property (nonatomic, strong) UIButton          *loginButton;

/** app Name Label */
@property (nonatomic, strong) UILabel           *appNameLabel;
/** app Company Label */
@property (nonatomic, strong) UILabel           *appCompanyLabel;

/** user info Data */
@property (nonatomic, strong) ZTMXFUserInfoModel   *userInfoModel;

@end

@implementation LSSettingViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccess object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:kLoginSuccess object:nil];
    [self configueSubViews];
}

- (BOOL)hideNavigationBottomLine{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([LoginManager loginState]) {
        [self userInfoData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataArray = self.titleArray[section];
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSTitleValueTableViewCell *cell = [LSTitleValueTableViewCell cellWithTableView:tableView];
    NSArray *dataArray = self.titleArray[indexPath.section];
    NSString *title = dataArray[indexPath.row];
    cell.titleLabel.text = title;
    cell.voiceSwitch.hidden = YES;
    if ([title isEqualToString:@"消息声音"]) {
        [cell setShowRowImageView:NO];
        cell.voiceSwitch.hidden = NO;

    }else {
        [cell setShowRowImageView:YES];
        cell.valueLabel.text = @"";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *dataArray = self.titleArray[indexPath.section];
    NSString *title = dataArray[indexPath.row];
    if ([title isEqualToString:@"关于我们"]) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        webVC.webUrlStr = DefineUrlString(abountUs);
        [self.navigationController pushViewController:webVC animated:YES];
    } else if ([title isEqualToString:@"版本管理"]) {
        LSVersionViewController *versionVC = [[LSVersionViewController alloc] init];
        [self.navigationController pushViewController:versionVC animated:YES];
    } else if ([title isEqualToString:@"支付密码"]) {
        if ([self loginState]) {
            if (![self jumpToSkinIdOrBindCard]) {
                LSSetupPayPasswordViewController *payVC = [[LSSetupPayPasswordViewController alloc] init];
                payVC.passwordType = InputOriginalPassword;
                [self.navigationController pushViewController:payVC animated:YES];
            }
        }
    } else if ([title isEqualToString:@"登录密码"]) {
        if ([self loginState]) {
            ShanDaoForgetPasswordViewController *modifyVC = [[ShanDaoForgetPasswordViewController alloc] init];
            modifyVC.title = @"登录密码";
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
    } else if ([title isEqualToString:@"意见反馈"]) {
        if ([self loginState]) {
            LSFeedbackViewController * feedBackVc = [[LSFeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedBackVc animated:YES];
        }
    } else if ([title isEqualToString:@"消息中心"]) {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}

#pragma mark - 私有方法
//  判断有没有登录
- (BOOL)loginState{
    if (![LoginManager loginState]) {
        [LoginManager presentLoginVCWithController:self];
        return NO;
    } else {
        return YES;
    }
}

/** 跳转到扫身份证和绑定银行卡 */
- (BOOL)jumpToSkinIdOrBindCard{
    /** 人脸识别状态【0:未认证,-1:认证失败，1:已认证】 */
    NSInteger faceStatus = self.userInfoModel.faceStatus;
    /** 是否绑卡状态【0:未绑卡  1：绑卡：-1：绑卡失败】(登陆后才有) */
    NSInteger bindCardStatus = self.userInfoModel.bankStatus;
    if (faceStatus != 1) {
        //  跳转到实名认证
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES];
        return YES;
    } else if (bindCardStatus != 1) {
        //  跳转到绑卡
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES];
        return YES;
    }
    return NO;
}

#pragma mark - 接口
//  获取我的信息
- (void)userInfoData{
    GetUserInfoApi *api = [[GetUserInfoApi alloc] init];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.userInfoModel = [ZTMXFUserInfoModel mj_objectWithKeyValues:dataDict];
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
    }];
}

#pragma mark - 按钮点击事件
- (void)loginButtonAction{
    
    if ([LoginManager loginState]) {
        //  退出登录
        @WeakObj(self);
        LogoutApi *logoutApi = [[LogoutApi alloc] init];
        [SVProgressHUD showLoading];
        [logoutApi requestWithSuccess:^(NSDictionary *responseDict) {
            [SVProgressHUD dismiss];
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                [self.view makeCenterToast:@"退出登录成功"];
                //  清除个人账号信息
                [LoginManager clearUserInfo];
                [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
                [self.loginButton setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateNormal];
                self.userInfoModel = nil;
                [self.tableView reloadData];
                // 发送退出登录通知(把我的页面信息置空)
                [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccess object:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    selfWeak.navigationController.tabBarController.hidesBottomBarWhenPushed = NO;
                        selfWeak.navigationController.tabBarController.selectedIndex = 0;
                        [selfWeak.navigationController popViewControllerAnimated:YES];
                });
            }
        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    } else {
        //  重新登录
        ShanDaoVerificationCodeLoginController *loginVC = [[ShanDaoVerificationCodeLoginController alloc] initWithType:XL_LOGINVC_VERIFICATION_CODE];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:loginNav animated:YES completion:nil];
    }
}

//  登录成功监听
- (void)loginSuccess{
    [self.loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:K_EC5346Color forState:UIControlStateNormal];
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, 141 * PX);
    [footerView addSubview:self.loginButton];
    self.tableView.tableFooterView = footerView;
    
    [self.view addSubview:self.appNameLabel];
    [self.view addSubview:self.appCompanyLabel];
    [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - getters and setters

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor whiteColor];
        if ([LoginManager loginState]) {
            [_loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
            [_loginButton setTitleColor:K_MainColor forState:UIControlStateNormal];
        } else {
            [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
            [_loginButton setTitleColor:K_MainColor forState:UIControlStateNormal];
        }
        _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _loginButton.frame = CGRectMake(0.0, 97 * PX, Main_Screen_Width, 44.0 * PX);
    }
    return _loginButton;
}

- (UILabel *)appNameLabel{
    if (_appNameLabel == nil) {
        _appNameLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR1 fontSize:12 alignment:NSTextAlignmentCenter];
        _appNameLabel.frame = CGRectMake(0.0, Main_Screen_Height - 63 - TabBar_Addition_Height, Main_Screen_Width, 20.0);
//        _appNameLabel.text = @"讯秒";
    }
    return _appNameLabel;
}

- (UILabel *)appCompanyLabel{
    if (_appCompanyLabel == nil) {
        _appCompanyLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_STR1 fontSize:12 alignment:NSTextAlignmentCenter];
        _appCompanyLabel.frame = CGRectMake(0.0, CGRectGetMaxY(_appNameLabel.frame), Main_Screen_Width, 20.0);
    }
    return _appCompanyLabel;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        NSArray *firstArray = @[ @"支付密码"];
        NSArray *secondArray = @[@"意见反馈", @"版本管理"];
        _titleArray = @[firstArray, secondArray];
    }
    return _titleArray;
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
