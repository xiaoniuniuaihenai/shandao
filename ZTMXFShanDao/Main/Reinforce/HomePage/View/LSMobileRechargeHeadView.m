//
//  LSMobileRechargeHeadView.m
//  ALAFanBei
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "LSMobileRechargeHeadView.h"
#import "UITextField+ResponseRange.h"
#import "MobileAttributionApi.h"
#import "NSString+Trims.h"
#import "UIViewController+Visible.h"

#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "WJYAlertView.h"
@interface LSMobileRechargeHeadView ()<UITextFieldDelegate,CNContactPickerDelegate,CNContactViewControllerDelegate,ABPeoplePickerNavigationControllerDelegate>
@property (weak,nonatomic) id delegate;
@property (nonatomic,strong) UIView * viLineView;
@property (nonatomic,copy  ) NSString* mobileName;
@property (nonatomic,copy  ) NSString * mobileOld;
@property (nonatomic,copy)   NSString * defUserMobile; //默认手机号
@property (nonatomic,strong) UIButton * btnAddressBtn;
@property (nonatomic,strong) UIButton * btnClearBtn;

@end

@implementation LSMobileRechargeHeadView
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initMobileRechargeHeadHeadWithDelegate:(id)delegate{
    if (self = [super init]) {

       _defUserMobile = [LoginManager userPhone];
        _mobileOld = @"-1";
        self.delegate = delegate;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, AdaptedWidth(65));
        [self viewDrawRect];
        self.mobileName = @"默认号码";
        
    }
    return self;

}
-(void)viewDrawRect{
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(AdaptedWidth(12),AdaptedWidth(10), (self.width-2*AdaptedWidth(12))-50, AdaptedWidth(25))];
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.font = [UIFont systemFontOfSize:AdaptedWidth(18)];
    _phoneTF.adjustsFontSizeToFitWidth = YES;
    _phoneTF.minimumFontSize = 17;
    _phoneTF.delegate = self;
    [self addSubview:_phoneTF];
    [_phoneTF addTarget:self action:@selector(tryTextFieldChangeDid)
           forControlEvents:UIControlEventEditingChanged];

//    手机号类型
    _lbMobileType = [[UILabel alloc] initWithFrame:CGRectMake(_phoneTF.left, _phoneTF.bottom, _phoneTF.width,AdaptedWidth(15))];
    _lbMobileType.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
    _lbMobileType.textAlignment = NSTextAlignmentLeft;
    _lbMobileType.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
    _lbMobileType.hidden = YES;
    [self addSubview:_lbMobileType];
    
//    进入通讯录
    _btnAddressBtn = [[UIButton alloc] initWithFrame:CGRectMake(_phoneTF.right, 18, 50, 37)];
    [_btnAddressBtn setImage:[UIImage imageNamed:@"addressBookIcon"] forState:UIControlStateNormal];
    [_btnAddressBtn addTarget:self action:@selector(btnAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnAddressBtn];
//    清空
    _btnClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(_phoneTF.right, 18, 50, 37)];
    [_btnClearBtn setImage:[UIImage imageNamed:@"addressClear"] forState:UIControlStateNormal];
    _btnClearBtn.hidden = YES;
    
    [_btnClearBtn addTarget:self action:@selector(btnClearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnClearBtn];
    
    
//    分割线
    _viLineView = [[UIView alloc]init];
    [_viLineView setFrame:CGRectMake(0, self.height-1, SCREEN_WIDTH-2*_phoneTF.left, 1)];
    [_viLineView setBackgroundColor:[UIColor colorWithHexString:COLOR_BORDER_STR]];
    [self addSubview:_viLineView];

    
}
-(void)setPhoneTFText:(NSString *)string anaMobileName:(NSString*)mobileName{
    self.mobileName = mobileName;
    NSString *strMobile = [string trimmingWhitespace];
    _phoneTF.text =[self changePhoneToLook:strMobile];
    [self judgeMobileFormat:strMobile editorEnd:YES];
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _btnAddressBtn.hidden = YES;
    _lbMobileType.hidden = YES;
    _btnClearBtn.hidden = textField.text.length>0?NO:YES;
    _lbMobileType.textColor = [UIColor colorWithHexString:COLOR_LIGHT_STR1];
    if ([_delegate respondsToSelector:@selector(mobileRechargeHeadViewWithMobileState:)]) {
        [_delegate mobileRechargeHeadViewWithMobileState:NO];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *strMobile = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
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
    
    return YES;
}


-(void)tryTextFieldChangeDid{
    
    NSString *strMobile = [_phoneTF.text trimmingWhitespace];
    _btnClearBtn.hidden = strMobile.length>0?NO:YES;
    
    if ([strMobile length]>=11) {
        _lbMobileType.textColor = [UIColor colorWithHexString:COLOR_LIGHT_STR1];
        //        [_phoneTF resignFirstResponder];
    }
    
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *strMobile = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self judgeMobileFormat:strMobile editorEnd:YES];
    _btnClearBtn.hidden = YES;
    _btnAddressBtn.hidden = NO;

}

