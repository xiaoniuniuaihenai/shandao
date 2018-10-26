//
//  LSOrderDetailInfoViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLSOrderDetailInfoViewController.h"
#import "ZTMXFOrderDetailHeaderView.h"
#import "ZTMXFOrderDetailStyleOneCell.h"
#import "ZTMXFOrderDetailStyleTwoCell.h"
#import "ZTMXFOrderDetailBottomView.h"
#import "ZTMXFLSApplyRefundViewController.h"
#import "ZTMXFLSRefundDetailViewController.h"
#import "LSPaymentOrderViewController.h"
#import "YWLTLogisticsInfoViewController.h"
#import "ShanDaoChooseAddressViewController.h"
#import "LSGoodsDetailViewController.h"
#import "CancelOrderAlertView.h"
#import "RepaymentPlanAlertView.h"

#import "ZTMXFOrderDetailInfoViewModel.h"
#import "OrderDetailInfoModel.h"
#import "ZTMXFOrderDetailInfoManager.h"
#import "ZTMXFOrderListViewModel.h"
#import "MyOrderModel.h"
#import "OrderGoodsInfoModel.h"
#import "ZTMXFMobileRechargeController.h"


#import "LSAddressManagerViewController.h"


@interface ZTMXFLSOrderDetailInfoViewController ()<UITableViewDelegate, UITableViewDataSource, OrderDetailHeaderViewDelegate, OrderDetailInfoViewModelDelegate, OrderDetailBottomViewDelegate, OrderListViewModelDelegate, ChooseAddressProtocol, OrderDetailStyleOneCellDelegate>
/** tableView */
@property (nonatomic, strong) UITableView           *tableView;
/** header View */
@property (nonatomic, strong) ZTMXFOrderDetailHeaderView *orderHeaderView;
/** bottom View */
@property (nonatomic, strong) ZTMXFOrderDetailBottomView *bottomView;
/** data Array */
@property (nonatomic, strong) NSMutableArray        *dataArray;
/** ViewModel */
@property (nonatomic, strong) ZTMXFOrderDetailInfoViewModel *orderDetailInfoViewModel;
@property (nonatomic, strong) ZTMXFOrderListViewModel       *orderListViewModel;

/** 商城订单model */
@property (nonatomic, strong) OrderDetailInfoModel *orderDetailInfoModel;
/** 消费贷订单Model */
@property (nonatomic, strong) MyOrderDetailModel *loanOrderDetailModel;

@end

@implementation ZTMXFLSOrderDetailInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    
    [self configueSubViews];
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
    if (indexPath.section == 0) {
        return AdaptedHeight(50.0);
    } else {
        return AdaptedHeight(30.0);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionArray = self.dataArray[indexPath.section];
    NSDictionary *cellDict = sectionArray[indexPath.row];
    NSString *titleString = cellDict[kTitleValueCellManagerKey];
    NSString *valueString = cellDict[kTitleValueCellManagerValue];
    if (indexPath.section == 0) {
        ZTMXFOrderDetailStyleOneCell *cell = [ZTMXFOrderDetailStyleOneCell cellWithTableView:tableView];
        cell.titleLabel.text = titleString;
        cell.valueLabel.text = valueString;
        cell.delegate = self;
        
        //  设置分期数显示icon
        if ([titleString isEqualToString:kOrderNperCount]) {
            [cell showValueButton:YES];
        } else {
            [cell showValueButton:NO];
        }
        //  订单总额上面显示箭头
        if (indexPath.row == (sectionArray.count - 2)) {
            cell.topRowImageView.hidden = NO;
            [cell showLineLeftMargin:0.0];
        } else {
            cell.topRowImageView.hidden = YES;
            [cell showLineLeftMargin:AdaptedWidth(12.0)];
        }
        //  设置订单总额字体颜色
        if ([titleString isEqualToString:kOrderTotalAmount]) {
            cell.valueLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
            cell.valueLabel.font = [UIFont boldSystemFontOfSize:17];
        } else {
            cell.valueLabel.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
            cell.valueLabel.font = [UIFont systemFontOfSize:15];
        }
        return cell;
    } else {
        ZTMXFOrderDetailStyleTwoCell *cell = [ZTMXFOrderDetailStyleTwoCell cellWithTableView:tableView];
        cell.titleLabel.text = titleString;
        cell.valueLabel.text = valueString;
        if ([titleString isEqualToString:kOrderNumber]) {
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
    if (section == 1) {
        return 10.0;
    }
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

#pragma mark - 自定义代理方法
#pragma mark cell代理方法
/** 点击ValueButton */
- (void)orderDetailStyleOneCellClickValueButtonAction{
    //  查看分期信息弹窗
    RepaymentPlanAlertView * repayView = [[RepaymentPlanAlertView alloc] initWithArrData:self.orderDetailInfoModel.stageList];
    [repayView showAlertView];
}

#pragma mark OrderDetailHeaderViewDelegate
//  查看退款详情
- (void)orderDetailHeaderViewRefundDetail{
    if (self.orderDetailInfoModel.status == 3) {
        //  代发货状态下才有退款状态
        /** 售后状态：分期商城 退款状态： 1:退款成功 2: 退款失败 3:退款中 5:审核中 默认为0 */
        NSInteger refundStatus = self.orderDetailInfoModel.afterSaleStatus;
        if (refundStatus == 1 || refundStatus == 2 || refundStatus == 3 || refundStatus == 5) {
            ZTMXFLSRefundDetailViewController *refundDetailVC = [[ZTMXFLSRefundDetailViewController alloc] init];
            refundDetailVC.orderId = self.orderId;
            [self.navigationController pushViewController:refundDetailVC animated:YES];
        }
    }
}

/** 添加地址 */
- (void)orderDetailHeaderViewAddAddress{
//    ChooseAddressViewController
     LSAddressManagerViewController*choiseAddressVC = [[LSAddressManagerViewController alloc] init];
//    choiseAddressVC.delegete = self;
    @WeakObj(self);
    choiseAddressVC.clickCell = ^(LSAddressModel *addressModel) {
        [selfWeak chooseAddress:addressModel];
    };
    choiseAddressVC.orderId = self.orderId;
    [self.navigationController pushViewController:choiseAddressVC animated:YES];
}

/** 查看商品详情 */
- (void)orderDetailHeaderViewGoodsDetail{
    if (_orderDetailType == MallOrderDetailType) {
        //  商城订单
        long goodsId = self.orderDetailInfoModel.goodsInfo.goodsId;
        if (goodsId > 0) {
            LSGoodsDetailViewController *goodsDetailVC = [[LSGoodsDetailViewController alloc] init];
            goodsDetailVC.goodsId = [NSString stringWithFormat:@"%ld", goodsId];
            [self.navigationController pushViewController:goodsDetailVC animated:YES];
        }
    } else if (_orderDetailType == ConsumeLoanOrderDetailType) {
        //  消费贷订单,查看商品详情
        if (self.loanOrderDetailModel.descUrl.length > 0) {
            LSWebViewController *webVC = [[LSWebViewController alloc] init];
            webVC.webUrlStr = self.loanOrderDetailModel.descUrl;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
}

#pragma mark ChooseAddressProtocol
- (void)chooseAddress:(LSAddressModel *)addressModel{
    NSLog(@"选中的地址");
}

#pragma mark 获取订单详情信息成功
/** 获取商城订单信息成功 */
- (void)requestMallOrderDetailInfoSuccess:(OrderDetailInfoModel *)orderDetailInfoModel{
    if (orderDetailInfoModel) {
        self.orderDetailInfoModel = orderDetailInfoModel;
        self.orderHeaderView.orderDetailInfoModel = self.orderDetailInfoModel;
        OrderType orderType = MallOrderType;
        if (self.orderDetailType == MobileLoanOrderDetailType) {
            //  手机充值
            self.orderHeaderView.isHiddenAddressView = YES;
            orderType = MobileOrderType;
        }
        
        NSArray *orderDetailArray = [ZTMXFOrderDetailInfoManager orderDetailArrayFromDetailInfoModel:self.orderDetailInfoModel];
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        if (orderDetailArray.count > 0) {
            [self.dataArray addObjectsFromArray:orderDetailArray];
            [self.tableView reloadData];
        }
        
        //  底部显示按钮
        NSArray *titleArray = [ZTMXFOrderDetailInfoManager buttonTitleArrayFromeStatus:self.orderDetailInfoModel.status refundStatus:self.orderDetailInfoModel.afterSaleStatus orderType:orderType];
        //  商城订单底部不显示查看退款详情, 上面显示, 这里要移除这个按钮
        if ([titleArray containsObject:kOrderButtonCheckRefundDetail]) {
            NSMutableArray *filterArray = [NSMutableArray array];
            for (NSString *title in titleArray) {
                if (![title isEqualToString:kOrderButtonCheckRefundDetail]) {
                    [filterArray addObject:title];
                }
            }
            self.bottomView.titleArray = filterArray;
        } else {
            self.bottomView.titleArray = titleArray;
        }
    }
}

/** 获取消费贷订单信息成功 */
- (void)requestConsumeLoanOrderDetailInfoSuccess:(MyOrderDetailModel *)orderDetailInfoModel{
    if (orderDetailInfoModel) {
        self.loanOrderDetailModel = orderDetailInfoModel;
     
        self.orderHeaderView.loanOrderDetailModel = self.loanOrderDetailModel;

        NSArray *orderDetailArray = [ZTMXFOrderDetailInfoManager consumeLoanOrderDetailArrayFromDetailInfoModel:self.loanOrderDetailModel];
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        if (orderDetailArray.count > 0) {
            [self.dataArray addObjectsFromArray:orderDetailArray];
            [self.tableView reloadData];
        }

        //  消费贷订单底部不显示查看填写地址按钮, 上面显示, 这里要移除这个按钮
        //  底部显示按钮
        NSArray *titleArray = [ZTMXFOrderDetailInfoManager buttonTitleArrayFromeStatus:self.loanOrderDetailModel.orderStatus refundStatus:0 orderType:ConsumeLoanOrderType];
        if ([titleArray containsObject:kOrderButtonWriteAddress]) {
            NSMutableArray *filterArray = [NSMutableArray array];
            for (NSString *title in titleArray) {
                if (![title isEqualToString:kOrderButtonWriteAddress]) {
                    [filterArray addObject:title];
                }
            }
            self.bottomView.titleArray = filterArray;
        } else {
            self.bottomView.titleArray = titleArray;
        }
    }
}

#pragma mark OrderListViewModelDelegate(取消订单, 确认收货)
/** 取消订单成功 */
- (void)requestCancelOrderSuccess{
    [self loadOrderDetailInfoData];
}
/** 确认收货成功 */
- (void)requestOrderConfirmReceiveSuccess{
    [self loadOrderDetailInfoData];
}

#pragma mark - 订单按钮点击事件
/** 去付款 */
- (void)orderDetailBottomViewClickPay{
    if (self.orderDetailType == MallOrderDetailType) {
        //  商城分期
        LSPaymentOrderViewController *paymentOrderVC = [[LSPaymentOrderViewController alloc] init];
        paymentOrderVC.orderId = [NSString stringWithFormat:@"%ld", self.orderDetailInfoModel.orderId];
        paymentOrderVC.totalAmount = [NSString stringWithFormat:@"%.2f",self.orderDetailInfoModel.totalAmount];
        [self.navigationController pushViewController:paymentOrderVC animated:YES];
    } else if (self.orderDetailType == MobileLoanOrderDetailType) {
        
    }
}
/** 取消订单 */
- (void)orderDetailBottomViewClickCancelOrder{
    [CancelOrderAlertView showAlertViewWithTitle:@"确认取消该订单?" GoodsInfo:self.orderDetailInfoModel.goodsInfo Cancel:@"取消订单" Click:^{
        [self.orderListViewModel requestCancelOrderWithOrderId:self.orderId];
    } OtherButton:@"继续付款" Click:^{
    }];
}
/** 申请退款 */
- (void)orderDetailBottomViewClickApplyRefund{
    ZTMXFLSApplyRefundViewController *applyRefundVC = [[ZTMXFLSApplyRefundViewController alloc] init];
    applyRefundVC.orderId = [NSString stringWithFormat:@"%ld",self.orderDetailInfoModel.orderId];
    [self.navigationController pushViewController:applyRefundVC animated:YES];
}
/** 确认收货 */
- (void)orderDetailBottomViewClickConfirmReceive{
    [CancelOrderAlertView showAlertViewWithTitle:@"确认已收到以下商品?" GoodsInfo:self.orderDetailInfoModel.goodsInfo Cancel:@"取消" Click:^{
    } OtherButton:@"确认收货" Click:^{
        [self.orderListViewModel requestOrderConfirmReceiveWithOrderId:self.orderId];
    }];
}
/** 查看物流 */
- (void)orderDetailBottomViewClickViewLogistics{
    NSString *orderId;
    NSString *type = @"0";
    if (_orderDetailType == MallOrderDetailType) {
        //  商城订单
        orderId = [NSString stringWithFormat:@"%ld",self.orderDetailInfoModel.orderId];
    } else if (_orderDetailType == ConsumeLoanOrderDetailType) {
        //  消费贷订单
        orderId = self.orderId;
        type = @"1";
    }
    YWLTLogisticsInfoViewController *logisticsInfoVC = [[YWLTLogisticsInfoViewController alloc] init];
    logisticsInfoVC.orderId = orderId;
    logisticsInfoVC.type = type;
    [self.navigationController pushViewController:logisticsInfoVC animated:YES];
}
/** 重新购买 */
- (void)orderDetailBottomViewClickViewRepay{
    //  跳转到手机充值
    ZTMXFMobileRechargeController *mobileVC = [[ZTMXFMobileRechargeController alloc] init];
    [self.navigationController pushViewController:mobileVC animated:YES];
}

#pragma mark - 私有方法
//  加载详情信息
- (void)loadOrderDetailInfoData{
    BOOL showLoad = YES;
    if (self.orderDetailInfoModel) {
        showLoad = NO;
    }
    
    if (self.orderDetailType == ConsumeLoanOrderDetailType) {
        //  消费贷订单详情
        [self.orderDetailInfoViewModel requestConsumeLoanOrderDetailInfoWithOrderId:self.orderId showLoading:showLoad];
    } else {
        //  商城订单详情
        [self.orderDetailInfoViewModel requestMallOrderDetailInfoWithOrderId:self.orderId showLoading:showLoad];
    }
}

#pragma mark - Configue SubViews(添加子视图)
//  添加子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.orderHeaderView;
    [self.view addSubview:self.bottomView];
}


#pragma mark - getters and setters
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, Main_Screen_Width, Main_Screen_Height - TabBar_Addition_Height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, AdaptedHeight(50.0), 0.0);
    }
    return _tableView;
}

- (ZTMXFOrderDetailHeaderView *)orderHeaderView{
    if (_orderHeaderView == nil) {
        _orderHeaderView = [[ZTMXFOrderDetailHeaderView alloc] init];
        _orderHeaderView.delegate = self;
        _orderHeaderView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, AdaptedHeight(260.0));
    }
    return _orderHeaderView;
}

- (ZTMXFOrderDetailBottomView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[ZTMXFOrderDetailBottomView alloc] init];
        _bottomView.delegate = self;
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.frame = CGRectMake(0.0, Main_Screen_Height - TabBar_Addition_Height - AdaptedHeight(50.0), Main_Screen_Width, AdaptedHeight(50.0));
    }
    return _bottomView;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (ZTMXFOrderDetailInfoViewModel *)orderDetailInfoViewModel{
    if (_orderDetailInfoViewModel == nil) {
        _orderDetailInfoViewModel = [[ZTMXFOrderDetailInfoViewModel alloc] init];
        _orderDetailInfoViewModel.delegate = self;
    }
    return _orderDetailInfoViewModel;
}

- (ZTMXFOrderListViewModel *)orderListViewModel{
    if (_orderListViewModel == nil) {
        _orderListViewModel = [[ZTMXFOrderListViewModel alloc] init];
        _orderListViewModel.delegate = self;
    }
    return _orderListViewModel;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadOrderDetailInfoData];
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
