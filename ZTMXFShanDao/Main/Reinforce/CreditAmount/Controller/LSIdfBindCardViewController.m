//
//  LSIdfBindCardViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//
#define Bank_LongMax 30
#define Bank_longMin 14
#import "ZTMXFBinkCardTopView.h"
#import "LSIdfBindCardViewController.h"
#import "LSRealNameProgressView.h"
#import "LSInputRowCellView.h"
#import "LSIdCardTypeListViewController.h"
#import "LSWebViewController.h"

#import "RealNameManager.h"
#import "NSString+Base64.h"
#import "LSBankCardTypeModel.h"
#import "ZTMXFUserInfoModel.h"
#import "LSGainBankCodeApi.h"
#import "LSBindBankCardApi.h"
#import "LSAuthProgressView.h"
#import "SetupPayPasswordPopupView.h"

#import "LSAuthMaidianApi.h"
#import "GetUserInfoApi.h"
#import "LSBindCardSetPayPawApi.h"
#import "LSMyBankListViewController.h"
/**  1.6版本*/
#import "AuthenProgressView.h"
#import "ZTMXFCreditxTextField.h"

#import "CertificationProssView.h"
#import "LSChoiseBankCardViewController.h"
#import "UIButton+Attribute.h"
#import "LSLoanRepayViewController.h"
#import "LSLoanRenewalViewController.h"
#import "UILabel+Attribute.h"
@interface LSIdfBindCardViewController ()<UITextFieldDelegate,LSIdCardTypeListDelegate, SetupPayPasswordPopupViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) LSAuthProgressView * authProgressView;

@property (nonatomic,strong) LSInputRowCellView * viNameCell;
@property (nonatomic,strong) LSInputRowCellView * viBankIdCell;
@property (nonatomic,strong) LSInputRowCellView * viBankNameCell;
@property (nonatomic,strong) LSInputRowCellView * viIphoneCell;
@property (nonatomic,strong) LSInputRowCellView * viCodeCell;

@property (nonatomic,strong) UIButton * btnProtocolBtn;
@property (nonatomic,strong) UIButton * btnSubmitBtn;
@property (nonatomic,strong) UIButton * btnServiceBtn;
@property (nonatomic,strong) LSBankCardTypeModel * bankCardTypeModel;

@property(nonatomic,assign) NSInteger backDate;
@property (nonatomic,strong) NSTimer * timerCode;
/** 获得预留手机号 验证码*/
@property (nonatomic,copy) NSString * tradeNo;
@property (nonatomic,copy) NSString * bankId;
/** 身份证号 */
@property (nonatomic, copy) NSString *idNumber;

/**  1.6版本*/
@property (nonatomic, strong) AuthenProgressView    *progressView;

@property (nonatomic, strong) UILabel * topLabel;

@property (nonatomic ,strong) UILabel *label;


@end

@implementation LSIdfBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableAttributedString * titleStr = [[NSMutableAttributedString alloc] initWithString:@"绑定银行卡"];
//    [self set_Title:titleStr];
    //V1.3.4新增埋点友盟已添加
    [ZTMXFUMengHelper mqEvent:k_bankcard_page_pv_xf];
    self.title = @"银行卡认证";
    //键盘回收
    UITapGestureRecognizer * tapHeadGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHeadView)];
    [self.scrollView addGestureRecognizer:tapHeadGesture];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_WHITE_STR]];
    [self setupSubUI];
//    埋点
    if (_bindCardType == BindBankCardTypeMain) {
        LSAuthMaidianApi * authMaidianApi = [[LSAuthMaidianApi alloc]initWithType:AuthMaidianTypeBindBankCard];
        [authMaidianApi requestWithSuccess:^(NSDictionary *responseDict) {
            NSLog(@"提交");
        } failure:^(__kindof YTKBaseRequest *request) {
            
        }];
        //  设置不让侧滑
        self.fd_interactivePopDisabled = YES;
    }
