//
//  LSWhiteLoanDetailViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSWhiteLoanDetailViewController.h"
#import "LSBillListModel.h"
#import "LSWhiteLoanDetailCell.h"
#import "LSPeriodDetaiCell.h"
#import "LSBillDetailViewController.h"
#import "LSLoanRepayViewController.h"
#import "ALABorrowDetailManager.h"
#import "LSLoanDetailModel.h"
#import "WhiteLoanInfoModel.h"
#import "MyBillViewModel.h"
#import "MallBillInfoModel.h"
#import "AlertSheetActionManager.h"
#import "LSPeriodDetailAlertView.h"

@interface LSWhiteLoanDetailViewController () <UITableViewDataSource,UITableViewDelegate,PeriodLoanDetailCellDelegete,MyBillViewModelDelegete>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *bottomView;
/** 选中所有按钮 */
@property (nonatomic, strong) UIButton *selectedAllBtn;
/** 立即还款按钮 */
@property (nonatomic, strong) UIButton *nowPayBtn;

/** 账单明细数组 */
@property (nonatomic, strong) NSMutableArray *periodDetailArray;
/** 分期账单数组 */
@property (nonatomic, strong) NSMutableArray *periodBillListArray;
/** 选中账单数组 */
@property (nonatomic, strong) NSMutableArray *periodSelectedBillArray;
/** 应还账单金额 */
@property (nonatomic, copy) NSString *payMoney;

/** 待还款账单个数 */
@property (nonatomic, assign) NSInteger waitPayNum;

/** 借钱ViewModel */
@property (nonatomic, strong) MyBillViewModel *billListViewModel;
/** 借钱详情Model */
@property (nonatomic, strong) WhiteLoanInfoModel *whiteLoanInfoModel;

/** 账单详情弹窗 */
@property (nonatomic, strong) LSPeriodDetailAlertView *periodAlertView;

@end

@implementation LSWhiteLoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"账单详情"];
    [self set_Title:titleStr];
    
    [self configueSubViews];
    
    _payMoney = @"0.00";
    _waitPayNum = 0;
    _periodDetailArray = [NSMutableArray array];
    _periodBillListArray = [NSMutableArray array];
    _periodSelectedBillArray = [NSMutableArray array];
    
    [self.billListViewModel reuestWhiteLoanDetailInfoWithBorrowId:self.borrowId];
    
    //  借钱数据状态变更 刷新页面数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadLoanInfoData) name:kNotRefreshBorrowMoneyPage object:nil];
}



#pragma mark - 加载最新数据
- (void)loadNewData{
    [self.billListViewModel reuestWhiteLoanDetailInfoWithBorrowId:self.borrowId];
}

