//
//  LSBorrowConfirmViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBorrowConfirmViewController.h"
#import "GoodsInfoView.h"
#import "LSBorrwingCashInfoModel.h"
#import "LSWebViewController.h"
#import "WJYAlertView.h"
#import "IQKeyboardManager.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "PayManager.h"
#import "LSLoanAreaViewController.h"
#import "LSLoanSuccessViewController.h"
#import "LSConfirmView.h"
#import "AlertSheetActionManager.h"
#import "ZTMXFConfirmLoanHeaderView.h"
#import "UILabel+Attribute.h"
#import "GetUserInfoApi.h"
#import "ZTMXFSetPasswordAlertView.h"
#import "RealNameManager.h"
@interface LSBorrowConfirmViewController () <PayManagerDelegate,GoodsInfoDelegete>

@property (nonatomic, strong) ZTMXFConfirmLoanHeaderView * confirmLoanHeaderView;

@property (nonatomic, strong) UIScrollView *scrollView;

//@property (nonatomic, strong) UIView *topView;
/**  借款金额 */
@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) LSConfirmView *centerView;

@property (nonatomic, strong) UIView *bottomView;
/**  同意协议按钮 */
@property (nonatomic, strong) UIButton *agreeButton;
/**  确认按钮 */
@property (nonatomic, strong) UIButton *btnSubmitBtn;
/**  商品简介 */
@property (nonatomic, strong) GoodsInfoView *goodsInfoView;

/**  定位*/
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapLocationReGeocode *regeocode;
@property (nonatomic, copy  ) NSString * longitude;
@property (nonatomic, copy  ) NSString * latitude;

@end

@implementation LSBorrowConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc] initWithString:@"确认借款"];
//    [self set_Title:titleStr];
    
    self.title = @"确认借款";
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self configueSubViews];
    //定位
    [self setupLocation];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
}

#pragma mark-  自定义代理
/** pay success */
- (void)payManagerDidPaySuccess:(NSDictionary *)successInfo{
    //            借钱申请提交成功
    [kKeyWindow makeCenterToast:@"借款申请成功"];
    // 1.白领贷 2.消费贷
    if (_borrowMoneyType == LSConsumptionLoanType) {
        //  消费借款
        NSString *orderId = successInfo[@"data"][@"orderId"];
        LSLoanAreaViewController *loanAreaVC = [[LSLoanAreaViewController alloc] init];
        loanAreaVC.orderId = orderId;
        [self.navigationController pushViewController:loanAreaVC animated:YES];
    } else {
        //  白领贷
        LSLoanSuccessViewController *loanSuccessVC = [[LSLoanSuccessViewController alloc] init];
        loanSuccessVC.loanType = LSWhiteCollarType;
        loanSuccessVC.borrowId = successInfo[@"data"][@"borrowId"];
        [self.navigationController pushViewController:loanSuccessVC animated:YES];
    }
}
/** pay fail */
- (void)payManagerDidPayFail:(NSDictionary *)failInfo{
    NSLog(@"借钱失败--=====");
    //  借钱失败统计
}

