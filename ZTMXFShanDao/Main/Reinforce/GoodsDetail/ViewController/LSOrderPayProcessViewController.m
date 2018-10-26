//
//  LSOrderPayProcessViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSOrderPayProcessViewController.h"
#import "OrderPayProcessView.h"

@interface LSOrderPayProcessViewController ()<OrderPayProcessViewDelegate>

@property (nonatomic, strong) OrderPayProcessView *payProcessView;

@end

@implementation LSOrderPayProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付中";
    [self configSubViews];
    self.fd_interactivePopDisabled = YES;
}

//  返回首页
- (void)clickReturnBackEvent{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 代理方法
/** 返回首页 */
- (void)orderPayProcessViewReturnHomePage{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 私有方法

#pragma mark - 添加子控件
- (void)configSubViews{
    self.payProcessView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    [self.view addSubview:self.payProcessView];
    
    self.payProcessView.processTitleLabel.text = self.statusDesc;
    self.payProcessView.processDescrition.text = self.finishDesc;
}

#pragma mark - getter/setter
- (OrderPayProcessView *)payProcessView{
    if (_payProcessView == nil) {
        _payProcessView = [[OrderPayProcessView alloc] init];
        _payProcessView.delegate = self;
    }
    return _payProcessView;
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
