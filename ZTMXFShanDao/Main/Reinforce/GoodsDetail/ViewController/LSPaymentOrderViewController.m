//
//  LSPaymentOrderViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSPaymentOrderViewController.h"
#import "PaymentOrderView.h"

#import "LSOrderPaySuccessViewController.h"
#import "LSOrderPayProcessViewController.h"
#import "LSOrderPayFailureViewController.h"
#import "LSChoiseBankCardViewController.h"

#import "PaymentOrderViewModel.h"
#import "OrderPayDetailModel.h"
#import "BankCardModel.h"
#import "LSLocationManager.h"
#import "PayManager.h"

@interface LSPaymentOrderViewController ()<PaymentOrderViewDelegate, ChoiseBankCardViewDelegate, PaymentOrderViewModelDelegate, PayManagerDelegate>

@property (nonatomic, strong) UILabel *topDescribeLabel;

@property (nonatomic, strong) PaymentOrderView      *paymentOrderView;
/** viewModel */
@property (nonatomic, strong) PaymentOrderViewModel *paymentOrderViewModel;
/** 数据Model */
@property (nonatomic, strong) OrderPayDetailModel *orderPayDetailModel;
/** 银行卡Model */
@property (nonatomic, strong) BankCardModel *bankCardModel;

/** 定位数据 */
@property (nonatomic, copy) NSString *latitudeString;
@property (nonatomic, copy) NSString *longitudeString;
@property (nonatomic, strong) AMapLocationReGeocode *locationRegeocode;

@end

@implementation LSPaymentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"付款详情";
    [self configSubViews];
//    //  获取付款详情
//    [self.paymentOrderViewModel requestPaymentOrderViewInfoWithOrderId:self.orderId];
    //  设置定位
    LSPaymentOrderViewController * __weak weakSelf = self;
    if (![LoginManager appReviewState]){
        [[LSLocationManager shareLocationManager] locationSuccessWithComplish:^(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString) {
            weakSelf.latitudeString = latitudeString;
            weakSelf.longitudeString = longitudeString;
            weakSelf.locationRegeocode = locationGeocode;
        }];
    }
    
    //  注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refleshView) name:kCreditAuthStatusPushNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    //  获取付款详情
    [self.paymentOrderViewModel requestPaymentOrderViewInfoWithOrderId:self.orderId];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    
}

- (void)refleshView
{
    //  获取付款详情
    [self.paymentOrderViewModel requestPaymentOrderViewInfoWithOrderId:self.orderId];
}

#pragma mark - 代理方法
/** 点击支付 */
- (void)paymentOrderViewClickPayWithNper:(NSInteger)nper orderPayType:(MallOrderPayType)payType{
    NSString *nperString = [NSString string];
    if (nper > 0) {
        //  平台分期支付
        nperString = [NSString stringWithFormat:@"%ld", nper];
    } else {
        //  银行卡支付
        nperString = nil;
    }
    NSString *cardId = [NSString string];
    /** 银行卡id ； -3 :分期支付 */
    if (payType == MallOrderInstallmentPayType) {
        //  讯秒支付
        cardId = @"-3";
    } else {
        //  银行卡支付
        cardId = self.orderPayDetailModel.bankInfo.rid;
    }
    NSMutableDictionary *orderPayDataDict = [PayManager setMallOrderPayParamsWithOrderId:self.orderId cardId:cardId nper:nperString latitude:self.latitudeString longitude:self.longitudeString province:self.locationRegeocode.province city:self.locationRegeocode.city county:self.locationRegeocode.district];
    [PayManager payManagerWithPayType:MallGoodsOrderPayType payModel:PayByPasswordMode payDataDict:orderPayDataDict delegate:self];
}

/** 点击添加银行卡 */
- (void)paymentOrderViewClickAddBankCard{
    LSChoiseBankCardViewController *choiseBankCardVC = [[LSChoiseBankCardViewController alloc] init];
    choiseBankCardVC.delegate = self;
    choiseBankCardVC.loanType = MallPurchaseType;
    [self.navigationController pushViewController:choiseBankCardVC animated:YES];
}

/** 点击合作协议 */
- (void)clickMallCooperateProtocol{
    // 跳转到合作协议
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(entrustBorrowCashProtocol(@"",self.totalAmount,@"4"));
    [self.navigationController pushViewController:webVC animated:YES];
}

