//
//  ShanDaoVerificationCodeLoginController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanMartAdModel.h"
#import "ZTMXFLoginApi.h"
#import "GainImgCodeApi.h"
#import "GetVerifyCodeApi.h"

#import "ZTMXFVerificationCodeLoginView.h"
#import "ZTMXFAlertImgCodeView.h"
#import "LSInputTextField.h"
#import "ZTMXFCreditxTextField.h"

#import "ShanDaoLoginViewController.h"
#import "LSWebViewController.h"
#import "ShanDaoCheckLoginViewController.h"

#import "ZTMXFAdvertisingApi.h"
#import "ZTMXFGetXbehaviorSwitchApi.h"
#import "XLSubmitXbehaviorRiskApi.h"


#import "ShanDaoVerificationCodeLoginController.h"

@interface ShanDaoVerificationCodeLoginController (){
    NSDictionary                *_latitudeAndLongitude;
}
@property (nonatomic, strong) ZTMXFVerificationCodeLoginView *loginView;
@property (nonatomic, assign) XL_VERIFICATION_OR_PASSWORD type;
@end

@implementation ShanDaoVerificationCodeLoginController{
    ZTMXFLoanMartAdModel *advertisingModel;
}

- (instancetype)initWithType:(XL_VERIFICATION_OR_PASSWORD)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //氪信浏览统计
    self.type == XL_LOGINVC_PASSWORD?nil:[CreditXAgent onEnteringPage:CXPageNameLogin];
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //氪信浏览统计
    self.type == XL_LOGINVC_PASSWORD?nil:[CreditXAgent onLeavingPage:CXPageNameLogin];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //页面布局
    [self configUI];
    //埋点操作
    [self getXbehaviorSwitch];
    //获取地址?
    [XLServerBuriedPointHelper longitudeAndLatitude:^(NSDictionary *latitudeAndLongitude) {
        _latitudeAndLongitude = latitudeAndLongitude;
    }];
    //获取广告
    [self requestAdvertising];
}

- (void)configUI{
    [self.view addSubview:self.loginView];
    [self set_leftButton];
    
    //开启密码登录系统
    [self addNavigationRightButton];
}


- (void)getXbehaviorSwitch{
    ZTMXFGetXbehaviorSwitchApi *api = [[ZTMXFGetXbehaviorSwitchApi alloc]init];
    api.isHideToast = YES;
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        [self.loginView setCredixForPhoneTextField:[responseDict[@"data"][@"xbehaviorRiskSwitch"] boolValue]];
    } failure:^(__kindof YTKBaseRequest *request) {
        [self.loginView setCredixForPhoneTextField:NO];
    }];
}

