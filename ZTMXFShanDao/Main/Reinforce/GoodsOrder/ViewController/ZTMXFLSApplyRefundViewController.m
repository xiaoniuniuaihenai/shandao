//
//  LSApplyRefundViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLSApplyRefundViewController.h"
#import "ZTMXFApplyRefundView.h"
#import "ZTMXFApplyRefundViewModel.h"
#import "LSLocationManager.h"

@interface ZTMXFLSApplyRefundViewController ()<ApplyRefundViewModelDelegate, ApplyRefundViewDelegate>

/** 申请退款view */
@property (nonatomic, strong) ZTMXFApplyRefundView *applyRefundView;
/** viewModel */
@property (nonatomic, strong) ZTMXFApplyRefundViewModel *applyRefundViewModel;

/** 获取经纬度 */
@property (nonatomic, copy) NSString *latitudeString;
@property (nonatomic, copy) NSString *longitudeString;

@end

@implementation ZTMXFLSApplyRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请退款";
    [self configSubViews];
    [self.applyRefundViewModel requestApplyRefundDataInfoWithOrderId:self.orderId];
    //  设置定位
    ZTMXFLSApplyRefundViewController * __weak weakSelf = self;
    if (![LoginManager appReviewState]){
        [[LSLocationManager shareLocationManager] locationSuccessWithComplish:^(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString) {
            weakSelf.latitudeString = latitudeString;
            weakSelf.longitudeString = longitudeString;
        }];
    }
}



#pragma mark -
/** 提交申请退款 */
- (void)applyRefundViewSubmitApplyRefundWithRefundCode:(NSString *)refundCode refundDesc:(NSString *)refundDesc refundAmount:(NSString *)refundAmount{
    [self.applyRefundViewModel requestApplyRefundSubmitWithOrderId:self.orderId refundReason:refundCode refundDesc:refundDesc refundAmount:refundAmount latitude:self.latitudeString longitude:self.longitudeString];
}

#pragma mark - 私有方法

#pragma mark - 添加子控件
- (void)configSubViews{
    [self.view addSubview:self.applyRefundView];
}
#pragma mark - ApplyRefundViewModelDelegate
/** 获取申请退款页面信息成功 */
- (void)requestApplyRefundDataInfoSuccess:(ApplyRefundInfoModel *)applyRefundInfoModel{
    if (applyRefundInfoModel) {
        self.applyRefundView.applyRefundInfoModel = applyRefundInfoModel;
    }
}
/** 申请退款成功 */
- (void)requestApplyRefundSubmitSuccess{
    NSLog(@"成功");
    [self.view makeCenterToast:@"提交退款成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}



#pragma mark - getter/setter
- (ZTMXFApplyRefundView *)applyRefundView{
    if (_applyRefundView == nil) {
        _applyRefundView = [[ZTMXFApplyRefundView alloc] init];
        _applyRefundView.delegate = self;
        _applyRefundView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _applyRefundView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    }
    return _applyRefundView;
}

- (ZTMXFApplyRefundViewModel *)applyRefundViewModel{
    if (_applyRefundViewModel == nil) {
        _applyRefundViewModel = [[ZTMXFApplyRefundViewModel alloc] init];
        _applyRefundViewModel.delegate = self;
    }
    return _applyRefundViewModel;
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
