//
//  LSAddressManagerViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAddressManagerViewController.h"
#import "MyAddressCell.h"
#import "LSModifyAddressViewController.h"
#import "LSAddressModel.h"
#import "MyAddressListApi.h"
#import "MyAddressViewModel.h"


#define IdentifierCell @"MyAddressCell"

@interface LSAddressManagerViewController () <UITableViewDataSource,UITableViewDelegate,MyAddressDelegate,UIAlertViewDelegate,LSAddressViewModelDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIButton *addAddressButton;

@property (nonatomic, strong) NSIndexPath *deleteIndexPath;

@property (nonatomic, strong) UIButton *defaultAddressBtn;// 默认地址

@property (nonatomic, strong) NSMutableArray *addressArray;// 地址信息数组

/** current page */
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) MyAddressViewModel *myAddressViewModel;

/** 选择的地址 */
@property (nonatomic, strong) LSAddressModel *chooseAddressModel;

/** 删除的个数 */
@property (nonatomic, assign) NSInteger deleteCount;

@end

@implementation LSAddressManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    self.title = @"地址管理";
//    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"地址管理"];
//    [self set_Title:titleStr];
//    self.currentPage = 1;
    _addressArray = [NSMutableArray array];
    [self pgy_configueSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self pgy_refData];
}

#pragma mark - MyAddressDelegate
- (void)clickMyAddressBtn:(UIButton *)sender
{
    MyAddressCell *selectedCell = (MyAddressCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:selectedCell];
    LSAddressModel *addressModel = [self.addressArray objectAtIndex:indexPath.section];
    if (sender.tag == 1) {
        sender.selected = !sender.selected;
        NSDictionary *paramsDict = @{@"opera":@"update",@"id":@(addressModel.addressId),@"isDefault":@(sender.selected),@"consignee":addressModel.consignee,@"consigneeMobile":addressModel.consigneeMobile,@"province":addressModel.province,@"city":addressModel.city,@"region":addressModel.region,@"detailAddress":addressModel.detailAddress};
            [self.myAddressViewModel requestModifyAddressDataWithDict:paramsDict];
    }else if (sender.tag == 2){
        // 点击编辑
        LSModifyAddressViewController *modifyAddressVC = [[LSModifyAddressViewController alloc] init];
        modifyAddressVC.addressType = LSModifyAddressType;
        modifyAddressVC.addressModel = addressModel;
        [self.navigationController pushViewController:modifyAddressVC animated:YES];
    }else if (sender.tag == 3){
        MyAddressCell *cell = (MyAddressCell *)sender.superview.superview;
        self.deleteIndexPath = [self.mainTableView indexPathForCell:cell];
        // 点击删除
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认删除该地址吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 点击取消
    }else if (buttonIndex == 1){
        LSAddressModel *addressModel = [self.addressArray objectAtIndex:_deleteIndexPath.section];
        NSDictionary *paramsDict = @{@"opera":@"delete",@"id":@(addressModel.addressId)};
        [self.myAddressViewModel requestModifyAddressDataWithDict:paramsDict];
    }
}

#pragma mark - LSAddressViewModelDelegate
#pragma mark - 获取地址列表成功的回调
-(void)getAddressListSuccess:(NSArray *)addressModelArray{
    [_mainTableView.mj_header endRefreshing];
    [_mainTableView.mj_footer endRefreshing];
    if (_currentPage == 1) {
        [self.addressArray removeAllObjects];
    }
    if (addressModelArray.count > 0) {
        [self.addressArray addObjectsFromArray:addressModelArray];
        [self.mainTableView reloadData];
    }
    if ((self.addressArray.count + _deleteCount) % K_Page_size != 0) {
        [_mainTableView.mj_footer endRefreshingWithNoMoreData];
    }
    _currentPage++;
    //增加无数据展现
    [self.view configBlankPage:EaseBlankPageTypeNoAddressList hasData:self.addressArray.count hasError:NO reloadButtonBlock:^(id sender) {
        [self pgy_clickAddAddressBtn];
    }];
    if (addressModelArray.count == 0) {
        self.addAddressButton.hidden = YES;
        self.addAddressButton.userInteractionEnabled = NO;
    }else{
        self.addAddressButton.hidden = NO;
        self.addAddressButton.userInteractionEnabled = YES;
    }
}

- (void)requestDataFailure
{
    [_mainTableView.mj_header endRefreshing];
    [_mainTableView.mj_footer endRefreshing];

}

