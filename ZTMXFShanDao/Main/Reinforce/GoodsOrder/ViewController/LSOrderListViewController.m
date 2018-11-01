//
//  LSOrderListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSOrderListViewController.h"
#import "ZTMXFOrderListTableViewCell.h"
#import "ZTMXFLSOrderDetailInfoViewController.h"
#import "OrderListModel.h"
#import "ZTMXFOrderListFrame.h"

#import "CancelOrderAlertView.h"

#import "ZTMXFOrderListViewModel.h"
#import "ZTMXFLSApplyRefundViewController.h"
#import "LSPaymentOrderViewController.h"
#import "YWLTLogisticsInfoViewController.h"
#import "ZTMXFLSRefundDetailViewController.h"
#import "ShanDaoChooseAddressViewController.h"
#import "ZTMXFMobileRechargeController.h"
#import "LSAddressManagerViewController.h"
@interface LSOrderListViewController ()<UITableViewDelegate, UITableViewDataSource, OrderListViewModelDelegate, OrderListViewDelegate, ChooseAddressProtocol>
/** tableView */
//@property (nonatomic, strong) UITableView       *tableView;
/** data Array */
//@property (nonatomic, strong) NSMutableArray    *dataArray;
/** viewModel */
@property (nonatomic, strong) ZTMXFOrderListViewModel *orderListViewModel;
/** 当前请求页码 */
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation LSOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单管理";
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    [self configueSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //  请求页面数据
    self.pageNum = 1;
    [self loadOrderListData];
}

#pragma mark - UITableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTMXFOrderListFrame *orderListFrame = self.dataArray[indexPath.row];
    return orderListFrame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTMXFOrderListTableViewCell *cell = [ZTMXFOrderListTableViewCell cellWithTableView:tableView];
    ZTMXFOrderListFrame *orderListFrame = self.dataArray[indexPath.row];
    cell.orderListFrame = orderListFrame;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZTMXFLSOrderDetailInfoViewController *orderDetailVC = [[ZTMXFLSOrderDetailInfoViewController alloc] init];
    ZTMXFOrderListFrame *orderListFrame = self.dataArray[indexPath.row];
    orderDetailVC.orderId = [NSString stringWithFormat:@"%ld",orderListFrame.orderListModel.orderId];
    /** 订单类型 1 消费贷 2 分期商城 3 手机充值 */
    if (orderListFrame.orderListModel.orderType == 1) {
        orderDetailVC.orderDetailType = ConsumeLoanOrderDetailType;
    } else if (orderListFrame.orderListModel.orderType == 2) {
        orderDetailVC.orderDetailType = MallOrderDetailType;
    } else if (orderListFrame.orderListModel.orderType == 3) {
        orderDetailVC.orderDetailType = MobileLoanOrderDetailType;
    }
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 1.0)];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, 1.0)];
    footerView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    return footerView;
}

#pragma mark - OrderListViewModelDelegate
/** 获取订单列表成功 */
- (void)requestOrderListSuccessWithPageNumber:(NSInteger)pageNumber orderArray:(NSArray *)orderArray{
    if (pageNumber == 1) {
        [self.dataArray removeAllObjects];
    }
    if (orderArray.count > 0) {
        self.pageNum ++;
    }
    NSArray *orderListFrames = [self orderListFramesWithModelArray:orderArray];
    [self.dataArray addObjectsFromArray:orderListFrames];
    [self endRef];
    if (self.dataArray.count == 0) {
        [self.view configBlankPage:EaseBlankPageTypeNoOrderList hasData:self.dataArray.count hasError:NO reloadButtonBlock:^(id sender) {
        }];
    }
}

- (NSArray *)orderListFramesWithModelArray:(NSArray *)orderListModelArray
{
    NSMutableArray *orderListFrames = [NSMutableArray array];
    for (OrderListModel *orderListModel in orderListModelArray) {
        ZTMXFOrderListFrame *orderListFrame = [[ZTMXFOrderListFrame alloc] init];
        orderListFrame.orderListModel = orderListModel;
        [orderListFrames addObject:orderListFrame];
    }
    return orderListFrames;;
}



