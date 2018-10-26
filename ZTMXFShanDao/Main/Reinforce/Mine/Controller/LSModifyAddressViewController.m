//
//  LSModifyAddressViewController.m
//  YWLTMeiQiiOS
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSModifyAddressViewController.h"
#import "LSReceivingView.h"
#import "LSAddressModel.h"
#import "ModifyAddressApi.h"
#import "MyAddressViewModel.h"

@interface LSModifyAddressViewController () <BBBaseViewControllerDelegate,UIAlertViewDelegate,LSAddressViewModelDelegate,LSReceivingViewDelegete>

@property (nonatomic, strong) LSReceivingView *receiveView;

@property (nonatomic, strong) XLButton *bottomButton;

@property (nonatomic, strong) UIButton *defaultAddressBtn;

@property (nonatomic, strong) MyAddressViewModel *myAddressViewModel;

/** 省、市、区*/
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *region;

@end

@implementation LSModifyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"";
    if (self.addressType == LSAddAddressType) {
        str = @"添加新地址";
    }else if (self.addressType == LSModifyAddressType){
        str = @"修改地址";
    }else if (self.addressType == LSWriteAddressType){
        str = @"填写地址";
    }
    self.title = str;
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    
    [self configueSubViews];
}

#pragma mark - 点击右侧导航按钮
-(void)right_button_event:(UIButton *)sender{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认删除该地址吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 点击取消
    }else if (buttonIndex == 1){
        // 点击确认,删除地址
        // 删除地址,请求接口
        NSDictionary *paramsDict = @{@"opera":@"delete",@"id":@(_addressModel.addressId)};
        [self.myAddressViewModel requestModifyAddressDataWithDict:paramsDict];
    }
}

#pragma mark - LSAddressViewModelDelegate
#pragma mark - 修改地址成功的回调
- (void)modifyAddressSuccess{
    //
    [self.view makeCenterToast:@"操作成功"];
    if (self.addressType == LSWriteAddressType) {
        if (self.delegete && [self.delegete respondsToSelector:@selector(writeAddressSuccess)]) {
            [self.delegete writeAddressSuccess];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 删除地址成功的回调
- (void)deleteAddressSuccess{
    [self.view makeCenterToast:@"操作成功"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - LSReceivingViewDelegete
-(void)updateAddressWithProvice:(NSString *)provice city:(NSString *)city region:(NSString *)region{
    self.province = provice;
    self.city = city;
    self.region = region;
}

#pragma mark - 私有方法
#pragma mark - 点击设置默认地址
- (void)defaultAddressBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}

#pragma mark - 点击底部按钮
- (void)clickBottomBtn:(UIButton *)sender{
    if (_receiveView.textName.text.length == 0) {
        [self.view makeCenterToast:@"请填写收件人！"];
        return;
    }
    if (_receiveView.phoneNum.text.length != 11) {
        [self.view makeCenterToast:@"请填写正确的联系电话！"];
        return;
    }
    if (_receiveView.choosedAreaLabel.text.length == 0 || [_receiveView.choosedAreaLabel.text isEqualToString:@"请选择所属地区"]) {
        [self.view makeCenterToast:@"请填写所在地区！"];
        return;
    }
    if (_receiveView.detailArea.text.length == 0) {
        [self.view makeCenterToast:@"请填写详细地址！"];
        return;
    }
    // 设置参数
    NSString *operaStr = @"";
    int isDefault = 0;
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionaryWithDictionary:@{@"consignee":_receiveView.textName.text,@"consigneeMobile":_receiveView.phoneNum.text,@"province":self.province,@"city":self.city,@"region":self.region,@"detailAddress":_receiveView.detailArea.text}];
    
    if (self.addressType == LSAddAddressType || self.addressType == LSWriteAddressType) {
        operaStr = @"add";
        isDefault = _receiveView.defaultAddressSwitch.on ? 1 : 0;
        if (self.addressType == LSWriteAddressType) {
            [paramsDict setValue:self.orderId forKey:@"orderId"];
        }
    }else if (self.addressType == LSModifyAddressType){
        operaStr = @"update";
        isDefault = _receiveView.defaultAddressSwitch.on;
        [paramsDict setValue:@(_addressModel.addressId) forKey:@"id"];
    }
    [paramsDict setValue:operaStr forKey:@"opera"];
    [paramsDict setValue:@(isDefault) forKey:@"isDefault"];
    
    [self.myAddressViewModel requestModifyAddressDataWithDict:paramsDict];
}

#pragma mark -setter
- (void)setAddressModel:(LSAddressModel *)addressModel{
    _addressModel = addressModel;
    
    self.province = _addressModel.province;
    self.city = _addressModel.city;
    self.region = _addressModel.region;
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    [self.view addSubview:self.receiveView];
    [self.view addSubview:self.bottomButton];
    if (self.addressType == LSAddAddressType) {
      
    } else if (self.addressType == LSModifyAddressType) {
        if (_stepType != 1) {
            [self setNavgationBarRightTitle:@"删除"];
        }
    } else if (self.addressType == LSWriteAddressType){
       
        [_bottomButton setTitle:@"提交" forState:UIControlStateNormal];
    }
}

- (LSReceivingView *)receiveView{
    if (!_receiveView) {
        _receiveView = [[LSReceivingView alloc] initWithFrame:CGRectMake(0, k_Navigation_Bar_Height, SCREEN_WIDTH, AdaptedHeight(344))];
        _receiveView.delegete = self;
        
        [_receiveView.defaultAddressSwitch addTarget:self action:@selector(defaultAddressSwitchAction) forControlEvents:UIControlEventValueChanged];
        if (self.addressModel) {
            _receiveView.addressModel = _addressModel;
        }
    }
    return _receiveView;
}

- (void)defaultAddressSwitchAction
{
    _receiveView.defaultAddressSwitch.on = !_receiveView.defaultAddressSwitch.on;
}

- (XLButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [XLButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setFrame:CGRectMake(20, SCREEN_HEIGHT-70 * PX, SCREEN_WIDTH - 40, 44 * PX)];
        [_bottomButton setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
        [_bottomButton.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(18)]];
        [_bottomButton addTarget:self action:@selector(clickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

-(UIButton*)defaultAddressBtn{
    if (!_defaultAddressBtn) {
        _defaultAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultAddressBtn setFrame:CGRectMake(12, 0, 90, 20)];
        [_defaultAddressBtn setTitle:@"设为默认" forState:UIControlStateNormal];
        [_defaultAddressBtn setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        [_defaultAddressBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
        [_defaultAddressBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
        [_defaultAddressBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]] forState:UIControlStateHighlighted];
        [_defaultAddressBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
        _defaultAddressBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        
        _defaultAddressBtn.selected = NO;
        [_defaultAddressBtn addTarget:self action:@selector(defaultAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultAddressBtn;
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

