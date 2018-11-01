//
//  ZTMXFCertificationListViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationListViewController.h"
#import "ZTMXFCertificationListCell.h"
#import "ZTMXFCertificationSectionView.h"
#import "JBScanIdentityCardViewController.h"
#import "LSIdfBindCardViewController.h"
#import "LSCreditAuthWebViewController.h"
#import "LSPhoneOperationAuthViewController.h"
#import "AddressBookManager.h"
#import "ZTMXFCertificationListApi.h"
#import "ZTMXFLsdAuthCenterConfigureList.h"
#import "MoxieSDK.h"
#import "LSAuthSupplyApi.h"
#import "ZTMXFCertificationListFooterView.h"
#import "LSLocationManager.h"
#import "ZTMXFAuthenticationViewModel.h"
#import "LSCreditCheckViewController.h"
#import "LSAuthResultViewController.h"
#import "ZTMXFAlertCustomView.h"
#import "ZTMXFPermissionsAlertView.h"
#import "ZTMXFCertificationCenterItem.h"
#import "ZTMXFCertificationCenterTopView.h"
#import "ZTMXFCertificationFirstFooterView.h"
#import "LSCreditAuthApi.h"
#import "LSCreditAuthModel.h"
#import "ZTMXFMessageVoiceAlertView.h"
@interface ZTMXFCertificationListViewController ()<MoxieSDKDelegate, AuthenticationViewModelDelegate, AddressBookManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSDictionary                *_latitudeAndLongitude;
}

@property (nonatomic, strong)ZTMXFLsdAuthCenterConfigureList * authCenterConfigure;

/** 白领贷认证类型 */
@property (nonatomic, assign) AuthSupplyType authSupplyType;

@property (nonatomic, strong)ZTMXFCertificationListFooterView * footerView;
@property (nonatomic, strong) ZTMXFCertificationCenterTopView *certificationCenterTopView;


/** 认证viewModel */
@property (nonatomic, strong) ZTMXFAuthenticationViewModel *authViewModel;
/** 定位数据 */
@property (nonatomic, copy) NSString *latitudeString;
@property (nonatomic, copy) NSString *longitudeString;

@property (nonatomic, assign)BOOL isAddress;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZTMXFCertificationListViewController



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self httpAuthCenterConfigureList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //布局UI
    [self configUI];
    
//    [self httpAuthCenterConfigureList];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //刷新页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creditAuthChange) name:kCreditAuthChangePushNotification object:nil];
    //V1.3.4新增埋点友盟已添加
    if (self.loanType == ConsumeLoanType) {
        [ZTMXFUMengHelper mqEvent:k_credit_page_pv_xf];
    }
    //获取位置等信息
    @WeakObj(self);
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [[LSLocationManager shareLocationManager] locationSuccessWithComplish:^(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString) {
            selfWeak.latitudeString = latitudeString;
            selfWeak.longitudeString = longitudeString;
            [self latitude];
        }];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!_isAddress && _authCenterConfigure.authTypeStatus == 0) {
                _isAddress = YES;
                if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
                    [ZTMXFPermissionsAlertView showAlert:XLPermissionsGPS Click:^{
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    }];
                }
            }
        });
    }
    [self latitude];
    // Do any additional setup after loading the view.
}

