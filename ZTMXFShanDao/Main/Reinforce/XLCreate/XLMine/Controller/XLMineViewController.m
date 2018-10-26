//
//  XLMineViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//
//M
#import "ZTMXFMineAuthCenterModel.h"
#import "LSMineModel.h"
#import "LSMineOtherInfoModel.h"
#import "LSBorrowMoneyViewModel.h"
#import "MineApi.h"
#import "MineOtherInfoApi.h"
#import "ZTMXFCertificationListApi.h"
#import "RealNameManager.h"
#import "AddressBookManager.h"
//V
#import "ZTMXFMineTableHeaderView.h"
#import "ZTMXFMineFirstSectionCell.h"
#import "ZTMXFAlertCustomView.h"
#import "LSReminderButton.h"
#import "ZTMXFMineTableFooterView.h"
//C
#import "XLMineViewController.h"
#import "LSMyMessageListViewController.h"
#import "LSMyBankListViewController.h"
#import "LSLoanListViewController.h"
#import "LSOrderListViewController.h"
#import "LSMyCouponListViewController.h"
#import "ZTMXFPeriodListViewController.h"
#import "LSAddressManagerViewController.h"
#import "LSSettingViewController.h"
#import "LSBalanceWithdrawViewController.h"
#import "ZTMXFCertificationCenterViewController.h"
#import "JBScanIdentityCardViewController.h"
#import "LSIdfBindCardViewController.h"
#import "LSCreditAuthWebViewController.h"
#import "LSPhoneOperationAuthViewController.h"
//T
#import "UITabBar+badge.h"
#import "CYLTabBarController.h"
#import "ZTMXFServerStatisticalHelper.h"
#import "LSLoanAreaViewController.h"
#import "UIButton+JKImagePosition.h"
#import "ZTMXFCertificationHelper.h"

//测试
@interface XLMineViewController ()<UITableViewDelegate,UITableViewDataSource,LSBorrowMoneyViewModelDelegate,AddressBookManagerDelegate>
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) ZTMXFMineTableHeaderView *headerView;
@property (nonatomic, strong) LSReminderButton       *notificationCenterButton;
@property (nonatomic, strong) NSMutableArray <NSMutableArray *>*dataSource;
@property (nonatomic, strong) NSMutableArray *reviewDataSource;

@property (nonatomic, strong) LSMineModel    *mineModel;
@property (nonatomic, strong) LSMineOtherInfoModel *mineOtherInfoModel;

@property (nonatomic, strong) LSBorrowMoneyViewModel *borrowMoneyViewModel;

@property (nonatomic, strong) ZTMXFMineTableFooterView  *footerView;

@end

static NSString *FirstSectionCellIdentifier = @"cellForSection0";
static NSString *ThirdSectionCellIdentifier = @"cellForSection2";

@implementation XLMineViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //  设置状态栏颜色
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [ZTMXFServerStatisticalHelper LoanStatisticalApi];

    CGFloat height =  IS_IPHONEX?44:0;
    self.headerView.height = X(246)+height;
    if ([LoginManager loginState]) {
        [self.headerView setLoginButtonHidden:YES];
    } else {
        [self.headerView setLoginButtonHidden:NO];
    }
    [self request];
    [self showBadge];//"我的"上面有个通知的小红点
//    NSMutableArray *firstSectionDataSource = [[NSMutableArray alloc]init];
//    [firstSectionDataSource addObjectsFromArray:![LoginManager appReviewState]?@[@{@"借款记录":@"JZ_User_Center_Record_boan"},@{@"我的认证":@"JZ_User_Center_my_certify"},@{@"优惠券":@"JZ_User_Center_ticket"},@{@"银行卡管理":@"JZ_User_Center_bank_card"}]:@[@{@"订单管理":@"JZ_User_Center_Order_Manager"},@{@"优惠券":@"JZ_User_Center_ticket"},@{@"银行卡管理":@"JZ_User_Center_bank_card"}]];
//    self.dataSource[0] = firstSectionDataSource;
//    NSMutableArray *thirdSectionDataSource = [[NSMutableArray alloc]init];
//    [thirdSectionDataSource addObjectsFromArray:![LoginManager appReviewState]?@[@{@"title":@"订单管理",@"image":@"user_center_order_manage"},@{@"title":@"账户余额",@"image":@"user_center_my_money"},@{@"title":@"地址管理",@"image":@"user_center_addr_manage"},@{@"title":@"服务中心",@"image":@"user_center_service_enter"}]:@[@{@"title":@"地址管理",@"image":@"user_center_addr_manage"}]];
//    self.dataSource[0] = thirdSectionDataSource;
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
    //  监听退出登陆
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess) name:kLogoutSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBadge) name:NotNewNotificationMsg object:nil];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.fd_prefersNavigationBarHidden = YES;
}

