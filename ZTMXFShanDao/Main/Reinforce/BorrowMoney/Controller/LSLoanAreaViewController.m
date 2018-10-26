//
//  LSLoanAreaViewController.m
//  YWLTMeiQiiOS
//
//  Created by panfei mao on 2017/12/7.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanAreaViewController.h"
#import "LSReceivingView.h"
#import "DefaultAddressView.h"
#import "LSLoanSuccessViewController.h"
#import "MyAddressViewModel.h"
#import "ShanDaoChooseAddressViewController.h"
#import "LSAddressModel.h"
#import "LSAddressManagerViewController.h"
#import "ZTMXFLoanSuccessfulView.h"
#import "MyAddressCell.h"
#import "ZTMXFLoanAddressCell.h"
#import "LSAddressManagerViewController.h"
#import "LSModifyAddressViewController.h"

@interface LSLoanAreaViewController () <LSAddressViewModelDelegate,LSReceivingViewDelegete,DefaultAddressDelegete,ChooseAddressProtocol, ZTMXFLoanAddressCellDelegate>
@property (nonatomic, strong) ZTMXFLoanSuccessfulView * loanSuccessfulView;

@property (nonatomic, strong) LSReceivingView *centerView;

//@property (nonatomic, strong) DefaultAddressView *defaultAddressView;

@property (nonatomic, strong) UIButton *cancelAddressButton;

@property (nonatomic, strong) XLButton *btnSubmitBtn;

@property (nonatomic, strong) MyAddressViewModel *myAddressViewModel;

/** 省、市、区*/
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *region;

@property (nonatomic, assign) LSAddressOperaType addressType;

@property (nonatomic, strong) LSAddressModel *addressModel;

@property (nonatomic, strong)UIView * footerView;

@property (nonatomic, strong) UIButton *addAddressBtn;
@property (nonatomic, strong)UIView * bottomView;


@end

@implementation LSLoanAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = K_BackgroundColor;
    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc]initWithString:@"借款结果"];
    [self set_Title:titleStr];
    [self configueSubViews];
    self.fd_interactivePopDisabled = YES;// 禁止侧滑
    // 请求地址列表
    [self writeAddressSuccess];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self writeAddressSuccess];
}

- (void)writeAddressSuccess
{
    [self.myAddressViewModel requestAddressListDataWithPageNum:1 pageSize:5];
    
}

- (void)getAddressListSuccess:(NSArray *)addressModelArray
{
    [self.dataArray removeAllObjects];
    for (LSAddressModel *addressModel in addressModelArray) {
        if (addressModel.isDefault) {
            addressModel.isSelected = 1;
            self.addressModel = addressModel;
            break;
        }
    }
    if (addressModelArray.count) {
        self.addressType = LSAddressUpdateType;
        self.loanSuccessfulView.descStr = @"请选择您的收货地址";
        [self.btnSubmitBtn setTitle:@"提交地址" forState:UIControlStateNormal];
        self.tableView.tableFooterView = self.footerView;
        
    }else{
        self.addressType = LSAddressAddType;
        self.loanSuccessfulView.descStr = @"为了您能收到尊享商品，请填写您的收货地址";
        self.tableView.tableFooterView = self.centerView;
        self.centerView.hidden = NO;
    }
    [self.dataArray  addObjectsFromArray:addressModelArray];
    [self.tableView reloadData];
}

#pragma mark -  ZTMXFLoanAddressCellDelegate

- (void)loanAddressCell:(ZTMXFLoanAddressCell *)LoanAddressCell flag:(NSInteger)flag
{
    if (flag == 1) {
        
        //        LSAddressManagerViewController * addressManagerVC = [[LSAddressManagerViewController alloc] init];
        //        [self.navigationController pushViewController:addressManagerVC animated:YES];
        LSModifyAddressViewController * modifyAddressVC = [[LSModifyAddressViewController alloc] init];
        //        modifyAddressVC.delegete = self;
        modifyAddressVC.stepType = 1;
        modifyAddressVC.addressType = LSModifyAddressType;
        modifyAddressVC.addressModel = LoanAddressCell.addressModel;
        [self.navigationController pushViewController:modifyAddressVC animated:YES];
        
    }
    //flag  1 编辑  2 选中地址
    if (flag == 2) {
        for (LSAddressModel *address in self.dataArray) {
            if (address.addressId == LoanAddressCell.addressModel.addressId) {
                address.isSelected = YES;
            }else{
                address.isSelected = NO;
            }
        }
        self.addressModel = LoanAddressCell.addressModel;
        [self.tableView reloadData];
    }
}


- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KW, 40 * PX)];
        [_footerView addSubview:self.addAddressBtn];
    }
    return _footerView;
}

- (UIButton *)addAddressBtn
{
    if (!_addAddressBtn) {
        _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addAddressBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
        [_addAddressBtn setTitleColor:K_2B91F0 forState:UIControlStateNormal];
        _addAddressBtn.frame = CGRectMake(KW - 100, 14, 90, 18 * PX);
        _addAddressBtn.titleLabel.font = FONT_Regular(13 * PX);
        [_addAddressBtn addTarget:self action:@selector(addAddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}

- (void)addAddressBtnAction
{
    LSModifyAddressViewController * modifyAddressVC = [[LSModifyAddressViewController alloc] init];
    modifyAddressVC.addressType = LSAddAddressType;
    [self.navigationController pushViewController:modifyAddressVC animated:YES];
}

#pragma mark -  TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96 * PX;
    //    return [self.tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"addressModel" cellClass:[ZTMXFLoanAddressCell class] contentViewWidth:KW];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZTMXFLoanAddressCell *cell = [ZTMXFLoanAddressCell loanAddressCellWithTableView:tableView];
    LSAddressModel *addressModel = [self.dataArray objectAtIndex:indexPath.row];
    cell.addressModel = addressModel;
    cell.delegete = self;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - LSAddressViewModelDelegate
#pragma mark - 请求默认地址地址成功的回调
- (void)getDefaultAddressSuccess:(LSAddressModel *)defaultAddress{
    self.addressModel = defaultAddress;
    if (_addressModel) {
        self.addressType = LSAddressUpdateType;
        self.loanSuccessfulView.descStr = @"您订购的商品即将寄到以下地址，请确认您的收货信息";
        //        [self.view addSubview:self.defaultAddressView];
        //        self.centerView.hidden = YES;
        //        self.defaultAddressView.hidden = NO;
        //        self.defaultAddressView.defaultAddress = defaultAddress;
        [self.btnSubmitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    }else{
        self.addressType = LSAddressAddType;
        self.loanSuccessfulView.descStr = @"为了您能收到尊享商品，请填写您的收货地址";
        [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
        [self.tableView addSubview:self.centerView];
        self.centerView.hidden = NO;
        //        self.defaultAddressView.hidden = YES;
    }
    [self.tableView reloadData];
    
}

#pragma mark - 修改地址成功的回调
-(void)modifyAddressSuccess
{
    // 提交地址
    LSLoanSuccessViewController *loanSuccessVC = [[LSLoanSuccessViewController alloc] init];
    loanSuccessVC.loanType = LSConsumerLoanType;
    loanSuccessVC.orderId = self.orderId;
    [self.navigationController pushViewController:loanSuccessVC animated:YES];
}

#pragma mark - DefaultAddressDelegete
#pragma mark - 点击修改按钮
- (void)clickEditDefaultAddress{
    LSAddressManagerViewController *choiseAddressVC = [[LSAddressManagerViewController alloc] init];
    @WeakObj(self);
    choiseAddressVC.clickCell = ^(LSAddressModel *addressModel) {
        [selfWeak chooseAddress:addressModel];
    };
    [self.navigationController pushViewController:choiseAddressVC animated:YES];
}

#pragma mark - LSReceivingViewDelegete
- (void)updateAddressWithProvice:(NSString *)provice city:(NSString *)city region:(NSString *)region{
    self.province = provice;
    self.city = city;
    self.region = region;
}

#pragma mark - ChooseAddressProtocol
- (void)chooseAddress:(LSAddressModel *)addressModel{
    self.addressModel = addressModel;
    //    self.defaultAddressView.defaultAddress = self.addressModel;
}

#pragma mark - 点击返回按钮
- (void)clickReturnBackEvent{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 点击提交按钮
- (void)btnSubmitBtnClick:(UIButton *)sender{
    if (sender.tag == 1) {
        // 设置参数
        NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
        if (self.addressType == LSAddressUpdateType) {
            paramsDict = [NSMutableDictionary dictionaryWithDictionary:@{@"opera":@"update",@"id":@(self.addressModel.addressId),@"consignee":self.addressModel.consignee,@"consigneeMobile":self.addressModel.consigneeMobile,@"province":self.addressModel.province,@"city":self.addressModel.city,@"region":self.addressModel.region,@"detailAddress":self.addressModel.detailAddress,@"isDefault":@(self.addressModel.isDefault),@"orderId":self.orderId}];
        }else if (self.addressType == LSAddressAddType){
            if (_centerView.textName.text.length == 0) {
                [self.view makeCenterToast:@"请填写收件人！"];
                return;
            }
            if (_centerView.phoneNum.text.length != 11 || ![_centerView.phoneNum.text hasPrefix:@"1"]) {
                [self.view makeCenterToast:@"请填写正确的联系电话！"];
                return;
            }
            if (_centerView.choosedAreaLabel.text.length == 0) {
                [self.view makeCenterToast:@"请填写所在地区！"];
                return;
            }
            if (_centerView.detailArea.text.length == 0) {
                [self.view makeCenterToast:@"请填写详细地址！"];
                return;
            }
            int isDefault = self.centerView.defaultAddressSwitch.on;
            paramsDict = [NSMutableDictionary dictionaryWithDictionary:@{@"opera":@"add",@"consignee":_centerView.textName.text,@"consigneeMobile":_centerView.phoneNum.text,@"province":self.province,@"city":self.city,@"region":self.region,@"detailAddress":_centerView.detailArea.text,@"isDefault":@(isDefault),@"orderId":self.orderId}];
        }
        [self.myAddressViewModel requestModifyAddressDataWithDict:paramsDict];
        
    }else if (sender.tag == 2){
        // 暂不提交
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = K_BackgroundColor;
    self.tableView.frame = CGRectMake(0, k_Navigation_Bar_Height, KW, KH - k_Navigation_Bar_Height - 128 * PX);
    self.tableView.mj_header.hidden = YES;
    _loanSuccessfulView = [[ZTMXFLoanSuccessfulView alloc] initWithFrame:CGRectMake(0, 0, KW, 213 * PX)];
    self.tableView.tableHeaderView = self.loanSuccessfulView;
    [self.view addSubview:self.bottomView];
    
}



- (LSReceivingView *)centerView{
    if (!_centerView) {
        _centerView = [[LSReceivingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,261 * PX) type:1];
        _centerView.delegete = self;
    }
    return _centerView;
}



- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KH - 110 * PX, KW, 110 * PX)];
//        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView addSubview:self.btnSubmitBtn];
        [_bottomView addSubview:self.cancelAddressButton];
    }
    return _bottomView;
}

- (UIButton *)cancelAddressButton
{
    if (!_cancelAddressButton) {
        _cancelAddressButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelAddressButton setFrame:CGRectMake(20,_btnSubmitBtn.bottom + 14 * PX, KW - 40, 20 * PX)];
        _cancelAddressButton.titleLabel.font = FONT_Regular(14 * PX);
        [_cancelAddressButton setTitle:@"不想要商品，不用给我寄了" forState:UIControlStateNormal];
        [_cancelAddressButton setTitleColor:K_2B91F0 forState:UIControlStateNormal];
        _cancelAddressButton.tag = 2;
        [_cancelAddressButton addTarget:self action:@selector(btnSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelAddressButton;
}

-(UIButton*)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [XLButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setFrame:CGRectMake(20,18 * PX, KW - 40, 44 * PX)];
        _btnSubmitBtn.titleLabel.font = FONT_Medium(16 * PX);
        [_btnSubmitBtn setTitle:@"提交地址" forState:UIControlStateNormal];
        [_btnSubmitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        _btnSubmitBtn.tag = 1;
        [_btnSubmitBtn addTarget:self action:@selector(btnSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmitBtn;
}

- (MyAddressViewModel *)myAddressViewModel{
    if (!_myAddressViewModel) {
        _myAddressViewModel = [[MyAddressViewModel alloc] init];
        _myAddressViewModel.delegete = self;
    }
    return _myAddressViewModel;
}

@end

