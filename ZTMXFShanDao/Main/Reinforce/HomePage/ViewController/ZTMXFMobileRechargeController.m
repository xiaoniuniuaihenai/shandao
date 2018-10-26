//
//  LSMobileRechargeController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMobileRechargeController.h"
#import "MobileRechargeInfoView.h"
#import "ZTMXFMobileRechargeInfoViewModel.h"
#import "CreateRechargeOrderInfoModel.h"
@interface ZTMXFMobileRechargeController ()<MobileRechargeInfoViewDelegate,MobileRechargeInfoViewModelDelegate>

@property (nonatomic,strong) MobileRechargeInfoView * rechargeView;
@property (nonatomic,strong) ZTMXFMobileRechargeInfoViewModel * infoViewModel;
@end

@implementation ZTMXFMobileRechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"话费充值";
    [self.view addSubview:self.rechargeView];
    self.automaticallyAdjustsScrollViewInsets = NO;

}
#pragma mark --- MobileRechargeInfoViewDelegate


// 生成订单成功
-(void)requestCreateRechargeOrderSuccess:(CreateRechargeOrderInfoModel *)orederInfoModel{
//    跳转支付页面
//    ZTMXFMobileRechargePayController * payVc = [[ZTMXFMobileRechargePayController alloc]init];
//    payVc.orderId = orederInfoModel.rid;
//    [self.navigationController pushViewController:payVc animated:YES];
}

/** 属性
 @param rechargeInfoModel 充值信息
 */
-(void)requestRechargeInfoSuccess:(MobileRechargeInfoModel *)rechargeInfoModel{
    _rechargeView.rechargeInfoModel = rechargeInfoModel;
}

#pragma mark-- MobileRechargeInfoViewDelegate
// 手机运营商变更
-(void)changeMobileInfoWithProvince:(NSString *)province company:(NSString *)company{
    [self.infoViewModel requestRechargeInfoWithProvince:province company:company];
}
//创建订单
-(void)createMobileRechargeOrder:(CreateRechargeOrderInfoModel *)orderInfoModel{
    [self.infoViewModel requestCreateRechargeOrderWithOrderInfoModel:orderInfoModel];
}
#pragma mark ---
-(MobileRechargeInfoView *)rechargeView{
    if (!_rechargeView) {
        _rechargeView = [[MobileRechargeInfoView alloc]initWithDelegate:self];
        [_rechargeView setFrame:CGRectMake(0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height-k_Navigation_Bar_Height)];
    }
    return _rechargeView;
}
-(ZTMXFMobileRechargeInfoViewModel *)infoViewModel{
    if (!_infoViewModel) {
        _infoViewModel = [[ZTMXFMobileRechargeInfoViewModel alloc]init];
        _infoViewModel.delegate = self;
    }
    return _infoViewModel;
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
