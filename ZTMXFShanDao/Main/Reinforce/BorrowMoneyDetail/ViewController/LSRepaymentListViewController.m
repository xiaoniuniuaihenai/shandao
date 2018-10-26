//
//  LSRepaymentListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSRepaymentListViewController.h"
#import "LSLoanRecordTableViewCell.h"
#import "RepaymentListApi.h"
#import "LSRepaymentListModel.h"
#import "LSRenewDetailViewController.h"

@interface LSRepaymentListViewController ()<UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** data Array */
@property (nonatomic, strong) NSMutableArray    *dataArray;

@end

@implementation LSRepaymentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  还款明细列表
    self.navigationItem.title = @"还款明细";
    
    [self requestRepaymentListApi];//网络请求
//    [self getListModelData];//测试数据
    [self configueSubViews];

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
        //  还款记录
    LSRepaymentListModel *repaymentListModel = self.dataArray[indexPath.section];
    cell.repaymentListModel = repaymentListModel;
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
    //  还款记录
    LSRepaymentListModel *repaymentListModel = self.dataArray[indexPath.section];
    LSRenewDetailViewController *renewDetailVC = [[LSRenewDetailViewController alloc] init];
    renewDetailVC.controllerType = RepaymentDetailControllerType;
    renewDetailVC.repaymentId = [NSString stringWithFormat:@"%ld",repaymentListModel.rid];
    [self.navigationController pushViewController:renewDetailVC animated:YES];

}





//  获取还款明细列表
- (void)requestRepaymentListApi{
    RepaymentListApi *api = [[RepaymentListApi alloc] initWithBorrowId:self.borrowId];
    [SVProgressHUD showLoading];
    
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        [SVProgressHUD dismiss];
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSArray *dataArray = responseDict[@"data"][@"repayList"];
            if (dataArray.count > 0) {
                NSArray *repaymentArray = [LSRepaymentListModel mj_objectArrayWithKeyValuesArray:dataArray];
                [self.dataArray addObjectsFromArray:repaymentArray];
                [self.tableView reloadData];
            }
            
            //增加无数据展现
            [self.view configBlankPage:EaseBlankPageTypeNoRepaymentList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
            }];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
- (void)getListModelData{
    for (int i=0; i<5; i++) {
        LSRepaymentListModel *model = [[LSRepaymentListModel alloc] init];
        model.rid = 1000 + i;
        model.repayDec = @"主动还款";
        model.gmtRepay = 1280482404201 + i*10;
        model.amount = 100.00 + i;
        model.status = (i % 2 == 0 ) ? 0 : 1;
        model.statusDesc = @"还款成功";
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
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
