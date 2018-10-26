//
//  LSRenewDetailViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSRenewDetailViewController.h"
#import "RenewDetailHeaderView.h"
#import "LSTitleValueTableViewCell.h"
#import "RenewDetailApi.h"
#import "RepaymentDetailApi.h"
#import "LSRenewDetailModel.h"
#import "LSRepaymentDetailModel.h"
#import "RenewDetailManager.h"
#import "RepaymentDetialManager.h"
#import "LSWebViewController.h"

@interface LSRenewDetailViewController ()<UITableViewDelegate, UITableViewDataSource, RenewDetailHeaderViewDelegate>
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** header View */
@property (nonatomic, strong) RenewDetailHeaderView  *renewHeaderView;
/** data Array */
@property (nonatomic, strong) NSArray *dataArray;

/** 延期还款详情Model */
@property (nonatomic, strong) LSRenewDetailModel *renewDetailModel;
/** 还款详情Model */
@property (nonatomic, strong) LSRepaymentDetailModel *repaymentDetailModel;

@end

@implementation LSRenewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configueSubViews];

    if (_controllerType == RepaymentDetailControllerType) {
        //  还款详情
        self.navigationItem.title = @"还款详情";
        [self requestRepaymentDetailInfo];
//        [self getRepayDetailInfoTestData];
    } else if(_controllerType == RenewDetailControllerType) {
        //  延期还款详情
        self.navigationItem.title = @"延期还款详情";
        [self requestRenewDetailInfo];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark UITableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSTitleValueTableViewCell *cell = [LSTitleValueTableViewCell cellWithTableView:tableView];
    NSDictionary *cellDict = self.dataArray[indexPath.row];
    cell.titleLabel.text = cellDict[kTitleValueCellManagerKey];
    cell.valueLabel.text = cellDict[kTitleValueCellManagerValue];
    if ([cell.titleLabel.text isEqualToString:@"延期还款编号"]) {
        cell.showRowImageView = YES;
    } else {
        cell.showRowImageView = NO;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cellDict = self.dataArray[indexPath.row];
    NSString *title = cellDict[kTitleValueCellManagerKey];
    if ([title isEqualToString:@"延期还款编号"]) {
        LSWebViewController *webVC = [[LSWebViewController alloc] init];
        NSString *renewDays = [NSString stringWithFormat:@"%ld",self.renewDetailModel.renewalDays];
        NSString *renewalAmount = [NSString stringWithFormat:@"%f",self.renewDetailModel.renewalAmount];
        NSString *borrowId = [NSString stringWithFormat:@"%ld", self.renewDetailModel.borrowId];
        webVC.webUrlStr = DefineUrlString(renewalProtocol([LoginManager userPhone], self.renewId, borrowId, renewDays, renewalAmount));
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(50.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedHeight(100.0) + 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    [headerView addSubview:self.renewHeaderView];
    return headerView;
}



#pragma mark - 接口请求
//  获取延期还款详情数据
- (void)requestRenewDetailInfo{
    RenewDetailApi *renewDetailApi = [[RenewDetailApi alloc] initWithRenewId:self.renewId];
    [SVProgressHUD showLoading];
    [renewDetailApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.renewDetailModel = [LSRenewDetailModel mj_objectWithKeyValues:dataDict];
            _renewDetailModel.renewalPayAmount = _renewalPayAmount;

            self.renewHeaderView.renewDetailModel = self.renewDetailModel;
            self.dataArray = [RenewDetailManager manageWithRenewDetailModel:self.renewDetailModel];
            [self.tableView reloadData];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}


//  获取还款详情数据
- (void)requestRepaymentDetailInfo{
    RepaymentDetailApi *api = [[RepaymentDetailApi alloc] initWithRepaymentId:self.repaymentId];
    [SVProgressHUD showLoading];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.repaymentDetailModel = [LSRepaymentDetailModel mj_objectWithKeyValues:dataDict];
            self.renewHeaderView.repaymentDetailModel = self.repaymentDetailModel;
            self.dataArray = [RepaymentDetialManager manageWithRenewDetailModel:self.repaymentDetailModel];
            [self.tableView reloadData];
        }
        
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
#pragma mark - RenewDetailHeaderViewDelegate 代理方法
- (void)renewDetailHeaderViewClickReturnBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 测试数据
- (void)getRepayDetailInfoTestData{
    for (int i =0; i<10; i++) {
        NSDictionary *dataDict = @{@"amount":@1000.00,@"status":@1,@"statusDesc":@"还款成功",@"couponAmount":@50.00,@"userAmount":@500.00,@"cashAmount":@300.00,@"cardNumber":@"420328247472744722747247",@"cardName":@"建设银行",@"repayNo":@"000001",@"gmtCreate":@2071872373727};
        self.repaymentDetailModel = [LSRepaymentDetailModel mj_objectWithKeyValues:dataDict];
        self.renewHeaderView.repaymentDetailModel = self.repaymentDetailModel;
        self.dataArray = [RepaymentDetialManager manageWithRenewDetailModel:self.repaymentDetailModel];
        [self.tableView reloadData];
    }
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
}

#pragma mark - getters and setters

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (RenewDetailHeaderView *)renewHeaderView{
    if (_renewHeaderView == nil) {
        _renewHeaderView = [[RenewDetailHeaderView alloc] init];
        _renewHeaderView.backgroundColor = [UIColor whiteColor];
        _renewHeaderView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(100.0));
        _renewHeaderView.delegate = self;
    }
    return _renewHeaderView;

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