#pragma mark - GoodsInfoDelegete
- (void)clickGoodsDetailButton
{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = _cashInfoModel.goodDto.descUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 私有方法
#pragma mark - 查看用户协议
-(void)clickProtocolBtn{
    
    NSArray * arrActionTitle = @[@"《闪到借款协议》",@"《委托融资协议》"];
    MJWeakSelf
    [AlertSheetActionManager sheetActionTitle:@"协议" message:nil arrTitleAction:arrActionTitle superVc:self blockClick:^(NSInteger index) {
        NSString * userName = [LoginManager userPhone];
        NSString *purposeStr = [self.centerView.purposeTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * webUrl = @"";
        if (self.borrowMoneyType == LSWhiteCollarLoanType) {
            if (index==0) {
                webUrl = DefineUrlString(personalWhiteCashProtocol(userName,@"",_cashInfoModel.amount,purposeStr));
            }else{
                webUrl = DefineUrlString(entrustBorrowCashProtocol(@"",_cashInfoModel.amount,@"3"));
            }
        }else{
            if (index==0) {
                webUrl = DefineUrlString(personalCashProtocol(userName,@"",_cashInfoModel.amount,purposeStr,@"1001"));
            }else{
                webUrl = DefineUrlString(entrustBorrowCashProtocol(@"",_cashInfoModel.amount,@"2"));
            }
        }
   
        LSWebViewController *borrowNumVC = [[LSWebViewController alloc] init];
        borrowNumVC.webUrlStr = webUrl;
        [weakSelf.navigationController pushViewController:borrowNumVC animated:YES];
    }];
}

#pragma mark - 点击同意按钮
- (void)clickAgreeButton:(UIButton *)sender{
    
    self.agreeButton.selected = !self.agreeButton.selected;
}

#pragma mark - 点击立即借钱按钮
- (void)btnSubmitBtnClick:(UIButton *)sender{
    if (!_agreeButton.selected) {
        [self.view makeCenterToast:@"请同意用户协议！"];
        return;
    }
    GetUserInfoApi * userInfoApi = [[GetUserInfoApi alloc]init];
    [userInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            BOOL isSetPayPassword = [responseDict[@"data"][@"isSetPayPassword"] boolValue];
            if (isSetPayPassword) {
                [self goLoan];
            }else{
                [ZTMXFSetPasswordAlertView showMessage:@"" ButtonTitle:@"" Click:^{
                                                //   未设置支付密码
                                                [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressSetPayPaw isSaveBackVcName:YES];
                }];
            }
        }else{
            NSString * msg = [responseDict[@"msg"] description];
            [self.view makeCenterToast:msg];

        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
}

- (void)goLoan
{
    if (_agreeButton.selected) {
        // 请求借钱接口
        if (_borrowMoneyType == LSConsumptionLoanType) {
            //  消费借款
            NSString *goodsPrice = [NSDecimalNumber stringWithFloatValue:_cashInfoModel.goodPrice];
            NSMutableDictionary *payDataDict = [PayManager setLoanPayParamsWithLoanAmount:self.cashInfoModel.amount loanDays:self.cashInfoModel.borrowDays latitude:_latitude longitude:_longitude pronvince:_regeocode.province city:_regeocode.city country:_regeocode.district address:_regeocode.formattedAddress borrowType:kConsumeLoanType borrowUse:@"购物" goodsPrice:goodsPrice goodsId:_cashInfoModel.goodDto.goodsId couponID:@""];
            [PayManager payManagerWithPayType:LoanPaymentPayType payModel:PayByPasswordMode payDataDict:payDataDict delegate:self];
            
        } else {
            //  白领贷
            NSMutableDictionary *payDataDict = [PayManager setLoanPayParamsWithLoanAmount:self.cashInfoModel.amount loanDays:self.cashInfoModel.borrowDays latitude:_latitude longitude:_longitude pronvince:_regeocode.province city:_regeocode.city country:_regeocode.district address:_regeocode.formattedAddress borrowType:kWhiteLoanType borrowUse:self.centerView.purposeTitle goodsPrice:nil goodsId:nil couponID:@""];
            [PayManager payManagerWithPayType:LoanPaymentPayType payModel:PayByPasswordMode payDataDict:payDataDict delegate:self];
        }
        
    }else{
        [self.view makeCenterToast:@"请同意用户协议！"];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomView];
}

- (ZTMXFConfirmLoanHeaderView *)confirmLoanHeaderView
{
    if (!_confirmLoanHeaderView) {
        self.confirmLoanHeaderView = [[ZTMXFConfirmLoanHeaderView alloc] initWithFrame:CGRectMake(12, 16 * PY, KW - 24, 140 * PY)];
        _confirmLoanHeaderView.textLabel.text = @"借款金额";
        _confirmLoanHeaderView.amountLabel.textColor = COLOR_SRT(@"#F75023");
        NSString * amountStr = [NSString stringWithFormat:@"¥%@", _cashInfoModel.amount];
        [UILabel attributeWithLabel:_confirmLoanHeaderView.amountLabel text:amountStr maxFont:36 * PX minFont:18 * PX attributes:@[@"¥",_cashInfoModel.amount] attributeFonts:@[FONT_LIGHT(18 * PX), FONT_Medium(36 * PX)]];
        NSString * goodPriceStr = [NSString stringWithFormat:@"%.2f元", _cashInfoModel.goodPrice];

        NSString * costStr = [NSString stringWithFormat:@"借%@天，到账金额%@元，服务费%@元,商品价格%@", _cashInfoModel.borrowDays, _cashInfoModel.arrivalAmount, _cashInfoModel.serviceAmount, goodPriceStr];
        NSString * arrivalAmountStr = [NSString stringWithFormat:@"%@元", _cashInfoModel.arrivalAmount];
        NSString * serviceAmountStr = [NSString stringWithFormat:@"%@元", _cashInfoModel.serviceAmount];
                
        [UILabel attributeWithLabel:_confirmLoanHeaderView.costLabel text:costStr textColor:@"#666666" attributes:@[arrivalAmountStr,serviceAmountStr, goodPriceStr] attributeColors:@[K_GoldenColor, K_GoldenColor, K_GoldenColor]];

    }
    return _confirmLoanHeaderView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;

//        CGFloat bottom = _centerView.bottom;
//        if (self.borrowMoneyType == LSConsumptionLoanType) {
//            // 消费贷
//            [_scrollView addSubview:self.goodsInfoView];
//            _goodsInfoView.top = _centerView.bottom + 10.0;
//            bottom = _goodsInfoView.bottom;
//        }
        [_scrollView addSubview:self.confirmLoanHeaderView];
        [_scrollView addSubview:self.centerView];
        [_scrollView addSubview:self.goodsInfoView];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, _centerView.bottom, KW, 8)];
        view.backgroundColor = COLOR_SRT(@"#F2F4F5");
        [_scrollView addSubview:view];
        _scrollView.contentSize = CGSizeMake(0, _scrollView.height + _bottomView.height);
    }
    return _scrollView;
}