#pragma mark - MyBillViewModelDelegete
- (void)requestWhiteLoanDetailInfoSuccess:(WhiteLoanInfoModel *)whiteLoanInfoModel
{
    _whiteLoanInfoModel = whiteLoanInfoModel;
    self.mainTableView.mj_header.state = MJRefreshStateIdle;
    if (_whiteLoanInfoModel) {
        
        _periodDetailArray = [ALABorrowDetailManager managerPeriodDetailModel:whiteLoanInfoModel];
        
        [_periodBillListArray setArray:_whiteLoanInfoModel.billList];
        
        _payMoney = @"0.00";
        _waitPayNum = 0;
        for (int i=0; i<_periodBillListArray.count; i++) {
            MallBillListModel *billModel = _periodBillListArray[i];
            if (billModel.status == 0) {
                _waitPayNum += 1;
            }
        }
        //  没有待还款的账单
        if (self.waitPayNum == 0) {
            self.bottomView.hidden = YES;
            self.mainTableView.frame = CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height);
        } else {
            self.bottomView.hidden = NO;
            self.mainTableView.frame = CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height-AdaptedHeight(60));
        }
        
        [_mainTableView reloadData];
        
        [_periodSelectedBillArray removeAllObjects];
        // 设置状态
        [self setPayMoneyButtonStatus];
    }
}
#pragma mark - 刷新页面
- (void)loadLoanInfoData
{
    [self.billListViewModel reuestWhiteLoanDetailInfoWithBorrowId:self.borrowId];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return _periodDetailArray.count;
    }
    return _periodBillListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return AdaptedHeight(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }
    return 10.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        // 账单详情cell
        LSWhiteLoanDetailCell *cell = [LSWhiteLoanDetailCell cellWithTableView:tableView];
        NSDictionary *cellDict = self.periodDetailArray[indexPath.row];
        cell.loanDetailDict = cellDict;
        
        return cell;
    } else {
        // 分期cell
        LSPeriodDetaiCell *cell = [LSPeriodDetaiCell cellWithTableView:tableView];
        if (_periodBillListArray.count >0) {
            MallBillListModel *model = [_periodBillListArray objectAtIndex:indexPath.row];
            cell.mallBillModel = model;
            cell.delegete = self;
            if ([_periodSelectedBillArray containsObject:model]) {
                cell.selectedBtn.selected = YES;
            } else {
                cell.selectedBtn.selected = NO;
            }
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        LSWhiteLoanDetailCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([cell.titleLabel.text isEqualToString:@"借款编号"]) {
            NSString *borrowAmount = [NSString stringWithFormat:@"%.2f",self.whiteLoanInfoModel.amount];
            // 借款id
            NSString *borrowId = [NSString stringWithFormat:@"%ld",self.whiteLoanInfoModel.rid];
            NSArray * arrActionTitle = @[@"《闪到借款协议》",@"《委托融资协议》"];
            MJWeakSelf
            [AlertSheetActionManager sheetActionTitle:@"协议" message:nil arrTitleAction:arrActionTitle superVc:self blockClick:^(NSInteger index) {
                NSString * webUrl = @"";
                if (index==0) {
                    webUrl = DefineUrlString(personalWhiteCashProtocol([LoginManager userPhone],borrowId, borrowAmount,@""));
                }else{
                    webUrl = DefineUrlString(entrustBorrowCashProtocol(borrowId,borrowAmount,@"3"));
                }
                LSWebViewController *borrowNumVC = [[LSWebViewController alloc] init];
                borrowNumVC.webUrlStr = webUrl;
                [weakSelf.navigationController pushViewController:borrowNumVC animated:YES];
            }];
        }
    } else {
        // 弹框提示详情页
        MallBillListModel *model = [_periodBillListArray objectAtIndex:indexPath.row];
        self.periodAlertView.mallListModel = model;
        [self.periodAlertView show];
    }
}

#pragma mark - PeriodLoanDetailCellDelegete
- (void)selectedCellButtonClick:(MallBillListModel *)selectedBillModel{
    //1.选中 2.取消选中
    NSInteger index = [_periodBillListArray indexOfObject:selectedBillModel];
    LSPeriodDetaiCell *selectedCell = [self.mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:1]];
    if (selectedCell.selectedBtn.selected) {
        // 选中
        for (NSInteger i=0; i<=index; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
            LSPeriodDetaiCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
            if (cell.mallBillModel.status == 0) {
                // 待还款才选中
                cell.selectedBtn.selected = YES;
                if (![_periodSelectedBillArray containsObject:cell.mallBillModel]) {
                    [_periodSelectedBillArray addObject:cell.mallBillModel];
                    _payMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_payMoney rightString:[NSDecimalNumber stringWithFloatValue:cell.mallBillModel.billAmount]];
                }
            }
        }
    }else{
        for (NSInteger i=index; i<_periodBillListArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:1];
            LSPeriodDetaiCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
            cell.selectedBtn.selected = NO;
            if ([_periodSelectedBillArray containsObject:cell.mallBillModel]) {
                [_periodSelectedBillArray removeObject:cell.mallBillModel];
                _payMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:_payMoney rightString:[NSDecimalNumber stringWithFloatValue:cell.mallBillModel.billAmount]];
            }
        }
    }
    // 设置状态
    [self setPayMoneyButtonStatus];
}