//    获得真实姓名
    @WeakObj(self);
    
    GetUserInfoApi * userInfoApi = [[GetUserInfoApi alloc]init];
    [userInfoApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"]description];
        if ([codeStr isEqualToString:@"1000"]) {
            ZTMXFUserInfoModel * userModel = [ZTMXFUserInfoModel mj_objectWithKeyValues:responseDict[@"data"]];
            _viNameCell.textField.text = [userModel.realName base64DecodedString];
            if (userModel.bankStatus == 1) {
                selfWeak.bindCardType = 0;
                selfWeak.label.hidden = YES;
            }else{
                selfWeak.bindCardType = 1;
                selfWeak.label.hidden = [LoginManager appReviewState];
            }
            self.bindCardType = BindBankCardTypeMain;
           
        }else{
            
        }
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //氪信浏览统计
    [CreditXAgent onEnteringPage:CXPageNameBindDebitCard];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //氪信浏览统计
    [CreditXAgent onLeavingPage:CXPageNameBindDebitCard];
    [self hideKeyboard];
}

#pragma mark-  原生代理


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_viBankIdCell.textField == textField) {
        NSString *text = [textField text];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" "withString:@""];
        if ([text length] >= 20) {
            return NO;
        }
        
        NSString *newString =@"";
        while (text.length >0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        [textField setText:newString];
        return NO;

//        if (range.location >=Bank_LongMax&&![string isEqualToString:@""])
//        {
//            return NO;
//        }
    }else if (textField == _viIphoneCell.textField)
    {
        NSString *strMobile = [_viIphoneCell.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSRange rangeStr = [@"1234567890" rangeOfString:string];
        if ([string isEqualToString:@""]) { //删除字符
            return YES;
        }
        else
            if ([strMobile length] >= 11||rangeStr.length <=0) {
                return NO;
            }
            else
                if ((range.location == 3 &&[textField.text length]==3)|| (range.location == 8&&[textField.text length]== 8))
                {
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                }
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_viIphoneCell.textField == textField)
    {
        NSString *strMobile = [_viIphoneCell.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableString * mutStr = [[NSMutableString alloc]initWithString:strMobile];
        if ([mutStr length]>3)
        {
            [mutStr insertString:@" " atIndex:3];
        }
        if ([mutStr length]>8)
        {
            [mutStr insertString:@" " atIndex:8];
        }
        _viIphoneCell.textField.text = mutStr;
    }
}
#pragma mark-  自定义代理
#pragma mark -- 选择银行卡类型
-(void)didSelecteBankCardTypeWith:(LSBankCardTypeModel *)bankCardTypeModel{
    _bankCardTypeModel = bankCardTypeModel;
    _viBankNameCell.textField.text = bankCardTypeModel.bankName;
}
#pragma mark-  按钮方法
-(void)clickReturnBackEvent{
    if (_bindCardType == BindBankCardTypeCommon) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
//        直接返回根视图
        [RealNameManager realNameBackSuperVc:self];
    }
}



