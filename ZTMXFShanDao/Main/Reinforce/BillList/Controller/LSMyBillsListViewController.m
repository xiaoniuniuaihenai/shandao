//
//  LSMyBillsListViewController.m
//  LSCreditConsume
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSMyBillsListViewController.h"
#import "LSLoanListTopMenu.h"
#import "MyLoanListCell.h"
#import "LSBillListModel.h"
#import "LSRenewDetailViewController.h"
#import "LSBillDetailViewController.h"
#import "MyBillViewModel.h"
#import "LSLoanRepayViewController.h"

@interface LSMyBillsListViewController () <UITableViewDataSource,UITableViewDelegate,LSLoanListTopMenuDelegate,MyLoanListCellDelegete,MyBillViewModelDelegete>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) LSLoanListTopMenu *topMenuView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIView *bottomView;
/** 选中所有按钮 */
@property (nonatomic, strong) UIButton *selectedAllBtn;
/** 立即还款按钮 */
@property (nonatomic, strong) UIButton *nowPayBtn;
/** 未还账单数组 */
@property (nonatomic, strong) NSMutableArray *billListArray;
/** 选中未还账单数组 */
@property (nonatomic, strong) NSMutableArray *selectedBillArray;
/** 历史账单数组 */
@property (nonatomic, strong) NSMutableArray *historyBillListArray;
/** 还款金额 */
@property (nonatomic, copy) NSString *payMoney;
/** 账单类型 */
@property (nonatomic, assign) LSLoanListCellType billType;

@property (nonatomic, strong) MyBillViewModel *billListViewModel;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation LSMyBillsListViewController

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
    
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"我的账单"];
    [self set_Title:titleStr];
    
    [self configueSubViews];
    
    self.currentPage = 1;
    self.payMoney = @"0.0";
    self.billType = LSLoanNotReturnType;
    self.billListArray = [NSMutableArray array];
    self.selectedBillArray = [NSMutableArray array];
    self.historyBillListArray = [NSMutableArray array];
    
    //  请求未出账单
    [self.billListViewModel requestNoPaidBillListDataWithPageNum:self.currentPage];
    //  请求历史账单
    [self.billListViewModel requestHistoryBillListDataWithPageNum:self.currentPage];
}



#pragma mark - 加载更多数据
- (void)loadMoreData{
    self.currentPage += 1;
    if (self.billType == LSLoanNotReturnType) {
        [self.billListViewModel requestNoPaidBillListDataWithPageNum:self.currentPage];
    }else if (self.billType == LSLoanHistoryType){
        [self.billListViewModel requestHistoryBillListDataWithPageNum:self.currentPage];
    }
}
#pragma mark - 加载最新数据
- (void)loadNewData{
    self.currentPage = 1;
    if (self.billType == LSLoanNotReturnType) {
        [self.billListViewModel requestNoPaidBillListDataWithPageNum:self.currentPage];
    }else if (self.billType == LSLoanHistoryType){
        [self.billListViewModel requestHistoryBillListDataWithPageNum:self.currentPage];
    }
}



#pragma mark - MyBillViewModelDelegete
#pragma mark - 获取未还款账单列表
- (void)requestNoPaidBillListSuccess:(NSArray *)noPaidListArray allAmount:(NSString *)amount{
    if (self.currentPage == 1) {
        self.payMoney = @"0.0";
        _billListArray = [NSMutableArray array];
        _selectedBillArray = [NSMutableArray array];
        _mainTableView.mj_header.state = MJRefreshStateIdle;
    }
    if(noPaidListArray.count<10){
        _mainTableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        _mainTableView.mj_footer.state = MJRefreshStateIdle;
    }
    if (amount.length >0) {
        self.amountLabel.text = amount;
        _payMoney = amount;
    }
    if (noPaidListArray.count > 0) {
        [_billListArray addObjectsFromArray:noPaidListArray];
        [_selectedBillArray addObjectsFromArray:noPaidListArray];
    }
    // 默认全选
    [self setPayMoneyButtonStatus];
    
    if (_billListArray.count ==0) {
        [_mainTableView.mj_footer endRefreshing];
        _mainTableView.mj_footer.hidden = YES;
    }
    [_mainTableView reloadData];
}

#pragma mark - 获取历史账单列表
- (void)requestHistoryBillListSuccess:(NSArray *)historyListArray{
    if (self.currentPage == 1) {
        _mainTableView.mj_header.state = MJRefreshStateIdle;
        _historyBillListArray = [NSMutableArray array];
    }
    if (historyListArray.count > 0) {
        [_historyBillListArray addObjectsFromArray:historyListArray];
    }
    
    if (self.billType == LSLoanHistoryType) {
        if(historyListArray.count<10){
            _mainTableView.mj_footer.state = MJRefreshStateNoMoreData;
        }else{
            _mainTableView.mj_footer.state = MJRefreshStateIdle;
        }
        if (_historyBillListArray.count ==0) {
            [_mainTableView.mj_footer endRefreshing];
            _mainTableView.mj_footer.hidden = YES;
        }
        [_mainTableView reloadData];
    }
}

