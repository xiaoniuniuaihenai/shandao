//
//  LSConfirmOrderViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSConfirmOrderViewController.h"
#import "LSPaymentOrderViewController.h"
#import "ShanDaoChooseAddressViewController.h"

#import "ConfirmOrderView.h"
#import "ConfirmOrderViewModel.h"
#import "GoodsSkuPropertyModel.h"
#import "GoodsConfirmOrderInfoModel.h"
#import "LSAddressModel.h"
#import "OrderGoodsInfoModel.h"
#import "LSAddressManagerViewController.h"

@interface LSConfirmOrderViewController ()<ConfirmOrderViewDelegate, ConfirmOrderViewModelDelegate, ChooseAddressProtocol>

/** 确认订单view */
@property (nonatomic, strong) ConfirmOrderView *confirmOrderView;
/** viewModel */
@property (nonatomic, strong) ConfirmOrderViewModel *confirmOrderViewModel;
/** 确认订单页面信息 */
@property (nonatomic, strong) GoodsConfirmOrderInfoModel *confirmOrderInfoModel;

@end

@implementation LSConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认订单";
    [self configSubViews];
    
    NSString *goodsSkuId = [NSString stringWithFormat:@"%ld", self.skuId];
    [self.confirmOrderViewModel requestConfirmOrderInfoWithGoodsId:self.goodsId skuId:goodsSkuId goodsCount:self.goodsCount];
}

#pragma mark - 代理方法
/** 选择地址 */
- (void)confirmOrderViewChoiseAddress{
    LSAddressManagerViewController *choiseAddressVC = [[LSAddressManagerViewController alloc] init];
//    choiseAddressVC.delegete = self;
    @WeakObj(self);
    choiseAddressVC.clickCell = ^(LSAddressModel *addressModel) {
        [selfWeak chooseAddress:addressModel];
    };
    [self.navigationController pushViewController:choiseAddressVC animated:YES];
}
/** 添加地址 */
- (void)confirmOrderViewAddAddress{
    LSAddressManagerViewController *choiseAddressVC = [[LSAddressManagerViewController alloc] init];
    @WeakObj(self);
    choiseAddressVC.clickCell = ^(LSAddressModel *addressModel) {
        [selfWeak chooseAddress:addressModel];
    };
    [self.navigationController pushViewController:choiseAddressVC animated:YES];
//    ChooseAddressViewController *choiseAddressVC = [[ChooseAddressViewController alloc] init];
//    choiseAddressVC.delegete = self;
//    [self.navigationController pushViewController:choiseAddressVC animated:YES];
}
/** 点击提交订单 */
- (void)confirmOrderViewClickSubmitOrder{
    if (kObjectIsEmpty(self.confirmOrderInfoModel.address)) {
        [self.view makeCenterToast:@"请添加地址"];
        return;
    }
    
    NSString *goodsSkuId = [NSString stringWithFormat:@"%ld", self.skuId];
    NSString *addressId = [NSString stringWithFormat:@"%ld", self.confirmOrderInfoModel.address.addressId];
    
    [self.confirmOrderViewModel requestSubmitOrderWithGoodsId:self.goodsId skuId:goodsSkuId goodsCount:self.goodsCount addressId:addressId];
}
/** 点击优惠券 */
- (void)confirmOrderViewChoiseCoupon{
    
}
#pragma mark 选择地址
- (void)chooseAddress:(LSAddressModel *)addressModel{
    if (addressModel) {
        self.confirmOrderInfoModel.address = addressModel;
        self.confirmOrderView.confirmOrderInfoModel = self.confirmOrderInfoModel;
    }
}

#pragma mark ConfirmOrderViewModelDelegate
//  获取确认订单页面数据
- (void)requestConfirmOrderInfoSuccess:(GoodsConfirmOrderInfoModel *)confirmOrderInfoModel{
    if (confirmOrderInfoModel) {
        self.confirmOrderInfoModel = confirmOrderInfoModel;
        self.confirmOrderInfoModel.goodsInfo.count = [self.goodsCount integerValue];
        self.confirmOrderView.confirmOrderInfoModel = self.confirmOrderInfoModel;
    }
}

/** 确认订单提交成功 */
- (void)requestSubmitOrderSuccess:(NSString *)orderId{
    LSPaymentOrderViewController *paymentOrderVC = [[LSPaymentOrderViewController alloc] init];
    paymentOrderVC.orderId = orderId;
    paymentOrderVC.totalAmount = [NSDecimalNumber stringWithFloatValue:self.confirmOrderInfoModel.totalAmount];
    [self.navigationController pushViewController:paymentOrderVC animated:YES];
}

#pragma mark - 私有方法

#pragma mark - 添加子控件
- (void)configSubViews{
    [self.view addSubview:self.confirmOrderView];
    self.confirmOrderView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
}

#pragma mark - getter/setter
- (ConfirmOrderView *)confirmOrderView{
    if (_confirmOrderView == nil) {
        _confirmOrderView = [[ConfirmOrderView alloc] init];
        _confirmOrderView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _confirmOrderView.delegate = self;
    }
    return _confirmOrderView;
}

- (ConfirmOrderViewModel *)confirmOrderViewModel{
    if (_confirmOrderViewModel == nil) {
        _confirmOrderViewModel = [[ConfirmOrderViewModel alloc] init];
        _confirmOrderViewModel.delegate = self;
    }
    return _confirmOrderViewModel;
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