//选择银行卡类型
-(void)btnChooseNameBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled = NO;
    [self hideKeyboard];
    //氪信点击事件
    [CreditXAgent onClick:CXClickBindDebitCardSelectBank];
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_yhkrz_yh" OtherDict:nil];
    LSIdCardTypeListViewController * cardListVc = [[LSIdCardTypeListViewController alloc]init];
    cardListVc.oldBankTypeModel = _bankCardTypeModel;
    cardListVc.delegate = self;
    [self.navigationController pushViewController:cardListVc animated:YES];
    btn.userInteractionEnabled = YES;
}
//获得验证码
-(void)btnGainCodeBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled = NO;
    if ([self judgeIsInteraction]) {
        [SVProgressHUD showLoading];
        NSString *strMobile = [_viIphoneCell.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * idNumberStr = [_viBankIdCell.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        // 点击获取验证码埋点
        [self verificationCodeStatistics:strMobile];
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"click.xfd_yhkrz_yzm" OtherDict:nil];
        LSGainBankCodeApi * codeApi = [[LSGainBankCodeApi alloc]initWithCardNumber:idNumberStr andMobile:strMobile andBankCode:_bankCardTypeModel.bankCode andBankName:_bankCardTypeModel.bankName];
        [codeApi requestWithSuccess:^(NSDictionary *responseDict) {
            NSString * codeStr = [responseDict[@"code"]description];
            if ([codeStr isEqualToString:@"1000"]) {
                NSDictionary * dicData = responseDict[@"data"];
                _bankId = [dicData[@"bankId"]description];
                _tradeNo = [dicData[@"tradeNo"]description];
                _backDate = 60;
                _timerCode = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTimingCode) userInfo:nil repeats:YES];
                [_timerCode fire];
                
            }else{
                btn.userInteractionEnabled = YES;
            }
            [SVProgressHUD dismiss];

        } failure:^(__kindof YTKBaseRequest *request) {
            btn.userInteractionEnabled = YES;
            [SVProgressHUD dismiss];
        }];
    }
    else{
        btn.userInteractionEnabled = YES;
    }
}
//查看协议
-(void)btnProtocolBtnClick:(UIButton*)sender{
    sender.userInteractionEnabled = NO;
    LSWebViewController * webVc = [[LSWebViewController alloc]init];
    webVc.webUrlStr =  DefineUrlString(serviceProtocol);
    [self.navigationController pushViewController:webVc animated:YES];
    sender.userInteractionEnabled = YES;
    [self hideKeyboard];
}

#pragma mark -  绑定银行卡
-(void)btnSubmitBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled = NO;
    [self hideKeyboard];
    if ([self judgeIsInteraction]) {
        if (![_viCodeCell.textField.text length]) {
           [self.view makeCenterToast:@"请填写短信验证码"];
            btn.userInteractionEnabled = YES;
        }else{
            [SVProgressHUD showLoading];
            LSBindBankCardApi * binkApi = [[LSBindBankCardApi alloc] initWithBankId:_bankId andVerifyCode:_viCodeCell.textField.text];
            [binkApi requestWithSuccess:^(NSDictionary *responseDict) {
                NSString * codeStr = [responseDict[@"code"]description];
                //氪信提交事件
                [CreditXAgent onSubmit:CXSubmitBindDebitCard result:[codeStr isEqualToString:@"1000"]?YES:NO withMessage:[codeStr isEqualToString:@"1000"]?@"成功":[responseDict[@"code"]description]?:@""];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setObject:[responseDict[@"msg"]description]?:@"" forKey:@"bankCardCertification"];
                [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"submit.xfd_yhkrz_bdcg" OtherDict:dict];
                if ([codeStr isEqualToString:@"1000"]) {
                    //V1.3.4新增埋点友盟已添加
                    [ZTMXFUMengHelper mqEvent:k_bankcard_success parameter:@{@"bankName":_viBankNameCell.textField.text}];
                    //  绑卡成功
                    NSDictionary * dicData = responseDict[@"data"];
                    NSInteger allowPayPwd = [dicData[@"allowPayPwd"] integerValue];
                    //  身份证号
                    NSString *idNumber = [dicData[@"idNumber"] description];
                    self.idNumber = idNumber;
                    if (_isSigning) {
                        for (UIViewController * VC in self.navigationController.childViewControllers) {
                            if ([VC isKindOfClass:[LSLoanRepayViewController class]] || [VC isKindOfClass:[LSLoanRenewalViewController class]]) {
                                [self.navigationController popToViewController:VC animated:YES];
                            }
                        }
                    }
                    if (_isAddBankCard) {
                        [kKeyWindow makeCenterToast:@"绑定银行卡成功"];
                        for (UIViewController * VC in self.navigationController.childViewControllers) {
                            if ([VC isKindOfClass:[LSMyBankListViewController class]] || [VC isKindOfClass:[LSChoiseBankCardViewController class]]) {
                                [self.navigationController popToViewController:VC animated:YES];
                            }
                        }
                    }else{
                        if (_bindCardType==BindBankCardTypeCommon) {
                            [kKeyWindow makeCenterToast:@"绑定银行卡成功"];
                            [self.navigationController popViewControllerAnimated:YES];
                        }else if (allowPayPwd  == 1) {
                            //  需要设置支付密码
                            SetupPayPasswordPopupView *setupPasswordView = [SetupPayPasswordPopupView popupView];
                            setupPasswordView.delegate = self;
                        } else {
                            [kKeyWindow makeCenterToast:@"绑定银行卡成功"];
                            [self.navigationController popViewControllerAnimated:YES];
                            // 跳转到芝麻信用
//                            [self jumpToAuthView];
                        }
                    }
                } else {
                    // 绑定银行卡失败
                    NSString *msg = [responseDict[@"msg"] description];
                    [self bindingBankCardFailureStatistics:msg];
                    //V1.3.4新增埋点友盟已添加
                    [ZTMXFUMengHelper mqEvent:k_bankcard_fail parameter:@{@"bankName":_viBankNameCell.textField.text,@"errorMessage":msg}];
                }
                btn.userInteractionEnabled = YES;
                [SVProgressHUD dismiss];
            } failure:^(__kindof YTKBaseRequest *request) {
                btn.userInteractionEnabled = YES;
                [SVProgressHUD dismiss];
            }];
        }
    }else{
        btn.userInteractionEnabled = YES;
    }
}
#pragma mark -- 客服
-(void)btnServiceBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled = NO;
    LSWebViewController *webVC = [[LSWebViewController alloc] init];
    webVC.webUrlStr = DefineUrlString(serviceCenter);
    [self.navigationController pushViewController:webVC animated:YES];
    btn.userInteractionEnabled = YES;
}
#pragma mark - 设置支付密码
/** 点击跳过 */
- (void)setupPayPasswordClickSkip:(SetupPayPasswordPopupView *)setupPayPasswordPopupView
{
    [setupPayPasswordPopupView dismiss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });

//    [self jumpToAuthView];
}

/** 密码输入完成 */
- (void)setupPayPasswordCompleteInputPassword:(NSString *)password{
    [self setupPayPasswordWithPassword:password idNumber:self.idNumber];
}

/** 跳转到认证页面 */
- (void)jumpToAuthView{
    if (self.loanType == MallPurchaseType) {
        //  消费分期绑卡
//        [RealNameManager realNameBackSuperVc:self];
    } else {
        // 芝麻信用
//        [RealNameManager realNameWithCurrentVc:self andRealNameProgress:RealNameProgressOperatorAuth isSaveBackVcName:NO loanType:self.loanType];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark-  私有方法
-(void)tapGestureHeadView{
    [self hideKeyboard];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeyboard];
}

//  设置支付密码
- (void)setupPayPasswordWithPassword:(NSString *)password idNumber:(NSString *)idNumber{
    [SVProgressHUD showLoading];
    LSBindCardSetPayPawApi * setPawApi = [[LSBindCardSetPayPawApi alloc] initWithIdNumber:idNumber andPaw:password];
    [setPawApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSString * codeStr = [responseDict[@"code"] description];
        if ([codeStr isEqualToString:@"1000"]) {
            //  支付密码设置成功(跳转到认证页面)
//            [self jumpToAuthView];
        }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 倒计时
-(void)timerTimingCode
{
    _backDate--;
    if (_backDate<=0)
    {
        _backDate = 60;
        [_viCodeCell.btnCodel setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timerCode invalidate];
        _timerCode = nil;
        _viCodeCell.btnCodel.userInteractionEnabled = YES;
    }
    else
    {
        NSString * title = [NSString stringWithFormat:@"%lds",(long)_backDate];
        [_viCodeCell.btnCodel setTitle:title forState:UIControlStateNormal];
    }
}
#pragma  mark - 判断交互
-(BOOL)judgeIsInteraction{
    [self hideKeyboard];
    NSString *strMobile = [_viIphoneCell.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * bankStr = _viBankIdCell.textField.text;
    if ([bankStr length]==0) {
        [self.view makeCenterToast:@"请填写银行卡号"];
    }else if ([bankStr length]<14) {
        [self.view makeCenterToast:@"银行卡号为14-30位数字"];
    } else if (!_bankCardTypeModel){
        [self.view makeCenterToast:@"请选择银行卡类型"];
    }else if ([strMobile length]==0) {
        [self.view makeCenterToast:@"请填写银行预留手机号码"];
    }else if ([strMobile length]!=11){
        [self.view makeCenterToast:@"手机号为11位数字"];
    }else if ([strMobile length]==11&&[bankStr length]>=Bank_longMin&&[bankStr length]<=Bank_LongMax){
        return YES;
    }
    return NO;
}
-(void)hideKeyboard{
    [_viBankIdCell.textField resignFirstResponder];
    [_viCodeCell.textField resignFirstResponder];
    [_viIphoneCell.textField resignFirstResponder];
}
-(UILabel*)labelPrompt{
    UILabel * lbPrompt = [[UILabel alloc]init];
    [lbPrompt setFont:[UIFont systemFontOfSize:15*kScreenWidthRatio]];
    lbPrompt.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    lbPrompt.height = 21.;
    return lbPrompt;
}
-(UIView*)viLineView{
    UIView * lineView = [[UIView alloc]init];
    [lineView setFrame:CGRectMake(0, 0, 315*kScreenWidthRatio, 1)];
    [lineView setBackgroundColor:[UIColor colorWithHexString:@"979797"]];
    return lineView;
}
#pragma mark - 添加子视图
-(void)setupSubUI{
    [self.view addSubview:self.scrollView];
    CGFloat bottomY = 0.0;
    CGFloat cellH = 50;
    CGFloat leftMargin = AdaptedWidth(17);
    
    
    ZTMXFBinkCardTopView *topView = [[ZTMXFBinkCardTopView alloc]initWithFrame:CGRectMake(0, 0, KW, X(64))];
    topView.title = @"请绑定本人名下有效银行卡，暂不支持信用卡";
    [_scrollView addSubview:topView];

    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, X(64), KW, 5 * cellH)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:whiteView];
//    持卡人
    _viNameCell = [[LSInputRowCellView alloc] initWithCellStyle:InputRowCellStyleNoEdit title:@"持卡人" value:@"张三" placeholder:@""];
    [_viNameCell setFrame:CGRectMake(0, 0, _scrollView.width, cellH)];
    _viCodeCell.contentMargin = leftMargin;
    //氪信input
    _viNameCell.textField.inputActionName = CXInputBindDebitCardName;
    _viNameCell.lineEdgeInsets = UIEdgeInsetsMake(0, X(12), 0, 0);
    [whiteView addSubview:_viNameCell];
    //    所属银行
    _viBankNameCell = [[LSInputRowCellView alloc]initWithCellStyle:InputRowCellStyleChoose title:@"所属银行" value:@"" placeholder:@"请选择所属银行"];
    [_viBankNameCell setFrame:CGRectMake(0, _viNameCell.bottom, _scrollView.width,cellH)];
    _viBankNameCell.textField.delegate = self;
    [_viBankNameCell.btnChoose addTarget:self action:@selector(btnChooseNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _viBankNameCell.lineEdgeInsets = UIEdgeInsetsMake(0, X(12), 0, 0);
    [whiteView addSubview:_viBankNameCell];
//    银行卡号
    _viBankIdCell = [[LSInputRowCellView alloc] initWithCellStyle:InputRowCellStyleDef title:@"银行卡号" value:@"" placeholder:@"请输入储蓄卡卡号"];
    [_viBankIdCell setFrame:CGRectMake(0, _viBankNameCell.bottom, _scrollView.width, cellH)];
    _viBankIdCell.textField.delegate = self;
    _viBankIdCell.textField.keyboardType = UIKeyboardTypeNumberPad;
    _viBankIdCell.lineEdgeInsets = UIEdgeInsetsMake(0, X(12), 0, 0);
    //氪信input
    _viBankIdCell.textField.inputActionName = CXInputBindDebitCardNumber;
    [whiteView addSubview:_viBankIdCell];
//    预留手机号
    _viIphoneCell = [[LSInputRowCellView alloc]initWithCellStyle:InputRowCellStyleDef title:@"预留手机号" value:@"" placeholder:@"请输入银行预留手机号"];
    [_viIphoneCell setFrame:CGRectMake(0, _viBankIdCell.bottom, _scrollView.width, cellH)];
    _viIphoneCell.textField.delegate = self;
    _viIphoneCell.textField.keyboardType = UIKeyboardTypeNumberPad;
    //氪信input
    _viIphoneCell.textField.inputActionName = CXInputBindDebitCardContactPhone;
    _viIphoneCell.lineEdgeInsets = UIEdgeInsetsMake(0, X(12), 0, 0);
    [whiteView addSubview:_viIphoneCell];
//    短信验证码
    _viCodeCell = [[LSInputRowCellView alloc]initWithCellStyle:InputRowCellStyleCode title:@"短信验证" value:@"" placeholder:@"请输入验证码"];
    [_viCodeCell setFrame:CGRectMake(0, _viIphoneCell.bottom, _scrollView.width, cellH)];
    _viCodeCell.textField.delegate = self;
    _viCodeCell.textField.keyboardType = UIKeyboardTypeNumberPad;
    [_viCodeCell.btnCodel addTarget:self action:@selector(btnGainCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [_viCodeCell.textField addTarget:self action:@selector(viCodeCellTextFieldDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    bottomY = _viCodeCell.bottom;
    _viCodeCell.isHideLine = YES;
    [whiteView addSubview:_viCodeCell];
    
    
    UILabel *noticeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(leftMargin, whiteView.bottom + X(16), whiteView.width - X(32), X(17))];
    noticeLabel1.font = FONT_Regular(X(12));
    noticeLabel1.numberOfLines = 0;
    noticeLabel1.textColor = K_888888;
    noticeLabel1.text = @"温馨提示:";
    noticeLabel1.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:noticeLabel1];
    
    UILabel *noticeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(leftMargin, noticeLabel1.bottom + X(6), whiteView.width - X(32), X(17))];
    noticeLabel2.font = FONT_Regular(X(12));
    noticeLabel2.numberOfLines = 0;
    noticeLabel2.textColor = K_888888;
    noticeLabel2.text = @"1. 所有信息将只用于平台信息认证，请放心填写。";
    noticeLabel2.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:noticeLabel2];
    
    UILabel *noticeLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(leftMargin, noticeLabel2.bottom + X(6), whiteView.width - X(16), X(17))];
    noticeLabel3.font = FONT_Regular(X(12));
    noticeLabel3.numberOfLines = 0;
    noticeLabel3.textColor = K_888888;
    noticeLabel3.text = @"2.运营商认证将对该手机号进行认证，请确保该手机号正常使用。";
    noticeLabel3.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:noticeLabel3];

   
    [_scrollView addSubview:self.btnProtocolBtn];
    
    
    
    //    提交
    [_scrollView addSubview:self.btnSubmitBtn];
    _btnSubmitBtn.top = noticeLabel3.bottom + 118 * PX;
    
    _btnProtocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_btnProtocolBtn setFrame:CGRectMake(0, _btnSubmitBtn.bottom + X(8), whiteView.width, 30)];
    [UIButton attributeWithBUtton:self.btnProtocolBtn title:@"提交绑卡代表您已阅读并同意《闪到服务协议》" titleColor:@"#9F9F9F" forState:UIControlStateNormal attributes:@[@"《闪到服务协议》"] attributeColors:@[K_2B91F0]];
    
    self.label = [[UILabel alloc] init];
    self.label.hidden = YES;
    self.label.font = FONT_Regular(12);
    self.label.numberOfLines = 0;
    [UILabel attributeWithLabel:_label text:@"后续的运营商认证流程中会对您该卡的预留手机号码进行认证，如该号码不常用，可能会影响您的认证结果。" textColor:@"9f9f9f" attributes:@[@"您该卡的预留手机号码进行认证"] attributeColors:@[K_GoldenColor]];
    //[_scrollView addSubview:self.label];
    _label.frame = CGRectMake(_btnSubmitBtn.left, _btnProtocolBtn.bottom + 8 * PX, _btnSubmitBtn.width, 150 * PX);
    [_label sizeToFit];
   
    
    if ([LoginManager appReviewState]) {
        _btnProtocolBtn.hidden = YES;
    }
    _scrollView.contentSize = CGSizeMake(KW, _label.bottom + 1);
}
- (void)viCodeCellTextFieldDidBegin:(ZTMXFCreditxTextField *)textField{
    //后台打点
    [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"input.xfd_yhkrz_yzm" OtherDict:nil];
}
#pragma mark - 设置子视图
- (LSAuthProgressView *)authProgressView{
    if (_authProgressView == nil) {
        _authProgressView = [[LSAuthProgressView alloc] init];
        [_authProgressView setFrame:CGRectMake(0,0, Main_Screen_Width, AdaptedHeight(44.0))];
        [_authProgressView switchRealNameAuth];
    }
    return _authProgressView;
}
#pragma mark - setter getter
- (AuthenProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[AuthenProgressView alloc] init];
        _progressView.frame = CGRectMake(0.0, 0.0, Main_Screen_Width, 45.0);
    }
    return _progressView;
}
-(UIScrollView*)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _scrollView.backgroundColor = K_LineColor;
        [_scrollView setFrame:CGRectMake(0, k_Navigation_Bar_Height, Main_Screen_Width, Main_Screen_Height-TabBar_Addition_Height - k_Navigation_Bar_Height)];
    }
    return _scrollView;
}