- (void)requestAdvertising{
    if ([LoginManager appReviewState]) {
        return;
    }
    ZTMXFAdvertisingApi *api = [[ZTMXFAdvertisingApi alloc]initWithAdsenseType:@"REGISTER_BOTTOM_ADSENSE"];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"注册页获取广告:%@",responseDict);
        NSDictionary *data = responseDict[@"data"];
        if (data) {
            if (data[@"imageUrl"]) {
                advertisingModel = [ZTMXFLoanMartAdModel mj_objectWithKeyValues:data];
                [self.loginView.advertisingImageView sd_setImageWithURL:[NSURL URLWithString:advertisingModel.imageUrl] placeholderImage:nil];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
        NSLog(@"注册页获取广告:%@",request);
    }];
}
- (UIButton *)set_leftButton{
    UIButton *returnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBack. frame=CGRectMake(15, 5, 38, 38);
    [returnBack setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    returnBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return returnBack;
}

- (void)addNavigationRightButton{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:_type == XL_LOGINVC_VERIFICATION_CODE?@"密码登录":@"快捷注册/登录" style:UIBarButtonItemStylePlain target:self action:@selector(pushToPSWLoginVC)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: COLOR_SRT(@"4A4A4A"),NSForegroundColorAttributeName,FONT_Regular(X(14)),NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)left_button_event:(UIButton *)sender{
    _type == XL_LOGINVC_VERIFICATION_CODE?[self dismissViewControllerAnimated:YES completion:nil]:[self.navigationController popViewControllerAnimated:YES];
}

//登录按钮点击
- (void)loginClick{
    [self.view endEditing:YES];
    NSDictionary *dict = [self.loginView getData];
    NSString *userName = dict[@"phone"];
    NSString *password = dict[@"password"];
    NSString *verficationCode = dict[@"verCode"];
    
    [ZTMXFUMengHelper mqEvent:k_regist_doRegist_130 parameter:@{@"userName":userName}];
    if ([self verifyLogin:userName Pass:password VerCode:verficationCode]) {
        [LoginManager saveUserPhone:userName];
        [SVProgressHUD showLoading];
        
        ZTMXFLoginApi *loginApi = [[ZTMXFLoginApi alloc]initWithLoginType:self.type == XL_LOGINVC_PASSWORD?@"L":@"R" VerficationCode:self.type == XL_LOGINVC_PASSWORD?nil:verficationCode Password:self.type == XL_LOGINVC_PASSWORD?password:nil];
        [loginApi requestWithSuccess:^(NSDictionary *responseDict) {
            [SVProgressHUD dismiss];
//            NSLog(@"登录成功的返回值%@",responseDict);
            NSString *codeStr = [responseDict[@"code"] description];
            if ([codeStr isEqualToString:@"1000"]) {
                //氪信提交事件
                self.type == XL_LOGINVC_PASSWORD?nil:[CreditXAgent onUserLoginSuccessWithUserID:userName loginMethod:CXLoginMethodVerificationCode];
                //  登录成功
                XLSubmitXbehaviorRiskApi *riskApi = [[XLSubmitXbehaviorRiskApi alloc]initWithCreditValue:CreditXAgent.getCreditXDeviceID.value?:@"" UserName:responseDict[@"data"][@"userId"]?:@""];
                riskApi.isHideToast = YES;
                NSLog(@"上传氪信数据:%@",riskApi);
                [riskApi requestWithSuccess:^(NSDictionary *responseDict) {
                    NSLog(@"上传氪信数据成功");
                } failure:^(__kindof YTKBaseRequest *request) {
                    
                }];
                //V1.3.4新增埋点友盟已添加
                [ZTMXFUMengHelper mqEvent:k_login_result_success130 parameter:@{@"userName":userName}];
                //后台打点
                NSMutableDictionary *pointInfo = [[NSMutableDictionary alloc]init];
                [pointInfo setObject:responseDict[@"data"][@"registerOrLogin"]?:@"" forKey:@"loginOrRegister"];
                [pointInfo setObject:responseDict[@"msg"]?:@"" forKey:@"loginOrRegisterResult"];
                [_latitudeAndLongitude enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [pointInfo setObject:obj forKey:key];
                }];
                [pointInfo setObject:[XLServerBuriedPointHelper wifiMac]?:@"" forKey:@"wifiMac"];
                [pointInfo setObject:[XLServerBuriedPointHelper wifiName]?:@"" forKey:@"wifiName"];
                [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"dl" PointSubCode:@"submit.dl_yzmdl" OtherDict:pointInfo];
                NSString *needVerify = [responseDict[@"data"][@"needVerify"] description];
                if (self.type == XL_LOGINVC_VERIFICATION_CODE || [needVerify isEqualToString:@"Y"]) {
                    [kKeyWindow makeCenterToast:responseDict[@"msg"]?:@""];
                    //  登录成功
                    NSString *token = [responseDict[@"data"][@"token"] description];
                    [LoginManager saveUserPhone:userName userPasw:password userToken:token];
                    
                    //  登录成功发送通知(在设置里面接收通知)
                    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccess object:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    //  跳转到可信登录
                    ShanDaoCheckLoginViewController *checkLoginVC = [[ShanDaoCheckLoginViewController alloc] init];
                    checkLoginVC.phoneNumber = userName;
                    checkLoginVC.password = [password MD5];
                    [self.navigationController pushViewController:checkLoginVC animated:YES];
                }
            }else{
                //后台打点
                NSMutableDictionary *pointInfo = [[NSMutableDictionary alloc]init];
                [pointInfo setObject:responseDict[@"data"][@"registerOrLogin"]?:@"" forKey:@"loginOrRegister"];
                [pointInfo setObject:responseDict[@"msg"]?:@"" forKey:@"loginOrRegisterResult"];
                [_latitudeAndLongitude enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    [pointInfo setObject:obj forKey:key];
                }];
                [pointInfo setObject:[XLServerBuriedPointHelper wifiMac] forKey:@"wifiMac"];
                [pointInfo setObject:[XLServerBuriedPointHelper wifiName] forKey:@"wifiName"];
                [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"dl" PointSubCode:@"submit.dl_yzmdl" OtherDict:pointInfo];
                //氪信提交事件
                [CreditXAgent onSubmit:CXSubmitLogin result:NO withMessage:responseDict[@"msg"]?:@""];
            }

        } failure:^(__kindof YTKBaseRequest *request) {
            [SVProgressHUD dismiss];
//            NSLog(@"登录失败的返回值%@",request);
        }];
    }
    NSLog(@"%@",dict);
}

