//
//  LSRenewListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSRenewListViewController.h"
#import "LSRenewDetailViewController.h"
#import "LSLoanRecordTableViewCell.h"
#import "RenewRecordApi.h"
#import "ZTMXFRenewRecordModel.h"

@interface LSRenewListViewController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** data Array */
@property (nonatomic, strong) NSMutableArray    *dataArray;
/** current page */
@property (nonatomic, assign) NSInteger         currentPage;

@end

@implementation LSRenewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"延期还款记录";
    self.currentPage = 1;
    [self configueSubViews];
    [self renewListWithPage:self.currentPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSLoanRecordTableViewCell *cell = [LSLoanRecordTableViewCell cellWithTableView:tableView];
    ZTMXFRenewRecordModel *renewRecordModel = self.dataArray[indexPath.section];
    cell.renewRecordModel = renewRecordModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSRenewDetailViewController *renewDetailVC = [[LSRenewDetailViewController alloc] init];
    renewDetailVC.controllerType = RenewDetailControllerType;
    
    ZTMXFRenewRecordModel *renewRecordModel = self.dataArray[indexPath.section];
    renewDetailVC.renewId = [NSString stringWithFormat:@"%ld",renewRecordModel.rid];
    renewDetailVC.renewalPayAmount = renewRecordModel.renewalPayAmount;
    [self.navigationController pushViewController:renewDetailVC animated:YES];
}




#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
}
#pragma mark - 接口请求
//  获取借钱列表
- (void)renewListWithPage:(NSInteger)currentPage{
    RenewRecordApi *api = [[RenewRecordApi alloc] initWithBorrowId:self.borrowId page:currentPage];
    [SVProgressHUD showLoading];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        //        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *couponArray = responseDict[@"data"][@"renewalList"];
            if (couponArray.count > 0) {
                NSArray *couponModelArray = [ZTMXFRenewRecordModel mj_objectArrayWithKeyValuesArray:couponArray];
                [self.dataArray addObjectsFromArray:couponModelArray];
                [self.tableView reloadData];
            }
        }
        //增加无数据展现
        [self.view configBlankPage:EaseBlankPageTypeNoRepaymentList hasData:_dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
        }];
        //
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
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
        
        _tableView.sectionFooterHeight = .01;
        UIView * footView = [[UIView alloc]init];
        [footView setFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 10.0)];
        [footView setBackgroundColor:[UIColor clearColor]];
        _tableView.tableFooterView = footView;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
