//
//  LSOrderPaySuccessViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSOrderPaySuccessViewController.h"
#import "OrderPaySuccessView.h"
#import "ZTMXFLSOrderDetailInfoViewController.h"

@interface LSOrderPaySuccessViewController ()<OrderPaySuccessViewDelegate>

@property (nonatomic, strong) OrderPaySuccessView *paySuccessView;

@end

@implementation LSOrderPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付成功";
    [self configSubViews];
    self.fd_interactivePopDisabled = YES;
}

//  返回首页
- (void)clickReturnBackEvent{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 代理方法
/** 返回首页 */
- (void)orderPaySuccessViewReturnHomePage{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/** 查看订单 */
- (void)orderPaySuccessViewCheckOrderDetail{
    ZTMXFLSOrderDetailInfoViewController *orderDetailInfoVC = [[ZTMXFLSOrderDetailInfoViewController alloc] init];
    orderDetailInfoVC.orderId = self.orderId;
    orderDetailInfoVC.orderDetailType = MallOrderDetailType;
    [self.navigationController pushViewController:orderDetailInfoVC animated:YES];
}

#pragma mark - 私有方法

#pragma mark - 添加子控件
- (void)configSubViews{
    self.paySuccessView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    [self.view addSubview:self.paySuccessView];
    
    if (!kStringIsEmpty(self.statusDesc)) {
        self.paySuccessView.successTitleLabel.text = self.statusDesc;
    }
    
    if (!kStringIsEmpty(self.payAmount)) {
        self.paySuccessView.orderPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.payAmount];
    }
    
}

#pragma mark - getter/setter
- (OrderPaySuccessView *)paySuccessView{
    if (_paySuccessView == nil) {
        _paySuccessView = [[OrderPaySuccessView alloc] init];
        _paySuccessView.delegate = self;
    }
    return _paySuccessView;
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