#pragma mark - 私有方法
//  验证登录
- (BOOL)verifyLogin:(NSString *)userName Pass:(NSString *)password VerCode:(NSString *)verficationCode{
    
    if (userName.length <= 0) {
        [self.view makeCenterToast:kPhoneInputReminder];
        return NO;
    }
        //验证登录参数
    if (self.type == XL_LOGINVC_PASSWORD) {
        //密码登录
        if (password.length <= 0) {
            [self.view makeCenterToast:kPasswordInputReminder];
            return NO;
        }
        BOOL passwordVerify = [NSString checkLoginPwdRule:password];
        if (password.length >= 6 && password.length <= 18 && passwordVerify) {
            return YES;
        } else {
            [self.view makeCenterToast:kPasswordInputReminder];
            return NO;
        }
    }else{
        //验证码登录
        if (verficationCode.length <= 0) {
            [self.view makeCenterToast:kVerifyCodeInputReminder];
            return NO;
        }
    }
    return YES;
}

//获取验证码
- (void)getVerification:(id)obj{
    NSString *userPhone = (NSString *)obj;
    userPhone = [userPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([userPhone length] != 11) {
        [SVProgressHUD showErrorWithStatus:kPhoneInputErrorReminder];
        return;
    }
    //后台打点-->输入验证码
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"dl" PointSubCode:@"click.dl_yzm" OtherDict:nil];
    [self.loginView endEditing:YES];
    GainImgCodeApi * imgCodeApi = [[GainImgCodeApi alloc] initWithMobile:userPhone type:@"21"];
    [imgCodeApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            
            NSDictionary * dicData = responseDict[@"data"];
            NSInteger  openStr = [[dicData[@"open"] description] integerValue];
            if (openStr == 1) {
                NSString * imgStr = [dicData[@"image"] description];
                [self showImgCodeViewImgDataStr:imgStr phone:userPhone];
            }else{
                [self gainRequestCode:nil phone:userPhone];
            }
        }else{
            self.loginView.getCodeButtonEnabled = YES;
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        self.loginView.getCodeButtonEnabled = YES;
    }];
}

//图片验证码
-(void)showImgCodeViewImgDataStr:(NSString *)imgDataStr phone:(NSString *)userPhone{
    MJWeakSelf
    ZTMXFAlertImgCodeView * codeView = [[ZTMXFAlertImgCodeView alloc] initWithMobile:userPhone type:@"21"];
    codeView.imgDataStr = imgDataStr;
    codeView.blockBtnClick = ^(NSString *codeStr) {
        
        [ZTMXFUMengHelper mqEvent:k_regist_inputYZM_130 parameter:@{@"userName":userPhone?:@""}];

        if (codeStr.length>0) {
            [weakSelf gainRequestCode:codeStr phone:userPhone];
        }else{
            [weakSelf.loginView setGetCodeButtonEnabled:YES
             ];
        }
    };
    [codeView showAlertView];
}

//获取验证码
-(void)gainRequestCode:(NSString*)imgCodeStr phone:(NSString *)phone{
    NSString *userPhone = phone;
    GetVerifyCodeApi *verifyCodeApi = [[GetVerifyCodeApi alloc] initWithUserPhone:userPhone codeType:@"SL" imgCode:imgCodeStr];
    [SVProgressHUD showLoadingWithOutMask];
    [verifyCodeApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            [kKeyWindow makeCenterToast:responseDict[@"msg"]?:@""];
            [self.loginView setGetCodeButtonEnabled:NO];
        } else {
            [self.loginView setGetCodeButtonEnabled:YES];
            [SVProgressHUD dismiss];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.loginView setGetCodeButtonEnabled:YES];
    }];
}

//跳转到密码登录
- (void)pushToPSWLoginVC{
    if (_type == XL_LOGINVC_VERIFICATION_CODE) {
        //V1.3.4新增埋点友盟已添加
        [ZTMXFUMengHelper mqEvent:k_regist_loginclick_130 parameter:@{@"userName":self.loginView.phoneInput.inputTextField.text?:@""}];
        ShanDaoLoginViewController *VC = [[ShanDaoLoginViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//跳转到广告
- (void)pushToAdvertisingVC{
    if ([advertisingModel.imageH5Url length] < 7) {
        return;
    }
    LSWebViewController * webVc = [[LSWebViewController alloc]init];
    webVc.webUrlStr = advertisingModel.imageH5Url;
    [self.navigationController pushViewController:webVc animated:YES];
    
}


//布局主页面
- (ZTMXFVerificationCodeLoginView *)loginView{
    if (!_loginView) {
        _loginView = [[ZTMXFVerificationCodeLoginView alloc]initWithFrame:self.view.bounds Type:_type];
         MJWeakSelf
        _loginView.loginBlock = ^(){
            [weakSelf loginClick];
        };
        _loginView.getVerificationCodeBlock = ^(id obj){
            [weakSelf getVerification:obj];
        };
        _loginView.advertisingClickBlock = ^(){
            [weakSelf pushToAdvertisingVC];
        };
    }
    return _loginView;
}
@end