#pragma mark -私有方法
#pragma mark - 点击全选按钮
- (void)selectedAllBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    // 获取所有可见cell的索引
    NSArray *cellArr = [self.mainTableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in cellArr) {
        // 第二组
        if (indexPath.section == 1) {
            LSPeriodDetaiCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
            if (cell.mallBillModel.status == 0) {
                // 待还款状态
                cell.selectedBtn.selected = sender.selected;
            }
        }
    }
    //
    _payMoney = @"0.00";
    _periodSelectedBillArray = [NSMutableArray array];
    // 如果全选
    if (sender.selected) {
        for (MallBillListModel *billModel in _periodBillListArray) {
            if (billModel.status == 0) {
                [_periodSelectedBillArray addObject:billModel];
                _payMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_payMoney rightString:[NSDecimalNumber stringWithFloatValue:billModel.billAmount]];
            }
        }
    }
    // 设置还款按钮状态
    [self setPayMoneyButtonStatus];
}

#pragma mark - 设置还款按钮的状态
- (void)setPayMoneyButtonStatus{
    // 应还
    if (_periodSelectedBillArray.count > 0) {
        if (_periodSelectedBillArray.count == _waitPayNum) {
            self.selectedAllBtn.selected = YES;
        }else{
            self.selectedAllBtn.selected = NO;
        }
        [self.nowPayBtn setTitle:[NSString stringWithFormat:@"立即还款（¥%@）",_payMoney] forState:UIControlStateNormal];
        [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:COLOR_RED_STR]];
    }else{
        self.selectedAllBtn.selected = NO;
        self.payMoney = @"0.00";
        [self.nowPayBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:@"D8D8D8"]];
    }
}

#pragma mark - 点击立即还款按钮
- (void)nowPayMoneyClick:(UIButton *)sender{
    
    if (_periodSelectedBillArray.count == 0) {
        return;
    }
    // 白领贷分期
    NSMutableArray *borrowIdAry = [NSMutableArray array];
    for (MallBillListModel *billModel in _periodSelectedBillArray) {
        [borrowIdAry addObject:[NSString stringWithFormat:@"%ld",billModel.rid]];
    }
    NSString *billIds = [borrowIdAry componentsJoinedByString:@","];
    // 跳转到还款页面
    LSLoanRepayViewController *loanRepayVC = [[LSLoanRepayViewController alloc] init];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:self.payMoney];
    loanRepayVC.repayAmount = [decNumber doubleValue];
    loanRepayVC.borrowId = billIds;
    loanRepayVC.loanType = WhiteLoanType;
    [self.navigationController pushViewController:loanRepayVC animated:YES];
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.bottomView];
}

#pragma mark - getter/setter
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height-AdaptedHeight(60)) style:UITableViewStyleGrouped];
        [_mainTableView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.sectionHeaderHeight = 1;
        _mainTableView.sectionFooterHeight = 1;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        
        __weak typeof(self) weakSelf = self;
        //默认block方法：设置下拉刷新
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
    }
    return _mainTableView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-AdaptedHeight(60), SCREEN_WIDTH, AdaptedHeight(60))];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        self.selectedAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectedAllBtn setFrame:CGRectMake(0, 0, AdaptedWidth(135), _bottomView.height)];
        [self.selectedAllBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
        [self.selectedAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self.selectedAllBtn setTitleColor:[UIColor colorWithHexString:@"4A4A4A"] forState:UIControlStateNormal];
        [self.selectedAllBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
        [self.selectedAllBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
        [self.selectedAllBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [self.selectedAllBtn addTarget:self action:@selector(selectedAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.selectedAllBtn];
        
        self.nowPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nowPayBtn setFrame:CGRectMake(_selectedAllBtn.right, 0, SCREEN_WIDTH-_selectedAllBtn.width, _bottomView.height)];
        [self.nowPayBtn.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
        [self.nowPayBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [self.nowPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:@"D8D8D8"]];
        [self.nowPayBtn addTarget:self action:@selector(nowPayMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:self.nowPayBtn];
    }
    return _bottomView;
}

-(MyBillViewModel *)billListViewModel{
    if (!_billListViewModel) {
        _billListViewModel = [[MyBillViewModel alloc] init];
        _billListViewModel.delegete = self;
    }
    return _billListViewModel;
}

- (LSPeriodDetailAlertView *)periodAlertView{
    if (_periodAlertView == nil) {
        _periodAlertView = [[LSPeriodDetailAlertView alloc] initWithFrame:self.view.bounds];
    }
    return _periodAlertView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