#pragma mark - Actions

-(void)btnAddressBtnClick:(UIButton *)sender{
    [_phoneTF resignFirstResponder];
    [self CheckAddressBookAuthorization:^(bool isAuthorized){
        if(isAuthorized)
        {
            
            ABPeoplePickerNavigationController *vc = [[ABPeoplePickerNavigationController alloc] init];
            vc.peoplePickerDelegate = self;
            UIViewController * rootVc = [UIViewController currentViewController];
            [rootVc presentViewController:vc animated:YES completion:nil];
        }
        else
        {
            [WJYAlertView showTwoButtonsWithTitle:nil Message:@"请允许闪到访问手机通讯录，来选取充值号码" ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"取消" Click:^{
                
            } ButtonType:WJYAlertViewButtonTypeDefault ButtonTitle:@"去设置" Click:^{
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
        }
    }];
}

#pragma mark --- 通讯录
-(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error)
                                                         {
                                                             //                                                             NSLog(@"Error: %@", (__bridge NSError *)error);
                                                         }
                                                         else if (!granted)
                                                         {
                                                             
                                                             block(NO);
                                                         }
                                                         else
                                                         {
                                                             block(YES);
                                                         }
                                                         if(addressBook){
                                                             CFRelease(addressBook);
                                                         }
                                                     });
                                                 });
        
    }
    else
    {
        block(YES);
        if(addressBook){
            CFRelease(addressBook);}
    }
    
}
#pragma mark - <ios9
// ios7
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

// 在iOS7中选中一个联系人就会调用
// 返回一个BOOL值，NO代表不会进入到下一层（详情），YES代表会进入到下一层
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    return YES;
}

// ios8选中一个联系人就会调用 实现这个方法之后，控制器不会进入到下一层（详情），直接dismiss
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
//    NSLog(@"2222");
//}

