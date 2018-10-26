//
//  LSRefundDetailViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLSRefundDetailViewController.h"
#import "ZTMXFRefundDetailHeaderView.h"
#import "ZTMXFOrderDetailStyleOneCell.h"
#import "ZTMXFOrderDetailStyleTwoCell.h"
#import "ZTMXFRefundDetailViewModel.h"
#import "ZTMXFRefundDetailInfoModel.h"
#import "ZTMXFRefundDetailInfoManager.h"
#import "ZTMXFLSApplyRefundViewController.h"

@interface ZTMXFLSRefundDetailViewController ()<UITableViewDelegate, UITableViewDataSource, RefundDetailViewModelDelegate>
/** tableView */
@property (nonatomic, strong) UITableView           *tableView;
/** 底部按钮 */
@property (nonatomic, strong) UIButton              *bottomButton;

/** data Array */
@property (nonatomic, strong) NSMutableArray        *dataArray;

/** 退款详情 */
@property (nonatomic, strong) ZTMXFRefundDetailHeaderView *refundDetailHeaderView;
/** viewModel */
@property (nonatomic, strong) ZTMXFRefundDetailViewModel *refundDetailViewModel;
/** 数据Model */
@property (nonatomic, strong) ZTMXFRefundDetailInfoModel *refundDetailInfoModel;

@end

@implementation ZTMXFLSRefundDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退款详情";
    [self configSubViews];
}



#pragma mark - UITableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.dataArray[section];
    return sectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(50.0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cellDict = self.dataArray[indexPath.section][indexPath.row];
    NSString *titleString = cellDict[kTitleValueCellManagerKey];
    NSString *valueString = cellDict[kTitleValueCellManagerValue];
    if (indexPath.section == 0) {
        ZTMXFOrderDetailStyleOneCell *cell = [ZTMXFOrderDetailStyleOneCell cellWithTableView:tableView];
        cell.titleLabel.text = titleString;
        cell.valueLabel.text = valueString;
        return cell;
    } else {
        ZTMXFOrderDetailStyleTwoCell *cell = [ZTMXFOrderDetailStyleTwoCell cellWithTableView:tableView];
        cell.titleLabel.text = titleString;
        cell.valueLabel.text = valueString;
        if ([titleString isEqualToString:kRefundOrderNumber]) {
            cell.valueButton.hidden = NO;
        } else {
            cell.valueButton.hidden = YES;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 10.0)];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 10.0)];
    footerView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    return footerView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BOOL showLoading = YES;
    if (self.refundDetailInfoModel) {
        showLoading = NO;
    }
    [self.refundDetailViewModel requestRefundDetailWithOrderId:self.orderId showLoad:showLoading];
}
#pragma mark - RefundDetailViewModelDelegate(退款详情接口请求数据)
/** 获取退款详情成功 */
- (void)requestRefundDetailSuccess:(ZTMXFRefundDetailInfoModel *)refundDetailInfoModel{
    if (refundDetailInfoModel) {
        self.refundDetailInfoModel = refundDetailInfoModel;
        self.refundDetailHeaderView.refundDetailInfoModel = self.refundDetailInfoModel;
        
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        NSArray *refundDataArray = [ZTMXFRefundDetailInfoManager refundDetailArrayFromRefundInfoModel:refundDetailInfoModel];
        if (refundDataArray.count > 0) {
            [self.dataArray addObjectsFromArray:refundDataArray];
        }
        [self.tableView reloadData];
        
        /** 售后状态：0:申请退款 1:退款成功 2.退款中 3:同意退款 -1:拒绝退货退款 */
        if (refundDetailInfoModel.status == 0) {
            [self.bottomButton setTitle:@"撤销申请" forState:UIControlStateNormal];
            self.bottomButton.hidden = NO;
        } else if (refundDetailInfoModel.status == -1) {
            [self.bottomButton setTitle:@"再次申请退款" forState:UIControlStateNormal];
            self.bottomButton.hidden = NO;
        } else {
            [self.bottomButton setTitle:@"" forState:UIControlStateNormal];
            self.bottomButton.hidden = YES;
        }
    }
}

/** 申请撤销退款成功 */
- (void)requestCancelApplyRefundSuccess{
    [self.view makeCenterToast:@"撤销申请退款成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - 按钮点击事件
- (void)bottomButtonAction:(UIButton *)sender{
    /** 售后状态：0:申请退款 1:退款成功 2.退款中 3:同意退款 -1:拒绝退货退款 */
    if (self.refundDetailInfoModel.status == 0) {
        //  点击撤销申请
        [self.refundDetailViewModel requestCancelApplyRefundWithRefundId:self.refundDetailInfoModel.rid];
    } else if (self.refundDetailInfoModel.status == -1) {
        //  点击再次申请退款
        ZTMXFLSApplyRefundViewController *applyRefundVC = [[ZTMXFLSApplyRefundViewController alloc] init];
        applyRefundVC.orderId = self.orderId;
        [self.navigationController pushViewController:applyRefundVC animated:YES];
    }
}

#pragma mark - 添加子控件
- (void)configSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.refundDetailHeaderView;
    [self.view addSubview:self.bottomButton];
    self.bottomButton.hidden = YES;
}

#pragma mark - getter/setter
- (ZTMXFRefundDetailHeaderView *)refundDetailHeaderView{
    if (_refundDetailHeaderView == nil) {
        _refundDetailHeaderView = [[ZTMXFRefundDetailHeaderView alloc] init];
        _refundDetailHeaderView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _refundDetailHeaderView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(200.0));
    }
    return _refundDetailHeaderView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height - TabBar_Addition_Height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, AdaptedHeight(50.0), 0.0);
    }
    return _tableView;
}

- (UIButton *)bottomButton{
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"再次申请退款" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bottomButton.backgroundColor = [UIColor colorWithHexString:COLOR_RED_STR];
        [_bottomButton addTarget:self action:@selector(bottomButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _bottomButton.frame = CGRectMake(0.0, Main_Screen_Height - TabBar_Addition_Height - AdaptedHeight(50.0), Main_Screen_Width, AdaptedHeight(50.0));
    }
    return _bottomButton;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (ZTMXFRefundDetailViewModel *)refundDetailViewModel{
    if (_refundDetailViewModel == nil) {
        _refundDetailViewModel = [[ZTMXFRefundDetailViewModel alloc] init];
        _refundDetailViewModel.delegate = self;
    }
    return _refundDetailViewModel;
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