- (LSConfirmView *) centerView{
    if (!_centerView) {
        LoanType loanType = self.borrowMoneyType == LSWhiteCollarLoanType ? WhiteLoanType : ConsumeLoanType;
        _centerView = [[LSConfirmView alloc] initWithFrame:CGRectMake(0, _confirmLoanHeaderView.bottom + 20, SCREEN_WIDTH, AdaptedHeight(150)) confirmType:loanType];
        _centerView.cashInfoModel = self.cashInfoModel;
    }
    return _centerView;
}

- (GoodsInfoView *)goodsInfoView{
    if (!_goodsInfoView) {
        _goodsInfoView = [[GoodsInfoView alloc] initWithFrame:CGRectMake(0, _centerView.bottom + 8, SCREEN_WIDTH, 92)];
        _goodsInfoView.goodsInfoModel = _cashInfoModel.goodDto;
        _goodsInfoView.delegete = self;
    }
    return _goodsInfoView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
       
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KH - AdaptedHeight(104) - TabBar_Addition_Height, SCREEN_WIDTH, AdaptedHeight(104) + TabBar_Addition_Height)];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeButton setFrame:CGRectMake(20, 8, 13, AdaptedHeight(37))];
        [_agreeButton setImage:[UIImage imageNamed:@"protocolN"] forState:UIControlStateNormal];
        [_agreeButton setImage:[UIImage imageNamed:@"protocolSelect"] forState:UIControlStateSelected];
        _agreeButton.selected = NO;
        if (self.borrowMoneyType == LSWhiteCollarLoanType) {
            //  白领贷默认选中协议
            _agreeButton.selected = YES;
        }
        [_bottomView addSubview:_agreeButton];
        
        UIButton *agreeProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [agreeProtocolBtn setFrame:CGRectMake(0, 0, 60, 36)];
        [agreeProtocolBtn addTarget:self action:@selector(clickAgreeButton:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:agreeProtocolBtn];
        
        UILabel *protocolLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR1] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
        [protocolLabel setFrame:CGRectMake(_agreeButton.right+6.0, 8, SCREEN_WIDTH-42, AdaptedHeight(37))];
        protocolLabel.numberOfLines = 0;
        NSString *protocolText = @"我已经阅读并且同意《闪到借款协议》和《委托融资协议》";
        if (self.borrowMoneyType == LSConsumptionLoanType) {
            protocolText = @"同意《闪到借款协议》《委托融资协议》";
        }
        
//        CGSize size = [protocolText boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-AdaptedWidth(52), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_Regular(12 * PX)} context:nil].size;
//        protocolLabel.height = size.height;
        
        NSMutableAttributedString *protocolAttrStr = [[NSMutableAttributedString alloc] initWithString:protocolText];
        [protocolAttrStr addAttribute:NSForegroundColorAttributeName value:K_MainColor range:[protocolText rangeOfString:@"《闪到借款协议》"]];
        [protocolAttrStr addAttribute:NSForegroundColorAttributeName value:K_MainColor range:[protocolText rangeOfString:@"《委托融资协议》"]];

        protocolLabel.attributedText = protocolAttrStr;
        [_bottomView addSubview:protocolLabel];
        
        UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [protocolBtn setFrame:CGRectMake(agreeProtocolBtn.right, protocolLabel.top, protocolLabel.width, protocolLabel.height)];
        [protocolBtn addTarget:self action:@selector(clickProtocolBtn) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:protocolBtn];
        
        [_bottomView addSubview:self.btnSubmitBtn];
//        _btnSubmitBtn.top = protocolLabel.bottom + AdaptedHeight(25);
        
    }
    return _bottomView;
}

-(UIButton*)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setFrame:CGRectMake(20,43 * PY, KW - 40, AdaptedWidth(44))];
        _btnSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        [_btnSubmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSubmitBtn.backgroundColor = K_MainColor;
        [_btnSubmitBtn.layer setCornerRadius:3];
        _btnSubmitBtn.clipsToBounds = YES;
        _btnSubmitBtn.centerX = Main_Screen_Width/2.;
        [_btnSubmitBtn setTitle:@"确认借钱" forState:UIControlStateNormal];
        [_btnSubmitBtn addTarget:self action:@selector(btnSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmitBtn;
}

#pragma mark-  私有方法
//  设置定位
- (void)setupLocation{
    
    if (([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)))
    {
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
            
            if (error)
            {
                NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
                
                if (error.code == AMapLocationErrorLocateFailed)
                {
                    return;
                }
            }
            
            NSLog(@"location:%@", location);
            
            _longitude = [[NSNumber numberWithDouble:location.coordinate.longitude]stringValue];
            _latitude = [[NSNumber numberWithDouble:location.coordinate.latitude]stringValue];
            if (regeocode)
            {
                _regeocode = regeocode;
                NSLog(@"reGeocode:%@", regeocode);
            }
        }];
    }
}

-(AMapLocationManager*)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        //   定位超时时间，最低2s，此处设置为2s
        _locationManager.locationTimeout =2;
        //   逆地理请求超时时间，最低2s，此处设置为2s
        _locationManager.reGeocodeTimeout = 2;
    }
    return _locationManager;
}
//后台进入前台
-(void)notBgTurnTheFrontDesk{
    [self setupLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

