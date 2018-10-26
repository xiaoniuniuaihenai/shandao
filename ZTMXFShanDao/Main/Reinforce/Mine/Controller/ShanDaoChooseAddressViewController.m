//
//  ShanDaoChooseAddressViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ShanDaoChooseAddressViewController.h"
#import "LSAddressManagerViewController.h"
#import "LSAddressModel.h"
#import "MyAddressViewModel.h"
#import "ChooseMyAddressCell.h"

#define IdentifierCell @"ChooseMyAddressCell"

@interface ShanDaoChooseAddressViewController ()<UITableViewDataSource,UITableViewDelegate,LSAddressViewModelDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *addressArray;// 地址信息数组

/** current page */
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) MyAddressViewModel *myAddressViewModel;

/** 选择的地址 */
@property (nonatomic, strong) LSAddressModel *chooseAddressModel;

@end

@implementation ShanDaoChooseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc]initWithString:@"选择收货地址"];
    [self set_Title:titleStr];
    [self setNavgationBarRightTitle:@"管理"];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    
    [self configueSubViews];
    
    self.currentPage = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 刷新数据
    [self.myAddressViewModel requestAddressListDataWithPageNum:self.currentPage pageSize:10];
}

#pragma mark - LSAddressViewModelDelegate
#pragma mark - 获取地址列表成功的回调
-(void)getAddressListSuccess:(NSArray *)addressModelArray{
    _addressArray = [NSMutableArray array];
    if (addressModelArray.count > 0) {
        [self.addressArray addObjectsFromArray:addressModelArray];
        [self.mainTableView reloadData];
    }
    //增加无数据展现
    [self.view configBlankPage:EaseBlankPageTypeNoAddressList hasData:self.addressArray.count hasError:NO reloadButtonBlock:^(id sender) {
    }];
}

#pragma mark - 修改地址成功的回调
- (void)modifyAddressSuccess{
    //
    if (self.delegete && [self.delegete respondsToSelector:@selector(chooseAddress:)]) {
        
        [self.delegete chooseAddress:self.chooseAddressModel];
        
        // 跳回到订单页
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark - 点击右边按钮
- (void)right_button_event:(UIButton *)sender{
    
    LSAddressManagerViewController *addressManagerVC = [[LSAddressManagerViewController alloc] init];
    [self.navigationController pushViewController:addressManagerVC animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChooseMyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    LSAddressModel *addressModel = [_addressArray objectAtIndex:indexPath.section];
    cell.addressModel = addressModel;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    LSAddressModel *addressModel = [_addressArray objectAtIndex:indexPath.section];
    self.chooseAddressModel = addressModel;
    if (self.orderId.length > 0) {
        // 绑定订单
        // 设置参数
        NSMutableDictionary *paramsDict = [NSMutableDictionary dictionaryWithDictionary:@{@"consignee":addressModel.consignee,@"consigneeMobile":addressModel.consigneeMobile,@"province":addressModel.province,@"city":addressModel.city,@"region":addressModel.region,@"detailAddress":addressModel.detailAddress,@"id":@(addressModel.addressId),@"isDefault":@(addressModel.isDefault),@"opera":@"update",@"orderId":self.orderId}];
        
        [self.myAddressViewModel requestModifyAddressDataWithDict:paramsDict];
    } else {
        if (self.delegete && [self.delegete respondsToSelector:@selector(chooseAddress:)]) {
            
            [self.delegete chooseAddress:self.chooseAddressModel];
            // 跳回到订单页
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.mainTableView];
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        [_mainTableView setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.sectionHeaderHeight = 1;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        
        _mainTableView.estimatedRowHeight = 85.0;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        
        UINib * nib = [UINib nibWithNibName:@"ChooseMyAddressCell" bundle:nil];
        [_mainTableView registerNib:nib forCellReuseIdentifier:IdentifierCell];
    
    }
    return _mainTableView;
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

@end
