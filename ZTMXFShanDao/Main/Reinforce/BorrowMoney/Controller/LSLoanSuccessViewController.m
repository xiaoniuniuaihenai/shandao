//
//  LSLoanSuccessViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanSuccessViewController.h"
#import "ZTMXFHomePageViewController.h"
#import "LSOrderListViewController.h"
#import "LSMyBillsListViewController.h"
#import "LSWhiteLoanDetailViewController.h"
#import "ZTMXFLSOrderDetailInfoViewController.h"

@interface LSLoanSuccessViewController ()

@property (nonatomic, strong) UIImageView *successImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *bottomImageView;

@end

@implementation LSLoanSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"借款成功"];
    [self set_Title:titleStr];
    [self configueSubViews];
    self.fd_interactivePopDisabled = YES;// 禁止侧滑
}

#pragma mark - 点击按钮
- (void)clickButton:(UIButton *)sender{
    if (sender.tag == 1) {
        // 点击首页
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (sender.tag == 2){
        if (self.loanType == LSWhiteCollarType) {
            // 白领贷跳到账单详情页
            LSWhiteLoanDetailViewController *whiteLoanDetailVC = [[LSWhiteLoanDetailViewController alloc] init];
            whiteLoanDetailVC.borrowId = self.borrowId;
            [self.navigationController pushViewController:whiteLoanDetailVC animated:YES];
        } else if (self.loanType == LSConsumerLoanType){
            // 跳转到订单详情页
            ZTMXFLSOrderDetailInfoViewController *orderDetailVC = [[ZTMXFLSOrderDetailInfoViewController alloc] init];
            orderDetailVC.orderId = self.orderId;
            orderDetailVC.orderDetailType = ConsumeLoanOrderDetailType;
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        }
    }
}

#pragma mark - 点击返回按钮
- (void)clickReturnBackEvent{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 设置子视图
- (void)configueSubViews{

    [self.view addSubview:self.successImgView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.subTitleLabel];
    
    UIButton *homePageButton = [self creatButtonWithTitle:@"首页"];
    [homePageButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [homePageButton setTitleColor:UIColor.whiteColor forState:UIControlStateHighlighted];
    homePageButton.backgroundColor = K_MainColor;
    [homePageButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
    homePageButton.tag = 1;
    [self.view addSubview:homePageButton];
    
    NSString *title = _loanType == LSWhiteCollarType ? @"借款详情" : @"查看订单";
    
    UIButton *checkOrder = [self creatButtonWithTitle:title];
    [checkOrder setTitleColor:K_MainColor forState:UIControlStateNormal];
    [checkOrder setTitleColor:K_MainColor forState:UIControlStateHighlighted];
    checkOrder.tag = 2;
    [self.view addSubview:checkOrder];
    
    
    if (_loanType == LSWhiteCollarType) {
        // 白领贷
        [_successImgView setFrame:CGRectMake(0, k_Navigation_Bar_Height + AdaptedHeight(40), 141, 128)];
        _successImgView.image = [UIImage imageNamed:@"loanSuccess_big"];
        _titleLabel.text = @"恭喜您，借款成功";
        _subTitleLabel.text = @"我们将在3分钟之内放款，请关注银行账单";
    }else if (_loanType == LSConsumerLoanType){
        // 消费贷
        [_successImgView setFrame:CGRectMake(0, k_Navigation_Bar_Height + AdaptedHeight(35), 116, 127)];
        _successImgView.image = [UIImage imageNamed:@"orderSucceed"];
        _titleLabel.text = @"订单已提交，等待发货";
        _subTitleLabel.text = @"预计3个工作日内会发货，请耐心等待......";
    }
    
    _successImgView.centerX = SCREEN_WIDTH/2.0;
    _titleLabel.top = _successImgView.bottom + 25;
    _subTitleLabel.top = _titleLabel.bottom + 13;
    
    homePageButton.top = _subTitleLabel.bottom + AdaptedHeight(70);
    homePageButton.centerX = self.view.centerX;
    checkOrder.centerY = homePageButton.centerY + X(62);
    checkOrder.centerX = self.view.centerX;
}

- (UIButton *)creatButtonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, X(160),X(40))];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    button.layer.borderWidth = 1;
    button.layer.borderColor = K_MainColor.CGColor;
    button.layer.cornerRadius = button.height/2.0;
    button.layer.masksToBounds = YES;
    
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (UIImageView *)successImgView{
    if (!_successImgView) {
        _successImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _successImgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:16 alignment:NSTextAlignmentCenter];
        [_titleLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_LIGHT_STR] fontSize:13 alignment:NSTextAlignmentCenter];
        [_subTitleLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 18)];
    }
    return _subTitleLabel;
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