- (void)configUI{
//    self.view.backgroundColor = K_BackgroundColor;
//    self.tableView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.notificationCenterButton];
}

//  判断有没有登录
- (BOOL)loginState{
    if (![LoginManager loginState]) {
        [LoginManager presentLoginVCWithController:self];
        return NO;
    } else {
        return YES;
    }
}
- (void)request{
    if ([LoginManager loginState]) {
        [self mineApiRequest];//获取我的页面数据
        [self mineOtherInfoApiRequest];
    }else{
        self.mineModel = nil;
        self.mineOtherInfoModel = nil;
    }
}


// 绑定的ViewModel
- (LSBorrowMoneyViewModel *)borrowMoneyViewModel{
    if (_borrowMoneyViewModel == nil) {
        _borrowMoneyViewModel = [[LSBorrowMoneyViewModel alloc] init];
        _borrowMoneyViewModel.delegate = self;
    }
    return _borrowMoneyViewModel;
}

- (void)footerViewClick{
    [self cyl_tabBarController].selectedIndex = 0;
}

- (void)notificationCenterButtonClick{
    if ([self loginState]) {
        LSMyMessageListViewController *messageListVC = [[LSMyMessageListViewController alloc] init];
        [self.navigationController pushViewController:messageListVC animated:YES];
    }
}
- (void)logoutSuccess{
    [self.borrowMoneyViewModel requestBorrowMoneyViewData];
}
- (void)showBadge
{
    NSInteger unreadMessageCount = [LSNotificationModel notifi_updateAllNumNotificationInfoNotRead];
    if (unreadMessageCount > 0) {
        [self.notificationCenterButton showRedReminderCount:[NSString stringWithFormat:@"%ld", unreadMessageCount]];
    } else {
        [self.notificationCenterButton showRedReminderCount:@"0"];
    }
    if (unreadMessageCount) {
        [self.tabBarController.tabBar showBadgeOnItemIndex:2];
    }else{
        [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
    }
}

- (void)pushViewControllerWithTitle:(NSString *)title
{
    if (!title) {
        return;
    }
    if ([title isEqualToString:@"借款记录"]) {
        if ([self loginState]) {
            LSLoanListViewController *loanListVC = [[LSLoanListViewController alloc] init];
            loanListVC.controllerType = LoanListViewControllerType;
            [self.navigationController pushViewController:loanListVC animated:YES];
        }
    }else if ([title isEqualToString:@"订单管理"]){
        if ([self loginState]) {
            LSOrderListViewController *orderListVC = [[LSOrderListViewController alloc] init];
            [self.navigationController pushViewController:orderListVC animated:YES];
        }
    }else if ([title isEqualToString:@"优惠券"]){
        if ([self loginState]) {
            LSMyCouponListViewController *couponListVC = [[LSMyCouponListViewController alloc] init];
            [self.navigationController pushViewController:couponListVC animated:YES];
        }
    }else if ([title isEqualToString:@"银行卡管理"]){
        if (![self loginState]) {
            return;
        }
        LSMyBankListViewController *bankListVC = [[LSMyBankListViewController alloc] init];
        [self.navigationController pushViewController:bankListVC animated:YES];
    }else if ([title isEqualToString:@"账户余额"]){
        if ([self loginState]) {
            if ([self jumpToSkinIdOrBindCard]) {
                //  跳转到对应认证页面
            } else {
                LSBalanceWithdrawViewController *VC = [[LSBalanceWithdrawViewController alloc] init];
                VC.rebateAmount = self.mineModel.rebateAmount;
                [self.navigationController pushViewController:VC animated:YES];
            }
        }
    }else if ([title isEqualToString:@"地址管理"]){
        if ([self loginState]) {
            LSAddressManagerViewController *addressVC = [[LSAddressManagerViewController alloc] init];
            [self.navigationController pushViewController:addressVC animated:YES];
        }
    }else if ([title isEqualToString:@"服务中心"]){
            LSWebViewController *webVC = [[LSWebViewController alloc] init];
            webVC.webUrlStr = !kStringIsEmpty(self.mineOtherInfoModel.serviceCentre)?self.mineOtherInfoModel.serviceCentre:DefineUrlString(serviceCenter);
            [self.navigationController pushViewController:webVC animated:YES];
    }else if ([title isEqualToString:@"设置"]){
        LSSettingViewController *settingVC = [[LSSettingViewController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }else if ([title isEqualToString:@"我的认证"]){
        if ([self loginState]) {
            ZTMXFCertificationCenterViewController *bankListVC = [[ZTMXFCertificationCenterViewController alloc] init];
            [self.navigationController pushViewController:bankListVC animated:YES];
        }   
    }
}

- (void)addressBookManagerAuthSuccess
{
    for (int i = 0; i < self.dataSource[1].count; i++) {
        ZTMXFMineAuthCenterModel * status = self.dataSource[1][i];
        if ([status.authNameUnique isEqualToString:@"contacts_status"]) {
            status.authStatus = 1;
            NSString * msg = [NSString stringWithFormat:@"%@完成", status.authName];
            [self.view makeCenterToast:msg];
            [self.tableView reloadData];
            return;
        }
    }
}



//  获取我的页面数据
- (void)mineApiRequest{
    MineApi *mineApi = [[MineApi alloc] init];
    [mineApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.mineModel = [LSMineModel mj_objectWithKeyValues:dataDict];
//            self.mineHeaderView.mineModel = self.mineModel;
            
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
//        self.mineHeaderView.mineModel = nil;
        [self.tableView reloadData];
    }];
}
/** 跳转到扫身份证和绑定银行卡 */
- (BOOL)jumpToSkinIdOrBindCard{
    /** 人脸识别状态【0:未认证,-1:认证失败，1:已认证】 */
    NSInteger faceStatus = self.mineModel.facesStatus;
    /** 是否绑卡状态【0:未绑卡  1：绑卡：-1：绑卡失败】(登陆后才有) */
    NSInteger bindCardStatus = self.mineModel.bindStatus;
    if (faceStatus != 1) {
        //  跳转到实名认证
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressIdf isSaveBackVcName:YES];
        return YES;
    } else if (bindCardStatus != 1) {
        //  跳转到绑卡
        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressBindCardMian isSaveBackVcName:YES];
        return YES;
    }
    return NO;
}
//  获取我的页面数据
- (void)mineOtherInfoApiRequest{
    MineOtherInfoApi *mineOtherInfoApi = [[MineOtherInfoApi alloc] init];
    [mineOtherInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSDictionary *dataDict = responseDict[@"data"];
            self.mineOtherInfoModel = [LSMineOtherInfoModel mj_objectWithKeyValues:dataDict];
            [self.tableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 8.f;
    }
    return 0.02f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KW,8)];
        view.backgroundColor = UIColor.whiteColor;
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KW,8)];
    view.backgroundColor = UIColor.clearColor;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 0.f;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 47;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([LoginManager appReviewState]) {
        self.tableView.tableFooterView = [self footerView];
    }else{
        self.tableView.tableFooterView = [UIView new];
    }
