//
//  ShanDaoConfirmLoanViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ShanDaoConfirmLoanViewController.h"
#import "ZTMXFFirstConfirmLoanView.h"
#import "LSBorrwingCashInfoModel.h"
#import "ZTMXFLoanDeatilsCell.h"
#import "ZTMXFConfirmLoanCell.h"
#import "ZTMXFLoanGoodCell.h"
#import "ZTMXFLoanFooter.h"
#import "ZTMXFChoseGoodsCell.h"
#import "PayManager.h"
#import "ShanDaoChooseGoodsViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "LSLoanAreaViewController.h"
#import "GetUserInfoApi.h"
#import "ZTMXFSetPasswordAlertView.h"
#import "RealNameManager.h"
#import "ShanDaoChooseGoodsViewController.h"
#import "UILabel+Attribute.h"
#import "ZTMXFLoanGoodsListCell.h"
#import "ZTMXFPermissionsAlertView.h"
#import "LSMyCouponListViewController.h"
#import "CounponModel.h"
#import "CYLTabBarController.h"
#import "AlertSheetActionManager.h"
@interface ShanDaoConfirmLoanViewController ()<PayManagerDelegate,CouponListViewDelegate>

@property (nonatomic, strong)ZTMXFFirstConfirmLoanView * firstConfirmLoanView;

@property (nonatomic, strong)ZTMXFLoanFooter * loanFooter;

@property (nonatomic, copy)NSArray * titleArray;

@property (nonatomic, assign) BOOL isOpened;

/**  定位*/
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapLocationReGeocode *regeocode;
@property (nonatomic, copy  ) NSString * longitude;
@property (nonatomic, copy  ) NSString * latitude;

@end

@implementation ShanDaoConfirmLoanViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //氪信浏览统计
    [CreditXAgent onEnteringPage:CXPageNameLoanSubmission];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //氪信浏览统计
    [CreditXAgent onLeavingPage:CXPageNameLoanSubmission];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    if (_cashInfoModel.goodsDtoList.count) {
        _cashInfoModel.goodDto = _cashInfoModel.goodsDtoList[0];
        _cashInfoModel.goodDto.selected = YES;
    }
    //lis @"优惠券",@"到账金额",
    _titleArray = @[@"提现详情",@"",@"还款日期",@"到账银行"];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = K_BackgroundColor;
    [self addLoanPageFooter];
    self.tableView.frame = CGRectMake(0, k_Navigation_Bar_Height, KW, KH - k_Navigation_Bar_Height - (TabBar_Addition_Height + 98 * PX));
    self.tableView.mj_header.hidden = YES;
    self.tableView.tableHeaderView = self.firstConfirmLoanView;
    MJWeakSelf
    self.firstConfirmLoanView.clickCouponBlock = ^{
        [weakSelf clickCouponBlockAciton];
    };
    
    
    [self.view addSubview:self.loanFooter];
    _firstConfirmLoanView.amountStr = _cashInfoModel.amount;
    //lis
    _firstConfirmLoanView.couponFloat = _cashInfoModel.userCoupon.amount;
    _firstConfirmLoanView.arrivalAmount = _cashInfoModel.arrivalAmount;
    _firstConfirmLoanView.arrivalAmount =  [NSString stringWithFormat:@"%.2f",[_cashInfoModel.arrivalAmount floatValue] + _cashInfoModel.userCoupon.amount];
    [self setupLocation];
    
}
- (void)clickCouponBlockAciton{
    //_firstConfirmLoanView.couponFloat = _cashInfoModel.userCoupon.amount;
    NSLog(@"用户点击了选择优惠券");
    LSMyCouponListViewController *couponListVC = [[LSMyCouponListViewController alloc]init];
    couponListVC.couponType = LoanCouponListType;
    couponListVC.amount = [self.cashInfoModel.amount floatValue];
    couponListVC.delegate = self;
    [self.navigationController pushViewController:couponListVC animated:YES];
}

- (ZTMXFFirstConfirmLoanView *)firstConfirmLoanView
{
    if (!_firstConfirmLoanView) {
        _firstConfirmLoanView = [[ZTMXFFirstConfirmLoanView alloc] init];
    }
    return _firstConfirmLoanView;
}

