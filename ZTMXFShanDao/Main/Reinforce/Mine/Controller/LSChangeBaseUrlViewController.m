//
//  LSChangeBaseUrlViewController.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/11/3.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSChangeBaseUrlViewController.h"
#import "NSString+RegexCategory.h"
#import "NSString+Additions.h"
#import "NSString+Trims.h"
@interface LSChangeBaseUrlViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField * textFieldUrl;
@property (nonatomic,strong) UIView * viCellView;
@property (nonatomic,strong) UILabel * lbTilteLb;
@property (nonatomic,strong) UILabel * lbPromptLb;

@property (nonatomic,strong) XLButton * btnSaveBtn;


@end

@implementation LSChangeBaseUrlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改请求地址";
    
    NSString * baseUrl = [[NSUserDefaults standardUserDefaults]objectForKey:BaseLocalSaveUrlKey];
    if ([baseUrl length]>0) {
        [self setNavgationBarRightTitle:@"复原"];
    }
    [self.view setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self.view addSubview:self.viCellView];
    [_viCellView addSubview:self.lbTilteLb];
    [_viCellView addSubview:self.textFieldUrl];
    [self.view addSubview:self.btnSaveBtn];
    [self.view addSubview:self.lbPromptLb];
    _textFieldUrl.left = _lbTilteLb.right;
    _textFieldUrl.width = _viCellView.width - _lbTilteLb.right -12*2;
    _btnSaveBtn.centerX = Main_Screen_Width/2.;
    _btnSaveBtn.top = _viCellView.bottom +60;
    _lbPromptLb.top = _viCellView.bottom+10;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textFieldUrl resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * editStr = [textField.text trimmingWhitespaceAndNewlines];
    _textFieldUrl.text = editStr;
}
-(void)right_button_event:(UIButton *)sender{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:BaseLocalSaveUrlKey];
    BOOL isDele = [[NSUserDefaults standardUserDefaults]synchronize];
    if (isDele) {
        [LoginManager clearUserInfo];
        [SVProgressHUD showWithStatus:@"修改成功请重新启动APP"];
        [SVProgressHUD dismissWithDelay:2 completion:^{
            exit(0);
        }];
        
    }
}
-(void)pgy_btnSaveBtnClick:(UIButton*)btn{
    [_textFieldUrl resignFirstResponder];
    btn.userInteractionEnabled = NO;
    NSString * editStr = [_textFieldUrl.text trimmingWhitespaceAndNewlines];
    if ([editStr length]>0&&[editStr isValidUrl]) {
        
        [[NSUserDefaults standardUserDefaults]setValue:editStr forKey:BaseLocalSaveUrlKey];
       BOOL isSave = [[NSUserDefaults standardUserDefaults] synchronize];
        if (isSave) {
            [LoginManager clearUserInfo];
            [SVProgressHUD showInfoWithStatus:@"修改成功请重新启动APP"];
            [SVProgressHUD dismissWithDelay:2 completion:^{
                exit(0);
            }];
        }else{
            [self.view makeCenterToast:@"修改失败请重新操作"];
        }
    } else if([editStr length]==0){
        [self.view makeCenterToast:@"输入不能为空"];
    } else if (![editStr isValidUrl]){
        
        [self.view makeCenterToast:@"请输入合法的IP"];
    }
    btn.userInteractionEnabled = YES;
}

-(UIView *)viCellView{
    if (!_viCellView) {
        _viCellView = [[UIView alloc]init];
        [_viCellView setFrame:CGRectMake(0, k_Navigation_Bar_Height+20, Main_Screen_Width, 44)];
        [_viCellView setBackgroundColor:[UIColor whiteColor]];
    }
    return _viCellView;
}
-(UILabel*)lbTilteLb{
    if (!_lbTilteLb) {
        _lbTilteLb = [[UILabel alloc]init];
        [_lbTilteLb setFont:[UIFont systemFontOfSize:16]];
        [_lbTilteLb setFrame:CGRectMake(12, 0, 60, 44)];
        [_lbTilteLb setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
        _lbTilteLb.textAlignment = NSTextAlignmentLeft;
        _lbTilteLb.text = @"修改";
    }
    return _lbTilteLb;
}
-(UILabel*)lbPromptLb{
    if (!_lbPromptLb) {
        _lbPromptLb = [[UILabel alloc]init];
        [_lbPromptLb setFont:[UIFont systemFontOfSize:13]];
        [_lbPromptLb setFrame:CGRectMake(12, 0, Main_Screen_Width-24, 44)];
        _lbPromptLb.numberOfLines = 0;
        [_lbPromptLb setTextColor:[UIColor colorWithHexString:COLOR_GRAY_STR]];
        _lbPromptLb.textAlignment = NSTextAlignmentLeft;
       NSString * prmStr = [NSString stringWithFormat:@"注：只能修改-测试包预发包的地址。原包为：%@",isAppOnline==0?@"测试包":@"预发包"];
        _lbPromptLb.text = prmStr;
        [_lbPromptLb sizeToFit];
    }
    return _lbPromptLb;
}
-(XLButton*)btnSaveBtn{
    if (!_btnSaveBtn) {
        _btnSaveBtn = [XLButton buttonWithType:UIButtonTypeCustom];
        [_btnSaveBtn setFrame:CGRectMake(0, 0, 260, 44)];
       
        [_btnSaveBtn setTitle:@"修改" forState:UIControlStateNormal];
        _btnSaveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _btnSaveBtn.clipsToBounds = YES;
        [_btnSaveBtn addTarget:self action:@selector(pgy_btnSaveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSaveBtn;
}
-(UITextField*)textFieldUrl{
    if (!_textFieldUrl) {
        _textFieldUrl = [[UITextField alloc]init];
        [_textFieldUrl setFrame:CGRectMake(0, 0, Main_Screen_Width, _viCellView.height)];
        _textFieldUrl.keyboardType = UIKeyboardTypeURL;
        _textFieldUrl.font = [UIFont systemFontOfSize:16];
        _textFieldUrl.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _textFieldUrl.delegate = self;
        _textFieldUrl.placeholder = BaseUrl;
    }
    return _textFieldUrl;
}

@end