// ios8选中某一个联系人的某一个属性时就会调用
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    [self displayPerson:person];
}
//获得选中person的信息
- (void)displayPerson:(ABRecordRef)person
{
    NSString* phone = @"";
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,kABPersonPhoneProperty);
    
    NSString * personName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString * preStr = @"";
    NSString * operatorStr = @"";
    NSLog(@"-   --===   %@",phoneNumbers);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        NSString * siteInfo = (__bridge_transfer NSString*)ABMultiValueCopyLabelAtIndex(phoneNumbers, 0);
        
        NSArray * siteInfoArr =  [siteInfo componentsSeparatedByString:@" "];
        if ([siteInfoArr count]==3) {
            preStr = siteInfoArr.firstObject;
            operatorStr = siteInfoArr.lastObject;
        }
        
        
    } else {
        phone = @"[None]";
    }
    personName = [personName length]>0?personName:@"";
    //可以把-、+86、空格这些过滤掉
    NSString *phoneStr = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneStr = [[phoneStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    [self setPhoneTFText:phoneStr anaMobileName:personName];
}


-(void)btnClearBtnClick:(UIButton *)btn{
    _phoneTF.text = @"";
    btn.hidden = YES;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - 获得手机号 地区
-(void)requestMobileGetSite:(NSString*)mobileStr andMobileName:(NSString*)mobileName{
    [SVProgressHUD showLoading];
//    先清空旧的值
    if ([_delegate respondsToSelector:@selector(gainMobileRechargeMoneyListWithMobileProvince:company:)]) {
        [_delegate gainMobileRechargeMoneyListWithMobileProvince:@"" company:@""];
    }
    
    _mobileOld = mobileStr;
    _lbMobileType.text = @"";
    self.mobileName = [mobileStr isEqualToString:_defUserMobile]?@"默认号码":mobileName;
    MobileAttributionApi *mineApi = [[MobileAttributionApi alloc] initWithMobile:mobileStr];
    [mineApi requestWithSuccess:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
        if (responseDict.allValues.count>0) {
    //        NSString * resultcode = [responseDict[@"areacode"]description];
            _lbMobileType.hidden = NO;
    //        if ([resultcode isEqualToString:@"200"]) {
                _lbMobileType.textColor = [UIColor colorWithHexString:COLOR_LIGHT_STR1];
    //            NSDictionary * resultDic = responseDict[@"result"];
            NSDictionary * resultDic = responseDict;
            NSString * companyStr = [resultDic[@"company"]description]; //运营商
            NSString * provinceStr = [resultDic[@"province"]description]; //省份
            if ([_delegate respondsToSelector:@selector(gainMobileRechargeMoneyListWithMobileProvince:company:)]) {
                [_delegate gainMobileRechargeMoneyListWithMobileProvince:provinceStr company:companyStr];
            }

            _lbMobileType.text = [NSString stringWithFormat:@"%@%@",provinceStr,companyStr];

    //        }else{
    //            _lbMobileType.text = @"运营商系统维护中，请稍后再试";
    //            _lbMobileType.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
    //        }
       }
        [SVProgressHUD dismiss];
    } failure:^(__kindof YTKBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark   ----
//手机号(原来-->展示)
- (NSString *)changePhoneToLook:(NSString *)phone
{
    if (phone.length==11) {
        NSString *str1 = [phone substringToIndex:3];
        NSString *str2 = [phone substringWithRange:NSMakeRange(3, 4)];
        NSString *str3 = [phone substringFromIndex:7];
        NSString *newPhone = [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
        return newPhone;
    }else{
        return nil;
    }
}
-(void)judgeMobileFormat:(NSString *)mobile editorEnd:(BOOL)editorEnd{
    //    获取运营商
    NSString *strMobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([strMobile length]==11&&[strMobile hasPrefix:@"1"]) {
        if (![strMobile isEqualToString:_mobileOld]) {
            [self requestMobileGetSite:strMobile andMobileName:@""];
        }else{
            _lbMobileType.hidden = NO;
        }
        if (_delegate&&[_delegate respondsToSelector:@selector(mobileRechargeHeadViewWithMobileState:)]) {
            [_delegate mobileRechargeHeadViewWithMobileState:YES];
        }
    } else if([strMobile length]>0)
    {
        _lbMobileType.text = @"请输入正确的手机号码";
        _lbMobileType.hidden = NO;
        _lbMobileType.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
        if (_delegate&&[_delegate respondsToSelector:@selector(mobileRechargeHeadViewWithMobileState:)]) {
            [_delegate mobileRechargeHeadViewWithMobileState:NO];
        }
    }else{
        _lbMobileType.hidden = YES;
        _lbMobileType.textColor = [UIColor colorWithHexString:COLOR_LIGHT_STR1];
        //        空
        BOOL isSame = [strMobile isEqualToString:_mobileOld];
        if (!isSame&&editorEnd&&[_delegate respondsToSelector:@selector(gainMobileRechargeMoneyListWithMobileProvince:company:)]) {
            [_delegate gainMobileRechargeMoneyListWithMobileProvince:@"" company:@""];
        }
        if (_delegate&&[_delegate respondsToSelector:@selector(mobileRechargeHeadViewWithMobileState:)]) {
            [_delegate mobileRechargeHeadViewWithMobileState:NO];
        }
    }
    _mobileValue =strMobile;

}
-(void)layoutSubviews{
    [super layoutSubviews];
    _phoneTF.frame = CGRectMake(AdaptedWidth(12),AdaptedWidth(10), (self.width-2*AdaptedWidth(12))-50, AdaptedWidth(25));
    _phoneTF.responseRange = UIEdgeInsetsMake(0, 0, self.height, _phoneTF.right);
    _lbMobileType.frame = CGRectMake(_phoneTF.left, _phoneTF.bottom, _phoneTF.width,AdaptedWidth(15));
    _btnAddressBtn.frame = CGRectMake(0, 0, AdaptedWidth(25), AdaptedWidth(25));
    _btnAddressBtn.right = self.width-AdaptedWidth(12);
    _btnAddressBtn.centerY = self.height/2.;
    _btnClearBtn.bounds = CGRectMake(0, 0, AdaptedWidth(25), 25);
    _btnClearBtn.center = _btnAddressBtn.center;
    _phoneTF.width = _btnAddressBtn.left - _phoneTF.left-AdaptedWidth(10);
    [_viLineView setFrame:CGRectMake(_phoneTF.left, self.height-1, self.width-2*_phoneTF.left, 1)];
    _viLineView.bottom = self.height;
}

@end