#pragma mark - 请求账单数据失败
- (void)requestNoPaidBillListFailure{
    _mainTableView.mj_header.state = MJRefreshStateIdle;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.billType == LSLoanNotReturnType) {
        return _billListArray.count;
    }else if (self.billType == LSLoanHistoryType){
        return _historyBillListArray.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AdaptedHeight(70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyLoanListCell *cell = [MyLoanListCell cellWithTableView:tableView Type:self.billType];
    if (self.billType == LSLoanNotReturnType) {
        if (_billListArray.count > 0) {
            LSBillListModel *model = [_billListArray objectAtIndex:indexPath.row];
            cell.loanCellType = self.billType;
            cell.billListModel = model;
            cell.delegete = self;
            if ([_selectedBillArray containsObject:model]) {
                cell.selectedBtn.selected = YES;
            }else{
                cell.selectedBtn.selected = NO;
            }
        }
    }else{
        if (_historyBillListArray.count > 0) {
            LSBillListModel *model = [_historyBillListArray objectAtIndex:indexPath.row];
            cell.loanCellType = self.billType;
            cell.billListModel = model;
            cell.delegete = self;
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 跳转到账单详情页
    LSBillListModel *model;
    if (self.billType == LSLoanNotReturnType) {
        model = [_billListArray objectAtIndex:indexPath.row];
    }else if (self.billType == LSLoanHistoryType){
        model = [_historyBillListArray objectAtIndex:indexPath.row];
    }
    LSBillDetailViewController *billDetailVC = [[LSBillDetailViewController alloc] init];
    billDetailVC.billId = model.billId;
    [self.navigationController pushViewController:billDetailVC animated:YES];
}

#pragma mark - LSLoanListTopMenuDelegate
- (void)uploadLoanListDataWithIndex:(NSInteger)index{
    NSLog(@"=======点击按钮 index = %ld",index);
    self.currentPage = 1;
    if (index == 0) {
        // 未出账单
        self.billType = LSLoanNotReturnType;
        self.bottomView.hidden = NO;
        // 请求未出账单
        //        [self.billListViewModel requestNoPaidBillListDataWithPageNum:self.currentPage];
    }else if (index == 1){
        // 切换历史账单
        self.billType = LSLoanHistoryType;
        self.bottomView.hidden = YES;
        // 请求历史账单
        //        [self.billListViewModel requestHistoryBillListDataWithPageNum:self.currentPage];
    }
    _mainTableView.mj_footer.hidden = NO;
    _mainTableView.mj_footer.state = MJRefreshStateIdle;
    [_mainTableView reloadData];
    self.mainTableView.height = SCREEN_HEIGHT-k_Navigation_Bar_Height-(self.billType == LSLoanNotReturnType ? AdaptedHeight(60) : 0);
}

#pragma mark - MyLoanListCellDelegete
- (void)selectedCellButtonClick:(LSBillListModel *)selectedBillModel{
    //1.选中 2.取消选中
    NSInteger index = [_billListArray indexOfObject:selectedBillModel];
    MyLoanListCell *selectedCell = [self.mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if (selectedCell.selectedBtn.selected) {
        // 选中
        for (NSInteger i=0; i<=index; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            MyLoanListCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
            cell.selectedBtn.selected = YES;
            if (![_selectedBillArray containsObject:cell.billListModel]) {
                [_selectedBillArray addObject:cell.billListModel];
                _payMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_payMoney rightString:[NSDecimalNumber stringWithFloatValue:cell.billListModel.billAmount]];
            }
        }
    }else{
        for (NSInteger i=index; i<_billListArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            MyLoanListCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
            cell.selectedBtn.selected = NO;
            if ([_selectedBillArray containsObject:cell.billListModel]) {
                [_selectedBillArray removeObject:cell.billListModel];
                _payMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"-" leftString:_payMoney rightString:[NSDecimalNumber stringWithFloatValue:cell.billListModel.billAmount]];
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
        MyLoanListCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
        cell.selectedBtn.selected = sender.selected;
    }
    _payMoney = @"0.0";
    if (sender.selected) {
        [_selectedBillArray setArray:_billListArray];
        if (_selectedBillArray.count > 0) {
            for (LSBillListModel *billModel in _selectedBillArray) {
                _payMoney = [NSDecimalNumber calculateReturnStringWithOpration:@"+" leftString:_payMoney rightString:[NSDecimalNumber stringWithFloatValue:billModel.billAmount]];
            }
        }
    }else{
        [_selectedBillArray removeAllObjects];
        _selectedBillArray = [NSMutableArray array];
    }
    [self setPayMoneyButtonStatus];
}

#pragma mark - 设置还款按钮的状态
- (void)setPayMoneyButtonStatus{
    if (_selectedBillArray.count > 0) {
        if (_selectedBillArray.count == _billListArray.count) {
            self.selectedAllBtn.selected = YES;
        }else{
            self.selectedAllBtn.selected = NO;
        }
        [self.nowPayBtn setTitle:[NSString stringWithFormat:@"立即还款（¥%@）",_payMoney] forState:UIControlStateNormal];
        [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:COLOR_RED_STR]];
    }else{
        self.selectedAllBtn.selected = NO;
        self.payMoney = @"0";
        [self.nowPayBtn setTitle:@"立即还款" forState:UIControlStateNormal];
        [self.nowPayBtn setBackgroundColor:[UIColor colorWithHexString:@"D8D8D8"]];
    }
}

#pragma mark - 点击立即还款按钮
- (void)nowPayMoneyClick:(UIButton *)sender{
    if (_selectedBillArray.count == 0) {
        return;
    }
    NSMutableString *billIds;
    // 白领贷分期
    LoanType loanType = ConsumeLoanType;
    for (int i=0; i<_selectedBillArray.count; i++) {
        LSBillListModel *billModel = _selectedBillArray[i];
        NSString *billStr = [NSString stringWithFormat:@"%ld",billModel.billId];
        if (i==0) {
            billIds = [[NSMutableString alloc] initWithString:billStr];
            if ([billModel.name isEqualToString:@"消费贷"]) {
                loanType = ConsumeLoanType;
            }else if ([billModel.name isEqualToString:@"现金贷"]){
                loanType = CashLoanType;
            }else if ([billModel.name isEqualToString:@"白领贷"]){
                loanType = WhiteLoanType;
            }
        }else{
            [billIds appendString:[NSString stringWithFormat:@",%@",billStr]];
        }
    }
    LSLoanRepayViewController *loanRepayVC = [[LSLoanRepayViewController alloc] init];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:self.payMoney];
    loanRepayVC.repayAmount = [decNumber doubleValue];
    loanRepayVC.borrowId = billIds;
    loanRepayVC.loanType = loanType;
    [self.navigationController pushViewController:loanRepayVC animated:YES];
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.bottomView];
    self.mainTableView.tableHeaderView = self.topView;
}

#pragma mark - get
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeight(160))];
        _topView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AdaptedHeight(100))];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [_topView addSubview:bgView];
        
        UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"4A4A4A"] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentCenter];
        [titleLabel setFrame:CGRectMake(0, AdaptedHeight(18), SCREEN_WIDTH, AdaptedHeight(20))];
        titleLabel.text = @"应还金额";
        [bgView addSubview:titleLabel];
        
        self.amountLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(36) alignment:NSTextAlignmentCenter];
        [self.amountLabel setFrame:CGRectMake(0, titleLabel.bottom, SCREEN_WIDTH, AdaptedHeight(50))];
        [self.amountLabel setFont:[UIFont boldSystemFontOfSize:AdaptedWidth(36)]];
        self.amountLabel.text = @"0.00";
        [bgView addSubview:self.amountLabel];
        
        self.topMenuView = [[LSLoanListTopMenu alloc] initWithFrame:CGRectMake(0, bgView.bottom+10, SCREEN_WIDTH, AdaptedHeight(50))];
        self.topMenuView.menuList = @[@"未还账单",@"历史账单"];
        self.topMenuView.delegate = self;
        [_topView addSubview:self.topMenuView];
    }
    return _topView;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, SCREEN_HEIGHT-k_Navigation_Bar_Height-AdaptedHeight(60)) style:UITableViewStylePlain];
        [_mainTableView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.sectionHeaderHeight = 1;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        
        __weak typeof(self) weakSelf = self;
        //默认block方法：设置下拉刷新
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
        //默认block方法：设置上拉加载更多
        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //Call this Block When enter the refresh status automatically
            [weakSelf loadMoreData];
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
        [self.selectedAllBtn setImage:[UIImage imageNamed:@"address_normal"] forState:UIControlStateNormal];
        [self.selectedAllBtn setImage:[UIImage imageNamed:@"address_selected"] forState:UIControlStateSelected];
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

#pragma mark - setter
-(MyBillViewModel *)billListViewModel{
    if (!_billListViewModel) {
        _billListViewModel = [[MyBillViewModel alloc] init];
        _billListViewModel.delegete = self;
    }
    return _billListViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