#pragma mark - 修改地址成功的回调
-(void)modifyAddressSuccess
{
    // 更新页面
    [self pgy_refData];
    if (_clickCell) {
        _clickCell(_chooseAddressModel);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 删除地址成功的回调
- (void)deleteAddressSuccess
{
    _deleteCount++;//删除成功 数量自增 140版本
    // 点击确认,删除地址
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:_deleteIndexPath.section];
    // 更新数组
    [_addressArray removeObjectAtIndex:_deleteIndexPath.section];
    // 移除cell
    [self.mainTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark - 私有方法
#pragma mark - 点击跳转到添加新地址页面
- (void)pgy_clickAddAddressBtn{
    LSModifyAddressViewController *modifyAddressVC = [[LSModifyAddressViewController alloc] init];
    modifyAddressVC.addressType = LSAddAddressType;
    [self.navigationController pushViewController:modifyAddressVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _addressArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LSAddressModel *addressModel = [_addressArray objectAtIndex:indexPath.section];
    if (addressModel.isDefault == 1) {
        self.defaultAddressBtn = cell.defaultAddressBtn;
    }
    cell.addressModel = addressModel;
    cell.delegete = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LSAddressModel *addressModel = [_addressArray objectAtIndex:indexPath.section];
    self.chooseAddressModel = addressModel;
    if (self.orderId.length > 0) {
        // 绑定订单 // 设置参数
        NSMutableDictionary *paramsDict = [NSMutableDictionary dictionaryWithDictionary:@{@"consignee":addressModel.consignee,@"consigneeMobile":addressModel.consigneeMobile,@"province":addressModel.province,@"city":addressModel.city,@"region":addressModel.region,@"detailAddress":addressModel.detailAddress,@"id":@(addressModel.addressId),@"isDefault":@(addressModel.isDefault),@"opera":@"update",@"orderId":self.orderId}];
        
        [self.myAddressViewModel requestModifyAddressDataWithDict:paramsDict];
    } else {
        if (_clickCell) {
            _clickCell(addressModel);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - 设置子视图
- (void)pgy_configueSubViews{
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.addAddressButton];
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 66 * PX, 0);
        [_mainTableView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.sectionHeaderHeight = 1;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.estimatedRowHeight = 130.0;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        UINib * nib = [UINib nibWithNibName:@"MyAddressCell" bundle:nil];
        [_mainTableView registerNib:nib forCellReuseIdentifier:IdentifierCell];

        @WeakObj(self);
        MJRefreshNormalHeader* headerRefresh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [selfWeak pgy_refData];
        }];
        headerRefresh.lastUpdatedTimeLabel.hidden = YES;
        headerRefresh.stateLabel.hidden = YES;
        _mainTableView.mj_header = headerRefresh;
        
        MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            [selfWeak pgy_moreData];
        }];
        footer.frame = CGRectMake(0, 0, KW, 70);
        [footer setTitle:MJEndText forState:MJRefreshStateNoMoreData];
        footer.stateLabel.font = FONT_LIGHT(14);
        _mainTableView.mj_footer = footer;
    }
    return _mainTableView;
}

- (void)pgy_moreData
{
    [self.myAddressViewModel requestAddressListDataWithPageNum:self.currentPage pageSize:K_Page_size];;

}

- (void)pgy_refData
{
    _currentPage = 1;
    [self.myAddressViewModel requestAddressListDataWithPageNum:self.currentPage pageSize:K_Page_size];;

}

- (UIButton *)addAddressButton{
    if (!_addAddressButton) {
        _addAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addAddressButton setFrame:CGRectMake(20, SCREEN_HEIGHT-66 * PX, SCREEN_WIDTH - 40, 44 * PX)];
        [_addAddressButton setBackgroundColor:K_MainColor];
        [_addAddressButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        [_addAddressButton setTitle:@"添加新地址" forState:UIControlStateNormal];
        [_addAddressButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
        _addAddressButton.layer.cornerRadius = 3;
        [_addAddressButton addTarget:self action:@selector(pgy_clickAddAddressBtn) forControlEvents:UIControlEventTouchUpInside];
        _addAddressButton.layer.cornerRadius = _addAddressButton.height/2;
        _addAddressButton.layer.masksToBounds = YES;
    }
    return _addAddressButton;
}

- (MyAddressViewModel *)myAddressViewModel{
    if (!_myAddressViewModel) {
        _myAddressViewModel = [[MyAddressViewModel alloc] init];
        _myAddressViewModel.delegete = self;
    }
    return _myAddressViewModel;
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