- (void)latitude{
    [XLServerBuriedPointHelper longitudeAndLatitude:^(NSDictionary *latitudeAndLongitude) {
        _latitudeAndLongitude = latitudeAndLongitude;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addressBookManagerAllowAccess:(BOOL)access
{
    
}

//获取通知认证状态刷新
- (void)creditAuthChange
{
    [self httpAuthCenterConfigureList];
    
}
//布局页面
- (void)configUI{
    self.view.backgroundColor = K_BackgroundColor;
    [self.view addSubview:self.certificationCenterTopView];
    [self.view addSubview:self.collectionView];
}
//返回上一个页面增加提示
- (void)clickReturnBackEvent
{
    if (_authCenterConfigure.authTypeStatus == 1 || _authCenterConfigure.authTypeStatus == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [ZTMXFMessageVoiceAlertView showVoiceWithMessageVoiceAlertType:XLMessageVoiceAlertCertification ConfirmBlock:^{

        } cancelBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}


/** 获取认证状态信息 */
- (void)requestCreditAuthStatus
{
    @WeakObj(self);
    LSCreditAuthApi *creditAuthApi = [[LSCreditAuthApi alloc] init];
    [creditAuthApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            LSCreditAuthModel * creditAuthModel = [LSCreditAuthModel mj_objectWithKeyValues:responseDict[@"data"]];
            selfWeak.certificationCenterTopView.bottomLabel.text = creditAuthModel.ballNum;
            selfWeak.certificationCenterTopView.topLabel.text = creditAuthModel.ballDesc;
            
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

//刷新页面
- (void)configurationFooter
{
    //    int i = 0;
    //    for (XLCertificationStatus *status in self.authCenterConfigure.basicsItems) {
    //        if (status.authStatus == 1) {
    //            i ++;
    //        }
    //    }
    //    [self.certificationCenterTopView setNumber:i];
    //    self.footerView.authTypeStatus = _authCenterConfigure.authTypeStatus;
    [_collectionView reloadData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!_isAddress && _authCenterConfigure.authTypeStatus == 0) {
//            _isAddress = YES;
//            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//                [ZTMXFPermissionsAlertView showAlert:XLPermissionsGPS Click:^{
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//                }];
//            }
//        }
//    });
}



//提交审核回调
- (void)requestSubmitStrongRiskSuccess:(NSDictionary *)successDict
{
    //后台打点
    NSMutableDictionary *pointInfo = [[NSMutableDictionary alloc]init];
    [pointInfo setObject:[XLServerBuriedPointHelper wifiName] forKey:@"wifiName"];
    [pointInfo setObject:[XLServerBuriedPointHelper wifiMac] forKey:@"wifiMac"];
    [_latitudeAndLongitude enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [pointInfo setObject:obj forKey:key];
    }];
    [pointInfo setObject:[successDict[@"msg"] description]?:@"" forKey:@"msg"];
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"submit.xfd_hqed" OtherDict:pointInfo];
    [self.footerView.submitBtn setTitle:@"审核中" forState:UIControlStateNormal];
    self.footerView.submitBtn.userInteractionEnabled = NO;
    if (_loanType == ConsumeLoanType) {
        [ZTMXFUMengHelper mqEvent:k_submit_risk_xf];
        //  消费贷认证成功
        LSCreditCheckViewController * cheakVC = [[LSCreditCheckViewController alloc] init];
        cheakVC.animationTime = [successDict[@"animationTime"] integerValue];
        [self.navigationController pushViewController:cheakVC animated:YES];
    } else if (_loanType == MallLoanType) {
        // 消费分期认证
        [self.authViewModel requestCreditAuthInfoStatusWithType:@"3"];
    }
}
//点击提交审核
- (void)submitBtnAction1
{
    //提交审核
    if (_loanType == ConsumeLoanType || _loanType == MallLoanType) {
        for (XLCertificationStatus * status in _authCenterConfigure.basicsItems) {
            if (status.authStatus != 1 && status.isRequired) {
                NSString * str = [NSString stringWithFormat:@"%@未完成", status.authName];
                [kKeyWindow makeCenterToast:str];
                return;
            }
        }
    }
    if (_loanType == MallLoanType) {
        int count = 0;
        for (XLCertificationStatus * status in _authCenterConfigure.eitherOrItems) {
            if (status.authStatus == 1) {
                count++;
            }
        }
        if (count == 0) {
            NSString * str = [NSString stringWithFormat:@"%@未完成", _authCenterConfigure.eitherOrAuth];
            [kKeyWindow makeCenterToast:str];
            return;
        }
    }
    
    if (![LoginManager appReviewState]){
        @WeakObj(self);
        
        [[LSLocationManager shareLocationManager] locationSuccessWithComplish:^(AMapLocationReGeocode *locationGeocode, NSString *latitudeString, NSString *longitudeString) {
            selfWeak.latitudeString = latitudeString;
            selfWeak.longitudeString = longitudeString;
        }];
    }
    [self.authViewModel requestSubmitStrongRiskApiWithAuthType:_loanType entranceType:@"1" Latitude:self.latitudeString Longitude:self.longitudeString];
    
}


#pragma mark -
- (void)requestCreditAuthInfoSuccess:(LSAuthInfoModel *)authInfoModel
{
    // 跳转到认证结果页面
    LSAuthResultViewController *authResultVC = [[LSAuthResultViewController alloc] init];
    authResultVC.loanType = MallLoanType;
    authResultVC.authInfoModel = authInfoModel;
    [self.navigationController pushViewController:authResultVC animated:YES];
    // 如果是消费分期，发送通知
    if (self.loanType == MallLoanType) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KMallAuthSumitedNotifi" object:nil];
    }
}


- (ZTMXFAuthenticationViewModel *)authViewModel{
    if (_authViewModel == nil) {
        _authViewModel = [[ZTMXFAuthenticationViewModel alloc] init];
        _authViewModel.delegate = self;
    }
    return _authViewModel;
}



- (void)httpAuthCenterConfigureList
{
    @WeakObj(self);
    [self  requestCreditAuthStatus];
    NSString * AuthType = @"1";
    self.title = @"消费贷认证";

    if (_loanType == MallLoanType){
        AuthType = @"2";
        self.title = @"消费分期认证";

    }
//    if (_loanType == ConsumeLoanType) {
//    }else{
//    }
    ZTMXFCertificationListApi * api = [[ZTMXFCertificationListApi alloc] initWithAuthType:AuthType];
    [api requestWithSuccess:^(NSDictionary *responseDict) {
        NSString *codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            if ([[responseDict allKeys] containsObject:@"data"]) {
                selfWeak.authCenterConfigure = [ZTMXFLsdAuthCenterConfigureList mj_objectWithKeyValues:responseDict[@"data"][@"lsdAuthCenterConfigureList"]];
                [selfWeak configurationFooter];
                [selfWeak.collectionView reloadData];
            }
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

//通讯录认证成功 回调
- (void)addressBookManagerAuthSuccess;
{
    for (int i = 0; i < _authCenterConfigure.basicsItems.count; i++) {
        XLCertificationStatus * status = _authCenterConfigure.basicsItems[i];
        if ([status.authNameUnique isEqualToString:@"contacts_status"]) {
            status.authStatus = 1;
            NSString * msg = [NSString stringWithFormat:@"%@完成", status.authName];
            [self.view makeCenterToast:msg];
            [self.collectionView reloadData];
            return;
        }
    }
    
}

#pragma mark - 魔蝎认证--淘宝--京东
/** 开始认证 */
- (void)startMoXieAuthWithType:(AuthSupplyType)authType{
    //    self.authSupplyType = authType;
    //  认证入口PV
    [SVProgressHUD showLoading];
    LSAuthSupplyApi *  authSupplyApi = [[LSAuthSupplyApi alloc] initWithSupplyType:authType];
    [authSupplyApi requestWithSuccess:^(NSDictionary *responseDict) {
        [SVProgressHUD dismiss];
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            NSString * transParaStr = [responseDict[@"data"][@"transPara"] description];
            /** 开始魔蝎认证 */
            [self beginMoxieSDKWithUserId:transParaStr authType:authType];
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 魔蝎 认证
//公积金认证  0  社保认证 1  信用卡认证2  支付宝3
-(void)beginMoxieSDKWithUserId:(NSString*)userId authType:(AuthSupplyType)authType{
    /***必须配置的基本参数*/
    [MoxieSDK shared].delegate = self;
    [MoxieSDK shared].userId = userId;
    [MoxieSDK shared].apiKey = MoxieSDKKEY;
    [MoxieSDK shared].backImageName = @"nav_back";
    [MoxieSDK shared].fromController = self;
    [MoxieSDK shared].themeColor = K_MainColor;
    
    switch (authType) {
        case AuthSupplyTypeJingDong:{
            //  京东
            [MoxieSDK shared].taskType = @"jingdong";
        }
            break;
        case AuthSupplyTypeTaoBao:{
            //  淘宝
            [MoxieSDK shared].taskType = @"taobao";
        }
            break;
        default:
            break;
    }
    [[MoxieSDK shared] startFunction];
}

//  魔蝎认证结果
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
    //  code = -1, 用户未进行操作
    //  code 1,  用户认证成功
    //  code 2,  认证处理中
    int code = [resultDictionary[@"code"] intValue];
    NSString * type = [resultDictionary[@"taskType"] description];
    for (int i = 0; i < _authCenterConfigure.eitherOrItems.count; i++) {
        XLCertificationStatus * status = _authCenterConfigure.eitherOrItems[i];
        if ([type isEqualToString:@"jingdong"]) {
            if ([status.authNameUnique isEqualToString:@"jingdong_status"]) {
                status.authStatus = code;
            }
        }
        if ([type isEqualToString:@"taobao"]) {
            if ([status.authNameUnique isEqualToString:@"taobao_status"]) {
                status.authStatus = code;
            }
        }
    }
    [self.collectionView reloadData];
}

#pragma mark UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.loanType == ConsumeLoanType ? 1 : 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section == 0 ? _authCenterConfigure.basicsItems.count : _authCenterConfigure.eitherOrItems.count;
}

#pragma mark - 头部视图大小
//第二步
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (self.loanType != ConsumeLoanType && section == 0 ) {
        return CGSizeMake(KW, 40 * PX);
    }
    return CGSizeMake(KW, X(210) + 300);
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.loanType != ConsumeLoanType && indexPath.section == 0 ) {
        ZTMXFCertificationFirstFooterView *firstFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerOne" forIndexPath:indexPath];
        firstFooterView.lable.text = _authCenterConfigure.eitherOrAuth;
        
        return firstFooterView;
    }
    
    ZTMXFCertificationListFooterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
    view.authTypeStatus = _authCenterConfigure.authTypeStatus;
    view.layer.masksToBounds = YES;
    [view.submitBtn addTarget:self action:@selector(submitBtnAction1) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZTMXFCertificationCenterItem *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.certificationStatus = self.authCenterConfigure.basicsItems[indexPath.item];
    }else{
        cell.certificationStatus = self.authCenterConfigure.eitherOrItems[indexPath.item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XLCertificationStatus * certificationStatus;
    if (indexPath.section == 0) {
        certificationStatus = _authCenterConfigure.basicsItems[indexPath.item];
    } else if (indexPath.section == 1) {
        certificationStatus = _authCenterConfigure.eitherOrItems[indexPath.item];
    }
//    if (certificationStatus.sortBy != 1) {
//        for (XLCertificationStatus * status in _authCenterConfigure.basicsItems) {
//            if (certificationStatus.sortBy > status.sortBy ) {
//                if (status.authStatus != 1) {
//                    NSString * msg = [NSString stringWithFormat:@"%@未完成认证", status.authName];
//                    [self.view makeCenterToast:msg];
//                    return;
//                }
//            }
//        }
//    }
//    NSString * str = @"";
//    if (certificationStatus.authStatus == 1) {
//        str = [NSString stringWithFormat:@"%@已完成", certificationStatus.authName];
//    }else if (certificationStatus.authStatus == 2){
//        str = [NSString stringWithFormat:@"%@认证中", certificationStatus.authName];
//        if ([certificationStatus.authNameUnique isEqualToString:@"mobile_status"]) {
//            LSWebViewController *webVC = [[LSWebViewController alloc] init];
//            webVC.webUrlStr = DefineUrlString(k_mobile_identify);
//            [self.navigationController pushViewController:webVC animated:YES];
//            return;
//        }
//    }
//    if (str.length) {
//        [self.view makeCenterToast:str];
//        return;
//    }
    
    
    
    UIViewController * vc;
    if ([certificationStatus.authNameUnique isEqualToString:@"idnumber_status"]) {
        [ZTMXFUMengHelper mqEvent:k_do_idcard_xf];
        NSMutableDictionary *pointInfo = [[NSMutableDictionary alloc]init];
        [pointInfo setObject:[XLServerBuriedPointHelper wifiName] forKey:@"wifiName"];
        [pointInfo setObject:[XLServerBuriedPointHelper wifiMac] forKey:@"wifiMac"];
        [_latitudeAndLongitude enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [pointInfo setObject:obj forKey:key];
        }];
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_smrz" OtherDict:pointInfo];
        JBScanIdentityCardViewController * scanIdentityCardVC = [[JBScanIdentityCardViewController alloc] init];
        scanIdentityCardVC.loanType = _loanType;
        vc = scanIdentityCardVC;
    }else if ([certificationStatus.authNameUnique isEqualToString:@"bind_card"]) {
        //V1.3.4新增埋点友盟已添加
        [ZTMXFUMengHelper mqEvent:k_bankcard_click_xf];
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_yhkrz" OtherDict:nil];
        //   绑定主卡
        LSIdfBindCardViewController * bankVc = [[LSIdfBindCardViewController alloc] init];
        bankVc.bindCardType = BindBankCardTypeMain;
        bankVc.loanType = _loanType;
        vc = bankVc;
    }else if ([certificationStatus.authNameUnique isEqualToString:@"zm_status"]) {
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_zmxy" OtherDict:nil];
        MJWeakSelf
        LSCreditAuthWebViewController *CreditAuthWebVC = [[LSCreditAuthWebViewController alloc] init];
        CreditAuthWebVC.zhiMaPopBlock = ^(){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"从芝麻pop,调认证状态接口");
                [weakSelf httpAuthCenterConfigureList];
            });
        };
        CreditAuthWebVC.loanType = _loanType;
        CreditAuthWebVC.isJumpFromAuthVC = YES;
        vc = CreditAuthWebVC;
        [ZTMXFUMengHelper mqEvent:k_do_zhima_xf];
        //
    }else if ([certificationStatus.authNameUnique isEqualToString:@"mobile_status"]) {
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_yysrz" OtherDict:nil];
        //运营商认证
        LSPhoneOperationAuthViewController *PhoneOperationAuthVC = [[LSPhoneOperationAuthViewController alloc] init];
        PhoneOperationAuthVC.loanType = _loanType;
        PhoneOperationAuthVC.isJumpFromAuthVC = YES;
        vc = PhoneOperationAuthVC;
        [ZTMXFUMengHelper mqEvent:k_operator_click_xf];
        
    }else if ([certificationStatus.authNameUnique isEqualToString:@"taobao_status"]) {
        [self startMoXieAuthWithType:AuthSupplyTypeTaoBao];
    }else if ([certificationStatus.authNameUnique isEqualToString:@"jingdong_status"]) {
        [self startMoXieAuthWithType:AuthSupplyTypeJingDong];
    } else if ([certificationStatus.authNameUnique isEqualToString:@"contacts_status"]) {
        [ZTMXFUMengHelper mqEvent:k_contactlist_click_xf];
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_txlrz" OtherDict:nil];
        NSString * msgStr = @"闪到将获取您的通讯录权限稍后请点击“允许”";
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:msgStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_RED_STR] range:[msgStr rangeOfString:@"“允许”"]];
        ZTMXFAlertCustomView * alertCustomView = [[ZTMXFAlertCustomView alloc] initWithMessage:attStr btnTitle:@"知道了"];
        alertCustomView.btnClick = ^{
            AddressBookManager *addressBook = [[AddressBookManager alloc] init];
            addressBook.delegate = self;
            [addressBook addressBookAuthWithContact];
        };
        [alertCustomView showAlertView];
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.01;
        layout.minimumInteritemSpacing = 0.01;
        layout.sectionInset = UIEdgeInsetsMake(16, 0, 16, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KW, KH - k_Navigation_Bar_Height + 300) collectionViewLayout:layout];
        layout.itemSize = CGSizeMake(KW / 3 - 0.01, (X(280)) / 2 - 0.01);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[ZTMXFCertificationCenterItem class] forCellWithReuseIdentifier:@"item"];
        [_collectionView registerClass:[ZTMXFCertificationListFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        [_collectionView registerClass:[ZTMXFCertificationFirstFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerOne"];
        _collectionView.contentInset = UIEdgeInsetsMake(115 * PX, 0, 100, 0);
        
        [_collectionView addSubview:self.certificationCenterTopView];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectionView;
}


- (ZTMXFCertificationCenterTopView *)certificationCenterTopView{
    if (!_certificationCenterTopView) {
        _certificationCenterTopView = [[ZTMXFCertificationCenterTopView alloc]initWithFrame:CGRectMake(0, -X(115), KW, X(115))];
    }
    return _certificationCenterTopView;
}
- (ZTMXFCertificationListFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[ZTMXFCertificationListFooterView alloc] initWithFrame:CGRectMake(0, 0, KW, 210 * PX + 300)];
        _footerView.backgroundColor = K_BackgroundColor;
        //        [_footerView.submitBtn addTarget:self action:@selector(submitBtnAction1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}
@end