-(UIButton*)btnProtocolBtn{
    if (!_btnProtocolBtn) {
        _btnProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_btnProtocolBtn setFrame:CGRectMake(0, 0, 80*kScreenWidthRatio, 40*kScreenWidthRatio)];
        [_btnProtocolBtn.titleLabel setFont:FONT_Regular(12 * PX)];
        [_btnProtocolBtn addTarget:self action:@selector(btnProtocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnProtocolBtn;
}
-(UIButton*)btnSubmitBtn{
    if (!_btnSubmitBtn) {
        _btnSubmitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSubmitBtn setFrame:CGRectMake(20, 0, KW - 40, AdaptedWidth(44))];
        _btnSubmitBtn.centerX = _scrollView.width/2.;
        [_btnSubmitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        [_btnSubmitBtn setTitleColor:K_BtnTitleColor forState:UIControlStateNormal];
//        if (self.bindCardType == BindBankCardTypeCommon || _isAddBankCard) {
//            [_btnSubmitBtn setTitle:@"确定" forState:UIControlStateNormal];
//        }
        _btnSubmitBtn.backgroundColor = K_MainColor;
        [_btnSubmitBtn addTarget:self action:@selector(btnSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnSubmitBtn.layer setCornerRadius:_btnSubmitBtn.height/2];
        _btnSubmitBtn.clipsToBounds = YES;
    }
    return _btnSubmitBtn;
}
-(UIButton*)btnServiceBtn{
    if (!_btnServiceBtn) {
        //    跳转客服
        _btnServiceBtn = [UIButton setupButtonWithSuperView:_scrollView withObject:self action:@selector(btnServiceBtnClick:)];
        [_btnServiceBtn setFrame:CGRectMake(0, 0, 200, 44)];
        _btnServiceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        NSString * strService = @"认证遇到问题，点击这里>>";
        _btnServiceBtn.titleLabel.textColor = [UIColor colorWithHexString:@"bcbcbc"];
        NSMutableAttributedString * attService = [[NSMutableAttributedString alloc] initWithString:strService];
        [attService addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"4990e2"] range:[strService rangeOfString:@"点击这里>>"]];
        [_btnServiceBtn setAttributedTitle:attService forState:UIControlStateNormal];
    }
    return _btnServiceBtn;
}

#pragma mark - 绑卡成功
- (void)bindingBankCardSuccessStatistics{

}

#pragma mark - 绑卡失败
- (void)bindingBankCardFailureStatistics:(NSString *)errorInfo{
   

}

#pragma mark - 点击获取验证码
- (void)verificationCodeStatistics:(NSString *)phone{
    [ZTMXFUMengHelper mqEvent:k_bankcard_getcode_xf parameter:@{@"bankPhone":phone}];
}

@end