//    return [LoginManager appReviewState]?self.reviewDataSource.count:self.dataSource.count;
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if ([LoginManager appReviewState]) {
//        return [self.reviewDataSource[section] count];
//    }
    
    return [self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThirdSectionCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ThirdSectionCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *cellDict = self.dataSource[indexPath.section][indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", cellDict[@"image"]]];
    cell.textLabel.font = FONT_Regular(X(15));
    cell.textLabel.textColor = K_333333;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", cellDict[@"title"]];
    cell.detailTextLabel.font = FONT_Regular(X(15));
    cell.detailTextLabel.textColor = COLOR_SRT(@"CDCDCD");
    if ([cell.textLabel.text isEqualToString:@"订单管理"]) {
        cell.detailTextLabel.text = @"查看";
    }
    if ([cell.textLabel.text isEqualToString:@"账户余额"]) {
        cell.detailTextLabel.text = @"提现";
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *infoDict = self.dataSource[indexPath.section][indexPath.row];
    NSString *titleStr = infoDict[@"title"];
//    if ([LoginManager appReviewState]) {
        [self pushViewControllerWithTitle:titleStr];
//    } else if (indexPath.section == 1 || indexPath.section == 2) {
//        [self pushViewControllerWithTitle:titleStr];
//    }
}

- (ZTMXFMineTableHeaderView *)headerView{
    if (!_headerView) {
        CGFloat height =  IS_IPHONEX?44:0;
        _headerView = [[ZTMXFMineTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, KW, X(246)+height)];
        MJWeakSelf
        _headerView.loginButtonClickBlock = ^(){
            [weakSelf loginState];
        };
        [_headerView setLoginButtonHidden:[LoginManager loginState]];
        _headerView.dataAry = ![LoginManager appReviewState]?@[@{@"借款记录":@"JZ_User_Center_Record_boan"},@{@"我的认证":@"JZ_User_Center_my_certify"},@{@"优惠券":@"JZ_User_Center_ticket"},@{@"银行卡管理":@"JZ_User_Center_bank_card"}]:@[@{@"订单管理":@"JZ_User_Center_my_certify"},@{@"优惠券":@"JZ_User_Center_ticket"},@{@"银行卡管理":@"JZ_User_Center_bank_card"}];
        _headerView.itemSeletedBlock = ^(NSString *title){
            [weakSelf pushViewControllerWithTitle:title];
        };
    }
    return _headerView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KW, KH - self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = K_BackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ZTMXFMineFirstSectionCell class] forCellReuseIdentifier:FirstSectionCellIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, X(20), 0, 15)];
        _tableView.separatorColor = COLOR_SRT(@"e5e5e5");
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (NSMutableArray <NSMutableArray *>*)dataSource{
    return _dataSource?:({
        _dataSource = [NSMutableArray new];
        NSMutableArray *firstSectionDataSource = [[NSMutableArray alloc]init];
        [_dataSource addObject:firstSectionDataSource];
        
        NSMutableArray *thirdSectionDataSource = [[NSMutableArray alloc]init];
        [thirdSectionDataSource addObjectsFromArray:![LoginManager appReviewState]?@[@{@"title":@"订单管理",@"image":@"user_center_order_manage"},@{@"title":@"账户余额",@"image":@"user_center_my_money"},@{@"title":@"地址管理",@"image":@"user_center_addr_manage"},@{@"title":@"服务中心",@"image":@"user_center_service_enter"}]:@[@{@"title":@"地址管理",@"image":@"user_center_addr_manage"}]];
        [_dataSource addObject:thirdSectionDataSource];
        
        NSMutableArray *fourSectionDataSource = [[NSMutableArray alloc]init];
        [fourSectionDataSource addObjectsFromArray:@[@{@"title":@"设置",@"image":@"user_center_my_set"}]];
        [_dataSource addObject:fourSectionDataSource];
        _dataSource;
    });
}

- (NSMutableArray *)reviewDataSource{
    if (!_reviewDataSource) {
        _reviewDataSource = [[NSMutableArray alloc]init];
        NSMutableArray *thirdSectionDataSource = [[NSMutableArray alloc]init];
        [thirdSectionDataSource addObjectsFromArray:@[@{@"title":@"地址管理",@"image":@"user_center_addr_manage"},@{@"title":@"设置",@"image":@"user_center_my_set"}]];
        [_reviewDataSource addObject:thirdSectionDataSource];
    }
    return _reviewDataSource;
}

- (LSReminderButton *)notificationCenterButton{
    if (!_notificationCenterButton) {
        _notificationCenterButton = [LSReminderButton buttonWithType:UIButtonTypeCustom];
        _notificationCenterButton.frame = CGRectMake(KW - X(60), Status_Bar_Height + 10, X(44), X(34));
        [_notificationCenterButton setImage:[UIImage imageNamed:@"JZ_User_Center_msg"] forState:UIControlStateNormal];
        [_notificationCenterButton setImage:[UIImage imageNamed:@"JZ_User_Center_msg"] forState:UIControlStateHighlighted];
        [_notificationCenterButton addTarget:self action:@selector(notificationCenterButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [_notificationCenterButton setTitle:@"消息" forState:UIControlStateHighlighted];
//        [_notificationCenterButton setTitle:@"消息" forState:UIControlStateNormal];
        [_notificationCenterButton setTitleColor:COLOR_SRT(@"7D7D7D") forState:UIControlStateNormal];
        [_notificationCenterButton setTitleColor:COLOR_SRT(@"7D7D7D") forState:UIControlStateHighlighted];
        _notificationCenterButton.titleLabel.font = FONT_Regular(X(12));
        [_notificationCenterButton jk_setImagePosition:LXMImagePositionTop spacing:X(5)];
    }
    return _notificationCenterButton;
}

- (ZTMXFMineTableFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[ZTMXFMineTableFooterView alloc]initWithFrame:CGRectMake(0,0, KW, X(76))];
        @WeakObj(self);
        _footerView.customerServiceButtonClickBlock = ^{
            [selfWeak footerViewClick];
        };
    }
    return _footerView;
}
@end