/** 点击借款协议 */
- (void)clickMallPayProtocol{
    // 跳转到借款协议
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(personalMallCashProtocol(self.orderId,self.totalAmount,self.paymentOrderView.currentNper,@""));
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 支付结果
/** pay success */
- (void)payManagerDidPaySuccess:(NSDictionary *)successInfo{
    NSDictionary *dataDict = successInfo[@"data"];
    NSString *orderAmount = [dataDict[@"amount"] description];
    NSString *statusDesc = [dataDict[@"statusDesc"] description];
    NSString *finishDesc = [dataDict[@"finishDesc"] description];
    LSOrderPaySuccessViewController *paySuccessVC = [[LSOrderPaySuccessViewController alloc] init];
    paySuccessVC.orderId = self.orderId;
    paySuccessVC.payAmount = orderAmount;
    paySuccessVC.statusDesc = statusDesc;
    paySuccessVC.finishDesc = finishDesc;
    [self.navigationController pushViewController:paySuccessVC animated:YES];
}
/** pay fail */
- (void)payManagerDidPayFail:(NSDictionary *)failInfo{
    NSDictionary *dataDict = failInfo[@"data"];
    NSString *statusDesc = [dataDict[@"statusDesc"] description];
    NSString *finishDesc = [dataDict[@"finishDesc"] description];
    LSOrderPayFailureViewController *payFailureVC = [[LSOrderPayFailureViewController alloc] init];
    payFailureVC.orderId = self.orderId;
    payFailureVC.statusDesc = statusDesc;
    payFailureVC.finishDesc = finishDesc;
    [self.navigationController pushViewController:payFailureVC animated:YES];
}
/** pay process */
- (void)payManagerDidPayProcess:(NSDictionary *)processInfo{
    NSDictionary *dataDict = processInfo[@"data"];
    NSString *statusDesc = [dataDict[@"statusDesc"] description];
    NSString *finishDesc = [dataDict[@"finishDesc"] description];

    LSOrderPayProcessViewController *payProcessVC = [[LSOrderPayProcessViewController alloc] init];
    payProcessVC.statusDesc = statusDesc;
    payProcessVC.finishDesc = finishDesc;
    [self.navigationController pushViewController:payProcessVC animated:YES];
}

#pragma mark ChoiseBankCardViewDelegate
/** 选中银行卡 */
- (void)choiseBankCardViewSelectBankCard:(BankCardModel *)bankCardModel{
    if (bankCardModel) {
        self.bankCardModel = bankCardModel;
        self.orderPayDetailModel.bankInfo = bankCardModel;
        self.paymentOrderView.bankCardModel = bankCardModel;
    }
}

#pragma mark PaymentOrderViewModelDelegate
/** 获取订单付款详情信息成功 */
- (void)requestPaymentOrderViewInfoSuccess:(OrderPayDetailModel *)orderPayDetailModel{
    if (orderPayDetailModel && ![self isSameOrderPayDetailMdel:orderPayDetailModel]) {
        self.orderPayDetailModel = orderPayDetailModel;
        self.orderPayDetailModel.totalAmount = self.totalAmount;// 订单总额
        if (self.bankCardModel) {
            self.orderPayDetailModel.bankInfo = self.bankCardModel;
        }
        self.paymentOrderView.orderPayDetailModel = self.orderPayDetailModel;
        
        if (orderPayDetailModel.mallStatus != 1 ) {
            self.topDescribeLabel.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 36.0);
            self.paymentOrderView.frame = CGRectMake(0.0, CGRectGetMaxY(self.topDescribeLabel.frame), Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height-36.0);
            if ([LoginManager appReviewState]) {
                self.paymentOrderView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
            }
        } else {
            self.topDescribeLabel.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 36.0);
            self.paymentOrderView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
        }
    }
}

#pragma mark - 私有方法
#pragma mark - 是否需要更新model
- (BOOL)isSameOrderPayDetailMdel:(OrderPayDetailModel *)orderPayModel{
    
    if (_orderPayDetailModel && (_orderPayDetailModel.faceStatus == orderPayModel.faceStatus) && (_orderPayDetailModel.bankStatus == orderPayModel.bankStatus) && (_orderPayDetailModel.zmStatus == orderPayModel.zmStatus) && (_orderPayDetailModel.weakRiskStatus == orderPayModel.weakRiskStatus) && (_orderPayDetailModel.mallStatus == orderPayModel.mallStatus)) {
        
        return YES;
    }
    return NO;
}

#pragma mark - 添加子控件
- (void)configSubViews{
    [self.view addSubview:self.topDescribeLabel];
    [self.view addSubview:self.paymentOrderView];
    self.topDescribeLabel.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, 36.0);
    self.paymentOrderView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
}

#pragma mark - getter/setter
#pragma mark -
- (UILabel *)topDescribeLabel{
    if (_topDescribeLabel == nil) {
        _topDescribeLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
        _topDescribeLabel.text = @"  认证为消费分期用户即可分期，快去认证吧！";
        _topDescribeLabel.backgroundColor = [UIColor colorWithHexString:@"FFEAAB"];
       
    }
    return _topDescribeLabel;
}

- (PaymentOrderView *)paymentOrderView{
    if (_paymentOrderView == nil) {
        _paymentOrderView = [[PaymentOrderView alloc] init];
        _paymentOrderView.delegate = self;
    }
    return _paymentOrderView;
}

- (PaymentOrderViewModel *)paymentOrderViewModel{
    if (_paymentOrderViewModel == nil) {
        _paymentOrderViewModel = [[PaymentOrderViewModel alloc] init];
        _paymentOrderViewModel.delegate = self;
    }
    return _paymentOrderViewModel;
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
