//
//  LSOrderPayFailureViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSOrderPayFailureViewController.h"
#import "OrderPayFailureView.h"
#import "ZTMXFLSOrderDetailInfoViewController.h"

@interface LSOrderPayFailureViewController ()<OrderPayFailureViewDelegate>

@property (nonatomic, strong) OrderPayFailureView *payFailureView;
@end

@implementation LSOrderPayFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付失败";
    [self configSubViews];
    self.fd_interactivePopDisabled = YES;
}

//  返回首页
- (void)clickReturnBackEvent{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 私有方法
/** 返回首页 */
- (void)orderPayFailureViewReturnHomePage{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/** 查看订单 */
- (void)orderPayFailureViewCheckOrderDetail{
    ZTMXFLSOrderDetailInfoViewController *orderDetailInfoVC = [[ZTMXFLSOrderDetailInfoViewController alloc] init];
    orderDetailInfoVC.orderId = self.orderId;
    orderDetailInfoVC.orderDetailType = MallOrderDetailType;
    [self.navigationController pushViewController:orderDetailInfoVC animated:YES];
}

#pragma mark - 添加子控件
- (void)configSubViews{
    self.payFailureView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    [self.view addSubview:self.payFailureView];
    
    self.payFailureView.failureTitleLabel.text = self.statusDesc;
    self.payFailureView.failureDescrition.text = self.finishDesc;
}

#pragma mark - getter/setter
- (OrderPayFailureView *)payFailureView{
    if (_payFailureView == nil) {
        _payFailureView = [[OrderPayFailureView alloc] init];
        _payFailureView.delegate = self;
    }
    return _payFailureView;
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
