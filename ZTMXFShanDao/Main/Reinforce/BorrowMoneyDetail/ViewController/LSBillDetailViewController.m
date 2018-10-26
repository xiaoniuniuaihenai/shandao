//
//  LSBillDetailViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/10.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBillDetailViewController.h"
#import "RenewDetailHeaderView.h"
#import "RenewDetailApi.h"
#import "RepaymentDetailApi.h"
#import "LSRepaymentDetailModel.h"
#import "RepaymentDetialManager.h"
#import "LSWebViewController.h"
#import "LSBillDetailCell.h"
#import "MyBillViewModel.h"
#import "LSBillListModel.h"
#import "ALAConstants.h"

#import "AlertSheetActionManager.h"
@interface LSBillDetailViewController () <UITableViewDataSource,UITableViewDelegate,RenewDetailHeaderViewDelegate,MyBillViewModelDelegete>

/** tableView */
@property (nonatomic, strong) UITableView       *tableView;
/** header View */
@property (nonatomic, strong) RenewDetailHeaderView  *renewHeaderView;
/** data Array */
@property (nonatomic, strong) NSArray *dataArray;

/** 账单ViewModel */
@property (nonatomic, strong) MyBillViewModel *billViewModel;
/**账单详情Model */
@property (nonatomic, strong) LSBillDetailModel *billDetailModel;

@end

@implementation LSBillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configueSubViews];
    self.navigationItem.title = @"账单详情";
    [self.billViewModel requestBillDetailWithBillId:self.billId];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}



#pragma mark - MyBillViewModelDelegete
#pragma mark - 获取账单详情
-(void)requestBillDetailSuccess:(LSBillDetailModel *)billDetailModel{
    self.billDetailModel = billDetailModel;
    
    self.renewHeaderView.billDetailModel = self.billDetailModel;
    self.dataArray = [RepaymentDetialManager managerWithBillDetailModel:self.billDetailModel];
    [self.tableView reloadData];
}

#pragma mark UITableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionAry = [self.dataArray objectAtIndex:section];
    return sectionAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(50.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSBillDetailCell *cell = [LSBillDetailCell cellWithTableView:tableView];
    NSDictionary *cellDict = self.dataArray[indexPath.section][indexPath.row];
    cell.titleLabel.text = cellDict[kTitleValueCellManagerKey];
    cell.valueLabel.text = cellDict[kTitleValueCellManagerValue];
    if ([cell.titleLabel.text isEqualToString:@"借款编号"]) {
        cell.showRowImageView = YES;
    } else {
        cell.showRowImageView = NO;
    }
    return cell;
}

#pragma mark UITableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *cellDict = self.dataArray[indexPath.section][indexPath.row];
    NSString *title = cellDict[kTitleValueCellManagerKey];
    if ([title isEqualToString:@"借款编号"]) {
        NSString *billId = [NSString stringWithFormat:@"%ld",self.billDetailModel.borrowId];
        NSString *borrowAmount = [NSString stringWithFormat:@"%.2f",self.billDetailModel.billAmount];
        NSArray * arrActionTitle = @[@"《闪到借款协议》",@"《委托融资协议》"];
        MJWeakSelf
        [AlertSheetActionManager sheetActionTitle:@"协议" message:nil arrTitleAction:arrActionTitle superVc:self blockClick:^(NSInteger index) {
            NSString * webUrl = @"";
            if (index==0) {
                webUrl = DefineUrlString(personalWhiteCashProtocol([LoginManager userPhone],billId, borrowAmount,@""));
            }else{
                webUrl = DefineUrlString(entrustBorrowCashProtocol(billId,borrowAmount,@"3"));
            }
            LSWebViewController *borrowNumVC = [[LSWebViewController alloc] init];
            borrowNumVC.webUrlStr = webUrl;
            [weakSelf.navigationController pushViewController:borrowNumVC animated:YES];
        }];
    }
}




#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
}
#pragma mark - RenewDetailHeaderViewDelegate 代理方法
- (void)renewDetailHeaderViewClickReturnBack{
    [self.navigationController popViewControllerAnimated:YES];
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
        _tableView.sectionFooterHeight = 1;
        _tableView.sectionHeaderHeight = 1;
    
        _tableView.tableHeaderView = self.renewHeaderView;
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

#pragma mark - setter
-(MyBillViewModel *)billViewModel{
    if (!_billViewModel) {
        _billViewModel = [[MyBillViewModel alloc] init];
        _billViewModel.delegete = self;
    }
    return _billViewModel;
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
