//
//  MobileRechargeInfoView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MobileRechargeInfoView.h"
#import "LSMobileRechargeHeadView.h"
#import "LSChooseRechargeMoneyView.h"
#import "CreateRechargeOrderInfoModel.h"
#import "MobileRechargeInfoModel.h"
@interface MobileRechargeInfoView ()<LSChooseRechargeMoneyViewDelegate,LSMobileRechargeHeadViewDelegate>
@property(strong,nonatomic)UIScrollView *myScrollView;
@property(nonatomic,strong) LSMobileRechargeHeadView *headView;
@property (strong, nonatomic) LSChooseRechargeMoneyView *chooseMoneyView;
@property (strong, nonatomic) XLButton *btnSubmitBtn;
@property (strong, nonatomic) UILabel *lbTitleLb;

@property (strong, nonatomic) UILabel *lbPromptLb;

/**充值信息*/
@property (strong, nonatomic) CreateRechargeOrderInfoModel * createOrderModel;
@property (copy, nonatomic)NSString * province;
@property (copy, nonatomic)NSString * company;
@property (nonatomic,weak) id delegate;


@end
@implementation MobileRechargeInfoView
-(instancetype)initWithDelegate:(id)delegate{
    if (self = [super init]) {
        _delegate = delegate;
        
        _createOrderModel = [[CreateRechargeOrderInfoModel alloc]init];
        [self addSubviewUI];

    }
    return self;
}


#pragma mark --  LSMobileRechargeHeadViewDelegate
//手机号是否完整
-(void)mobileRechargeHeadViewWithMobileState:(BOOL)isFull{
    BOOL isEditor = [_createOrderModel.amount integerValue]>0?YES:NO;
    _btnSubmitBtn.selected = isFull&&isEditor?NO:YES;
    _btnSubmitBtn.userInteractionEnabled = !_btnSubmitBtn.selected;
    

}
//手机号信息 更改
-(void)gainMobileRechargeMoneyListWithMobileProvince:(NSString *)province company:(NSString *)company{
    if ([_delegate respondsToSelector:@selector(changeMobileInfoWithProvince:company:)]) {
        _province = province;
        if ([company isEqualToString:@"移动"]) {
            _company = @"1";
        }else if ([company isEqualToString:@"联通"]){
            _company = @"3";
        }else if ([company isEqualToString:@"电信"]){
            _company = @"2";
        }else{
            _company = @"";
        }
        if ([_province length]<=0||[_company length]<=0) {
            _btnSubmitBtn.userInteractionEnabled = NO;
            _btnSubmitBtn.selected = YES;
        }else{
            _btnSubmitBtn.userInteractionEnabled = YES;
            _btnSubmitBtn.selected = NO;
        }
        _createOrderModel.amount = @"";
        [_delegate changeMobileInfoWithProvince:province company:company];
        
    }
}
#pragma mark --- Action
-(void)btnSubmitBtnClick:(UIButton * )btn{
    btn.userInteractionEnabled = NO;
    [_headView.phoneTF resignFirstResponder];
    
    if ([LoginManager loginState]) {
        if ( [_createOrderModel.amount integerValue]<=0) {
            [kKeyWindow makeCenterToast:@"请选择充值金额"];
        }else if (![_createOrderModel.province length]){
            [kKeyWindow makeCenterToast:@"没有获取运营商"];
        }else if([_createOrderModel.mobile length]!=11){
            [kKeyWindow makeCenterToast:@"请输入正确的手机号"];
        }else if ([_delegate respondsToSelector:@selector(createMobileRechargeOrder:)]){
            //    生成订单
            [_delegate createMobileRechargeOrder:_createOrderModel];
            
        }
    }else{
        //        弹出登录
        UIViewController * superVc = (UIViewController *)_delegate;
        [LoginManager presentLoginVCWithController:superVc];
    }
    btn.userInteractionEnabled = YES;
    
}


//选中充值金额
-(void)chooseRechargeMoneyView:(LSChooseRechargeMoneyView *)rechargeMoneyView didSelect:(ZTMXFMobileRechargeMoneyModel*)modelSelect{
    _createOrderModel.amount = modelSelect.amount;
    [_headView.phoneTF resignFirstResponder];
}

