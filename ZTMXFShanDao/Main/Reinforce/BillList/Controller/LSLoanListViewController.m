//
//  LSLoanListViewController.m
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanListViewController.h"
#import "LSLoanListTableViewCell.h"
#import "LSLoanRecordModel.h"
#import "LSRepaymentListModel.h"
#import "BorrwowCashListApi.h"
#import "RepaymentListApi.h"
#import "LSLoanDetailViewController.h"
#import "LSRenewDetailViewController.h"
#import "LSMyBillsListViewController.h"
#import "LSWhiteLoanDetailViewController.h"
#import "CYLTabBarController.h"
#import "ZTMXFServerStatisticalHelper.h"

@interface LSLoanListViewController ()
/** footer View */
@property (nonatomic, strong) UIView            *footerView;
/** Service Button*/
@property (nonatomic, strong) UIButton          *serviceButton;
//解决埋点问题用
@property (nonatomic, assign) BOOL didPageStatistical;

@end

@implementation LSLoanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现记录";
    self.pageNum = 1;
    [self boneListWithPage:self.pageNum];
    [self configueSubViews];

//    [self setNavgationBarRightTitle:@"分期账单"];
}

- (void)viewDidDisappear:(BOOL)animated{
    if (!_didPageStatistical) {
        [super viewDidDisappear:animated];
    }
}

#pragma mark UITableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSLoanListTableViewCell *cell = [LSLoanListTableViewCell cellWithTableView:tableView];
    LSLoanRecordModel *loanRecordModel = self.dataArray[indexPath.row];
    cell.loanRecordModel = loanRecordModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return X(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LSLoanRecordModel *loanRecordModel = self.dataArray[indexPath.row];
    if (loanRecordModel.type == 3) {
        // 白领贷
        LSWhiteLoanDetailViewController *whiteLoanDetailVC = [[LSWhiteLoanDetailViewController alloc] init];
        whiteLoanDetailVC.borrowId = loanRecordModel.rid;
        [self.navigationController pushViewController:whiteLoanDetailVC animated:YES];
    } else {
        // 消费贷、现金贷
        LSLoanDetailViewController *loanDetailVC = [[LSLoanDetailViewController alloc] init];
        loanDetailVC.borrowId = loanRecordModel.rid;
        [self.navigationController pushViewController:loanDetailVC animated:YES];
    }
}


#pragma mark - 右边导航点击
- (void)right_button_event:(UIButton *)sender
{
    LSMyBillsListViewController *billsListVC = [[LSMyBillsListViewController alloc] init];
    [self.navigationController pushViewController:billsListVC animated:YES];
}


#pragma mark - 接口请求
//  获取借钱列表
- (void)boneListWithPage:(NSInteger)currentPage
{
    BorrwowCashListApi *api = [[BorrwowCashListApi alloc] initWithPage:currentPage];
    [SVProgressHUD showLoadingWithOutMask];
    @WeakObj(self);
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        @StrongObj(self);
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *couponArray = responseDict[@"data"][@"cashList"];
            if (couponArray.count > 0) {
                NSArray *couponModelArray = [LSLoanRecordModel mj_objectArrayWithKeyValuesArray:couponArray];
                if (self.pageNum == 1) {
                    [self.dataArray  removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:couponModelArray];
            }
            self.pageNum ++;
            [self endRef];
            //增加无数据展现
            [self.view configBlankPage:EaseBlankPageTypeNoLoanList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
                
                [ZTMXFServerStatisticalHelper loanStatisticalApiWithIoutTime:[NSDate date] CurrentClassName:NSStringFromClass([self class]) PageName:self.pageName];
                _didPageStatistical = YES;
                [self.navigationController popToRootViewControllerAnimated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Waiting_Time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self cyl_tabBarController].selectedIndex = 1;
                });
            }];

        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark -

- (void)refData
{
    self.pageNum = 1;
    [self boneListWithPage:self.pageNum];
}

- (void)moreData
{
    [self boneListWithPage:self.pageNum];
}

#pragma mark - 按钮点击事件
- (void)serviceButtonAction{
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(serviceCenter);
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0.0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height - k_Navigation_Bar_Height);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.backgroundColor = K_LineColor;

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