/** 取消订单成功 */
- (void)requestCancelOrderSuccess{
    self.pageNum = 1;
    [self loadOrderListData];
}
/** 确认收货成功 */
- (void)requestOrderConfirmReceiveSuccess{
    self.pageNum = 1;
    [self loadOrderListData];
}
/** 获取订单列表失败 */
- (void)requestOrderListFailure{
    //    [self endupRefresh];
    [self endRef];
    
}
#pragma mark - 订单按钮点击事件
/** 去付款 */
- (void)orderListViewClickPay:(OrderListModel *)orderListModel{
    NSLog(@"去付款");
    if (orderListModel.orderType == 2) {
        //  商城分期
        LSPaymentOrderViewController *paymentOrderVC = [[LSPaymentOrderViewController alloc] init];
        paymentOrderVC.orderId = [NSString stringWithFormat:@"%ld", orderListModel.orderId];
        paymentOrderVC.totalAmount = [NSString stringWithFormat:@"%.2f",orderListModel.totalAmount];
        [self.navigationController pushViewController:paymentOrderVC animated:YES];
    } else if (orderListModel.orderType == 3) {
        //  手机充值
    }
}
/** 取消订单 */
- (void)orderListViewClickCancelOrder:(OrderListModel *)orderListModel{
    NSLog(@"取消订单");
    [CancelOrderAlertView showAlertViewWithTitle:@"确认取消该订单?" GoodsInfo:orderListModel.goodsInfo Cancel:@"取消订单" Click:^{
        [self.orderListViewModel requestCancelOrderWithOrderId:[NSString stringWithFormat:@"%ld",orderListModel.orderId]];
    } OtherButton:@"继续付款" Click:^{
    }];
}
/** 申请退款 */
- (void)orderListViewClickApplyRefund:(OrderListModel *)orderListModel{
    NSLog(@"申请退款");
    ZTMXFLSApplyRefundViewController *applyRefundVC = [[ZTMXFLSApplyRefundViewController alloc] init];
    applyRefundVC.orderId = [NSString stringWithFormat:@"%ld",orderListModel.orderId];
    [self.navigationController pushViewController:applyRefundVC animated:YES];
}
/** 查看退款详情 */
- (void)orderListViewClickViewRefundDetail:(OrderListModel *)orderListModel{
    /** 售后状态：分期商城 退款状态： 1:退款成功 2: 退款失败 3:退款中 5:审核中 默认为0 */
    NSInteger refundStatus = orderListModel.afterSaleStatus;
    if (refundStatus == 1 || refundStatus == 2 || refundStatus == 3 || refundStatus == 5) {
        ZTMXFLSRefundDetailViewController *refundDetailVC = [[ZTMXFLSRefundDetailViewController alloc] init];
        refundDetailVC.orderId = [NSString stringWithFormat:@"%ld", orderListModel.orderId];
        [self.navigationController pushViewController:refundDetailVC animated:YES];
    }
}
/** 确认收货 */
- (void)orderListViewClickConfirmReceive:(OrderListModel *)orderListModel{
    NSLog(@"确认收货");
    [CancelOrderAlertView showAlertViewWithTitle:@"确认已收到以下商品?" GoodsInfo:orderListModel.goodsInfo Cancel:@"取消" Click:^{
    } OtherButton:@"确认收货" Click:^{
        [self.orderListViewModel requestOrderConfirmReceiveWithOrderId:[NSString stringWithFormat:@"%ld",orderListModel.orderId]];
    }];
}
/** 查看物流 */
- (void)orderListViewClickViewLogistics:(OrderListModel *)orderListModel{
    NSLog(@"查看物流");
    YWLTLogisticsInfoViewController *logisticsInfoVC = [[YWLTLogisticsInfoViewController alloc] init];
    NSString *type = @"0";
    if (orderListModel.orderType == 1) {
        type = @"1";
    }else if (orderListModel.orderType == 2) {
        
    }
    logisticsInfoVC.type = type;
    logisticsInfoVC.orderId = [NSString stringWithFormat:@"%ld",orderListModel.orderId];
    [self.navigationController pushViewController:logisticsInfoVC animated:YES];
}
/** 填写地址 */
- (void)orderListViewClickWriteAddress:(OrderListModel *)orderListModel{
    
//    ChooseAddressViewController
    LSAddressManagerViewController *choiseAddressVC = [[LSAddressManagerViewController alloc] init];
    @WeakObj(self);
    choiseAddressVC.clickCell = ^(LSAddressModel *addressModel) {
        [selfWeak chooseAddress:addressModel];
    };
//    choiseAddressVC.delegete = self;
    choiseAddressVC.orderId = [NSString stringWithFormat:@"%ld",orderListModel.orderId];
    [self.navigationController pushViewController:choiseAddressVC animated:YES];
}
/** 重新购买 */
- (void)orderListViewClickViewRepayMobile:(OrderListModel *)orderListModel{
    ZTMXFMobileRechargeController *mobileVC = [[ZTMXFMobileRechargeController alloc] init];
    [self.navigationController pushViewController:mobileVC animated:YES];
}

- (void)chooseAddress:(LSAddressModel *)addressModel{
    NSLog(@"选中了地址");
    [self refData];
}

#pragma mark - 私有方法

- (void)moreData
{
    [self loadOrderListData];
}
////  下拉刷新数据

- (void)refData
{
    self.pageNum = 1;
    [self loadOrderListData];
}


//  加载订单列表
- (void)loadOrderListData{
    BOOL showLoad = YES;
    if (self.dataArray.count > 0) {
        showLoad = NO;
    }
    [self.orderListViewModel requestOrderListWithPageNumber:self.pageNum showLoading:showLoad];
}

// 结束刷新
//- (void)endupRefresh{
//    if (self.tableView.mj_header.isRefreshing) {
//        [self.tableView.mj_header endRefreshing];
//    }
//    if (self.tableView.mj_footer.isRefreshing) {
//        [self.tableView.mj_footer endRefreshing];
//    }
//}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, k_Navigation_Bar_Height, KW, KH - k_Navigation_Bar_Height);
    self.tableView.backgroundColor = K_LineColor;
}

#pragma mark - getters and setters
//- (UITableView *)tableView{
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height - TabBar_Addition_Height) style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.showsVerticalScrollIndicator = NO;
//
//        //  下拉刷新
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNewData)];
//        //  上拉加载
//        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    }
//    return _tableView;
//}

//- (NSMutableArray *)dataArray{
//    if (_dataArray == nil) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}

- (ZTMXFOrderListViewModel *)orderListViewModel{
    if (_orderListViewModel == nil) {
        _orderListViewModel = [[ZTMXFOrderListViewModel alloc] init];
        _orderListViewModel.delegate = self;
    }
    return _orderListViewModel;
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