#pragma mark -----
-(void)addSubviewUI{
    
    [self addSubview:self.myScrollView];
    [_myScrollView addSubview:self.headView];
    [_myScrollView addSubview:self.chooseMoneyView];
    [_myScrollView addSubview:self.btnSubmitBtn];
    [_myScrollView addSubview:self.lbTitleLb];
    [_myScrollView addSubview:self.lbPromptLb];
    
    if (@available(iOS 11.0, *)) {
        self.myScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _lbTitleLb.text = @"温馨提示：";
    NSString * mobileStr = [LoginManager userPhone];
    NSString * mobleNameStr = [mobileStr length]>0?@"默认手机号":@"";
    [_headView setPhoneTFText:mobileStr anaMobileName:mobleNameStr];
    [self configSubviewFrame];
    
}
-(void)configSubviewFrame{
    [_myScrollView setFrame:CGRectMake(0, 0, self.width, self.height)];
    [_headView setFrame:CGRectMake(0, 0, self.width, AdaptedWidth(65))];
    _chooseMoneyView.top =  _headView.bottom+AdaptedWidth(20);
    _chooseMoneyView.width = self.width;
    [_btnSubmitBtn setFrame:CGRectMake(0, _chooseMoneyView.bottom+AdaptedWidth(30), AdaptedWidth(280), AdaptedWidth(44))];
    _btnSubmitBtn.centerX = _myScrollView.width/2.;
    [_btnSubmitBtn.layer setCornerRadius:_btnSubmitBtn.height/2.];

    [_lbTitleLb setFrame:CGRectMake(AdaptedWidth(22), _btnSubmitBtn.bottom+AdaptedWidth(40), 200, 20)];
    
    _lbPromptLb.left = _lbTitleLb.left;
    _lbPromptLb.top = _lbTitleLb.bottom;
    _lbPromptLb.width = self.width - AdaptedWidth(44);
    [_lbPromptLb sizeToFit];

    if (_lbPromptLb.hidden) {
        _myScrollView.contentSize = CGSizeMake(0, _btnSubmitBtn.bottom+20);
    }else{
        _myScrollView.contentSize = CGSizeMake(0, _lbPromptLb.bottom+20);
    }
    
}
#pragma mark -- Get/Set
-(void)setRechargeInfoModel:(MobileRechargeInfoModel *)rechargeInfoModel{
    _rechargeInfoModel = rechargeInfoModel;
    _chooseMoneyView.arrPayMoneyArr = _rechargeInfoModel.rechargeList;
//    提交按钮是否可点击
    _btnSubmitBtn.selected  = YES;
    _btnSubmitBtn.userInteractionEnabled = NO;
//  更新充值信息
    _createOrderModel.province = _province;
    _createOrderModel.company = _company;
    _createOrderModel.amount = @"";
    if ([_rechargeInfoModel.rechargeList count]>0) {
        ZTMXFMobileRechargeMoneyModel * moneyModel = _rechargeInfoModel.rechargeList.firstObject;
        _createOrderModel.amount = moneyModel.amount;
        BOOL isEditor = [_headView.mobileValue length]==11?YES:NO;
        _btnSubmitBtn.selected  = !isEditor;
        _btnSubmitBtn.userInteractionEnabled = isEditor;
    }
    _createOrderModel.mobile = _headView.mobileValue;
//    提示信息
    NSString * promptStr = _rechargeInfoModel.rechargePrompt;
    BOOL isShowPrompt = [promptStr length]>0?NO:YES;
    _lbTitleLb.hidden = isShowPrompt;
    _lbPromptLb.hidden = isShowPrompt;
    _lbPromptLb.text = promptStr;
    
//    更新
    [self layoutSubviews];

}
-(UIScrollView * )myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc]init];
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _myScrollView;
}
-(LSMobileRechargeHeadView *)headView{
    if (!_headView) {
        _headView = [[LSMobileRechargeHeadView alloc] initMobileRechargeHeadHeadWithDelegate:self];
        
    }
    return _headView;
}
-(LSChooseRechargeMoneyView *)chooseMoneyView{
    if (!_chooseMoneyView) {
        _chooseMoneyView = [[LSChooseRechargeMoneyView alloc]init];
        _chooseMoneyView.delegate = self;
    }
    return _chooseMoneyView;
}
-(XLButton *)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [XLButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setTitle:@"立即充值" forState:UIControlStateNormal];
        [_btnSubmitBtn addTarget:self action:@selector(btnSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmitBtn;
}
-(UILabel *)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        [_lbTitleLb setFont:[UIFont systemFontOfSize:14]];
        _lbTitleLb.textColor = [UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR];
        _lbTitleLb.hidden = YES;
    }
    return _lbTitleLb;
}
-(UILabel *)lbPromptLb{
    if (!_lbPromptLb) {
        _lbPromptLb = [[UILabel alloc]init];
        [_lbPromptLb setFont:[UIFont systemFontOfSize:12]];
        _lbPromptLb.textColor = [UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR];
        _lbPromptLb.numberOfLines = 0;
        _lbPromptLb.hidden = YES;
    }
    return _lbPromptLb;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self configSubviewFrame];
}
@end