- (ZTMXFLoanFooter *)loanFooter
{
    if (!_loanFooter) {
        _loanFooter = [[ZTMXFLoanFooter alloc] initWithFrame:CGRectMake(0, KH -(TabBar_Addition_Height + 98 * PX) , KW, TabBar_Addition_Height + 98 * PX)];
        [_loanFooter.submitBtn addTarget:self action:@selector(btnSubmitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _loanFooter.cashInfoModel = _cashInfoModel;
        MJWeakSelf
        _loanFooter.clickProtocolButton = ^(){
            [weakSelf protocalButtonClick];
        };
        
    }
    return _loanFooter;
}
- (void)protocalButtonClick{
    NSArray * arrActionTitle = @[@"《闪到借款协议》",@"《委托融资协议》"];
    //MJWeakSelf
    [AlertSheetActionManager sheetActionTitle:@"协议" message:nil arrTitleAction:arrActionTitle superVc:self blockClick:^(NSInteger index) {
        NSString * userName = [LoginManager userPhone];
        NSString *purposeStr = @"";
        if (_cashInfoModel.borrowApplications.count >0) {
            purposeStr = _cashInfoModel.borrowApplications[0];
        }
        NSString * webUrl = @"";
        if (index==0) {
            webUrl = DefineUrlString(personalCashProtocol(userName,@"",_cashInfoModel.amount,@"",@"1001"));
        }else{
            webUrl = DefineUrlString(entrustBorrowCashProtocol(@"",_cashInfoModel.amount,@"2"));
        }
        
        LSWebViewController *borrowNumVC = [[LSWebViewController alloc] init];
        borrowNumVC.webUrlStr = webUrl;
        [self.navigationController pushViewController:borrowNumVC animated:YES];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        if (_isOpened) {
            return 100 * PX;
        }
        return 0.01;
    }else if (indexPath.row == 4) {
        return 8;
    }else if (indexPath.row == 6){
        return 75 * PX;
    }else{
        return 45 * PX;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        [self clickGoodsDetail];
    }
    if (indexPath.row == 0) {
        _isOpened = !_isOpened;
        ZTMXFConfirmLoanCell * confirmLoanCell = [tableView cellForRowAtIndexPath:indexPath];
        if (_isOpened) {
            [UIView animateWithDuration:.3f animations:^{
                confirmLoanCell.successfulImgView.transform = CGAffineTransformRotate(confirmLoanCell.successfulImgView.transform, -M_PI / 2);
            }];
        }else{
            [UIView animateWithDuration:.3f animations:^{
                confirmLoanCell.successfulImgView.transform = CGAffineTransformIdentity;
            }];
        }
        NSIndexPath * path = [NSIndexPath indexPathForRow:3 inSection:0];
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
    /*
    if (indexPath.row == 0) {
        NSLog(@"用户点击了选择优惠券");
        LSMyCouponListViewController *couponListVC = [[LSMyCouponListViewController alloc]init];
        couponListVC.couponType = LoanCouponListType;
        couponListVC.amount = [self.cashInfoModel.amount floatValue];
        couponListVC.delegate = self;
        [self.navigationController pushViewController:couponListVC animated:YES];
    }
     */
}
//用户选择了优惠券
- (void)couponListViewSelectCoupon:(CounponModel *)couponModel{
    self.cashInfoModel.userCoupon = couponModel;
    _firstConfirmLoanView.couponFloat = couponModel.amount;
    _firstConfirmLoanView.arrivalAmount =  [NSString stringWithFormat:@"%.2f",[_cashInfoModel.arrivalAmount floatValue] + _cashInfoModel.userCoupon.amount];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        ZTMXFLoanDeatilsCell * loanDeatilsCell = [ZTMXFLoanDeatilsCell cellWithTableView:tableView];
        loanDeatilsCell.cashInfoModel = _cashInfoModel;
        return loanDeatilsCell;
    }else if (indexPath.row == 6){
        //lis
        ZTMXFLoanGoodCell * loanGoodCell = [ZTMXFLoanGoodCell cellWithTableView:tableView];
        loanGoodCell.goodsInfoModel = _cashInfoModel.goodDto;
        
        return loanGoodCell;
    }else if (indexPath.row == 4){
        static NSString * cellStr = @"UITableViewCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = K_LineColor;
        }
        return cell;
    }else if (indexPath.row == 5){
        ZTMXFChoseGoodsCell * choseGoodsCell = [ZTMXFChoseGoodsCell cellWithTableView:tableView];
        [choseGoodsCell.moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
        return choseGoodsCell;
     
        /*
    }else if(indexPath.row == 0){
        static NSString * cellStr = @"UITableViewCell";
        ZTMXFConfirmLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (!cell) {
            cell = [[ZTMXFConfirmLoanCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (!self.cashInfoModel.userCoupon) {
            cell.detailTextLabel.text = @"暂无可用";
            cell.detailTextLabel.textColor = K_888888;
        }else{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥%d",(int)self.cashInfoModel.userCoupon.amount];
            cell.detailTextLabel.textColor = COLOR_SRT(@"F77321");
        }
        cell.textLabel.text = @"优惠券";
        return cell;
         */
    }else{
        //lis
        ZTMXFConfirmLoanCell * confirmLoanCell = [ZTMXFConfirmLoanCell cellWithTableView:tableView];
        confirmLoanCell.textLabel.text = _titleArray[indexPath.row];
        confirmLoanCell.successfulImgView.hidden = YES;
        confirmLoanCell.iconImgView.hidden = YES;
        
        if (indexPath.row == 0) {
            confirmLoanCell.successfulImgView.hidden = NO;
            confirmLoanCell.rigthLabel.text = @"";
        //}else if (indexPath.row == 1){
        //    confirmLoanCell.rigthLabel.text = [NSString stringWithFormat:@"%.2f元",[_cashInfoModel.arrivalAmount floatValue] + _cashInfoModel.userCoupon.amount];
        }else if (indexPath.row == 2){
            confirmLoanCell.rigthLabel.text = _cashInfoModel.planRepayDay;
        }else if (indexPath.row == 3){
            if (_cashInfoModel.bankCard.length > 4) {
                confirmLoanCell.rigthLabel.text = [NSString stringWithFormat:@"尾号%@", [_cashInfoModel.bankCard substringFromIndex:_cashInfoModel.bankCard.length - 4]];
            }
            confirmLoanCell.iconImgView.hidden = NO;
            [confirmLoanCell.iconImgView sd_setImageWithURL:[NSURL URLWithString:_cashInfoModel.bankIcon]];
        }
        return confirmLoanCell;
    }
}

- (void)moreBtnAction
{
    ShanDaoChooseGoodsViewController * chooseGoodsVC = [[ShanDaoChooseGoodsViewController alloc] init];
    @WeakObj(self);
    chooseGoodsVC.clickCell = ^(GoodsInfoModel *goodsInfoModel) {
        @StrongObj(self);
        self.cashInfoModel.goodDto = goodsInfoModel;
        [self.tableView reloadData];
    };
    chooseGoodsVC.goodsDtoList = _cashInfoModel.goodsDtoList;
    [self.navigationController pushViewController:chooseGoodsVC animated:YES];
}

- (void)clickGoodsDetail
{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = _cashInfoModel.goodDto.descUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 点击立即借钱按钮
//立即提现
- (void)btnSubmitBtnClick{
    
    
    if (!self.loanFooter.agreeBtn.selected) {
        [self.view makeCenterToast:@"请同意用户协议！"];
        return;
    }
    if (!_cashInfoModel.goodDto.selected) {
        [self.view makeCenterToast:@"请选择商品"];
        return;
    }
    //氪信点击事件
    [CreditXAgent onClick:CXClickLoanIndexLoanClicked];
    [ZTMXFUMengHelper mqEvent:k_confirm_loan_xf];
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
    if (self.loanFooter.agreeBtn.selected) {
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"click.jq_qjq_jkxq" OtherDict:nil];
        NSString *goodsPrice = [NSDecimalNumber stringWithFloatValue:_cashInfoModel.goodPrice];
        NSMutableDictionary *payDataDict = [PayManager setLoanPayParamsWithLoanAmount:self.cashInfoModel.amount loanDays:self.cashInfoModel.borrowDays latitude:_latitude longitude:_longitude pronvince:_regeocode.province city:_regeocode.city country:_regeocode.district address:_regeocode.formattedAddress borrowType:kConsumeLoanType borrowUse:@"购物" goodsPrice:goodsPrice goodsId:_cashInfoModel.goodDto.goodsId couponID:_cashInfoModel.userCoupon.rid?:@""];
        NSLog(@"提现参数: %@",payDataDict);
        [PayManager payManagerWithPayType:LoanPaymentPayType payModel:PayByPasswordMode payDataDict:payDataDict delegate:self];
    }else{
        [self.view makeCenterToast:@"请同意用户协议！"];
    }
}


#pragma mark-  私有方法
//  设置定位
- (void)setupLocation
{
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

#pragma mark-  自定义代理
/** pay success */
- (void)payManagerDidPaySuccess:(NSDictionary *)successInfo{
    //氪信提交事件
    [CreditXAgent onSubmit:CXSubmitLoanSubmission result:YES withMessage:@"成功"];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"input.jq_qjq_zfmm" OtherDict:[@{@"msg":successInfo[@"msg"],@"paymentPassword":@(1),@"weakWindControl":@(1)} mutableCopy]];
    //            借钱申请提交成功
    [kKeyWindow makeCenterToast:@"借款申请成功"];
    NSString *orderId = successInfo[@"data"][@"orderId"];
    LSLoanAreaViewController *loanAreaVC = [[LSLoanAreaViewController alloc] init];
    loanAreaVC.orderId = orderId;
    [self.navigationController pushViewController:loanAreaVC animated:YES];
    //  消费借款
    [ZTMXFUMengHelper mqEvent:k_do_loan_succ_xf parameter:@{@"amount":self.cashInfoModel.amount}];
}
/** pay fail */
- (void)payManagerDidPayFail:(NSDictionary *)failInfo{
    //氪信提交事件
    [CreditXAgent onSubmit:CXSubmitLoanSubmission result:NO withMessage:failInfo[@"msg"]?:@""];
    BOOL pswResult = [[failInfo[@"code"] description] isEqualToString:@"1120"];
    BOOL weakResult = [[failInfo[@"code"] description] isEqualToString:@"2018"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if (pswResult == NO) {
        [dict setObject:@(!pswResult) forKey:@"paymentPassword"];
        [dict setObject:@(!weakResult) forKey:@"weakWindControl"];
    }else{
        [dict setObject:@(!pswResult) forKey:@"paymentPassword"];
    }
    [dict setObject:[failInfo[@"msg"] description] forKey:@"msg"];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"jq" PointSubCode:@"input.jq_qjq_zfmm" OtherDict:dict];
    //  借钱失败统计
    [ZTMXFUMengHelper mqEvent:k_do_loan_fail_xf parameter:@{@"amount":self.cashInfoModel.amount}];
    NSLog(@"借钱失败--=====");
    NSString * codeStr = [failInfo[@"code"] description];
    if ([codeStr isEqualToString:@"2018"]) {//当code==2018时代表错误原因为弱风控失败
        [ZTMXFPermissionsAlertView showAlert:XLPermissionsLoanFailure ErrorMessage:[failInfo[@"data"][@"showMsg"] description] Click:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.navigationController.tabBarController setSelectedIndex:1];
            
        }];
    }
}


- (void)addLoanPageFooter
{
    UILabel * footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KW, 40)];
    footerLabel.text = @"  * 该商品不支持7天无理由退换，到账金额已扣除商品金额";
    footerLabel.textColor = K_B8B8B8;
    footerLabel.font = FONT_Regular(12 * PX);
    [UILabel attributeWithLabel:footerLabel text:footerLabel.text textColor:@"#B8B8B8" attributes:@[@"*"] attributeColors:@[K_MainColor]];
    self.tableView.tableFooterView = footerLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
