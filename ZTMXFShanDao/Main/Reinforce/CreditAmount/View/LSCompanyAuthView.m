//
//  LSCompanyAuthView.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSCompanyAuthView.h"
#import "AddressPickerView.h"
#import "LSCompanyInfoModel.h"

@interface LSCompanyAuthView () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *mainView;

@property (nonatomic, strong) UIView *otherIndustryView;

@property (nonatomic, strong) UIView *centerView;

@property (nonatomic, strong) UIView *bottomView;

/**  下一步按钮 */
@property (nonatomic, strong) XLButton *btnNextBtn;

@end

@implementation LSCompanyAuthView



#pragma mark - 点击行业按钮
- (void)clickTextFieldBtn:(UIButton *)sender{
    // 跳转到行业选择
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickTextFieldButon:)]) {
        [self.delegete clickTextFieldButon:sender.tag];
    }
}

#pragma mark - 点击选择地址按钮
- (void)clickAddressButton{
    [self endEditing:YES];
    AddressPickerView *pickerView = [AddressPickerView shareInstance];
    [pickerView showAddressPickView];
    pickerView.block = ^(NSString *province, NSString *city, NSString *district) {
        self.addressField.text = [NSString stringWithFormat:@"%@%@%@",province,city,district];
        if (self.delegete && [self.delegete respondsToSelector:@selector(chooseAeraWithProvice:city:region:)]) {
            [self.delegete chooseAeraWithProvice:province city:city region:district];
        }
    };
}

#pragma mark - 点击下一步按钮
- (void)btnNextBtnClick{
    if (self.delegete && [self.delegete respondsToSelector:@selector(clickNextStep)]) {
        [self.delegete clickNextStep];
    }
}

#pragma mark - 共有方法
- (void)chooseIndustry{
    if ([self.industryField.text isEqualToString:@"其他"]) {
        self.otherIndustryView.hidden = NO;
        self.otherIndustryView.top = 49.0;
        self.centerView.top = self.otherIndustryView.bottom;
    }else{
        self.otherIndustryView.hidden = YES;
        self.centerView.top = 49.0;
    }
    if ([self.positionField.text isEqualToString:@"其他"]) {
        self.otherPositionField.superview.hidden = NO;
    }else{
        self.otherPositionField.superview.hidden = YES;
    }
    self.bottomView.top = self.centerView.bottom;
    self.btnNextBtn.top = self.bottomView.bottom + 26.0;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - setter
-(void)setCompanyInfoModel:(LSCompanyInfoModel *)companyInfoModel{
    _companyInfoModel = companyInfoModel;
    if (_companyInfoModel) {
        self.industryField.text = _companyInfoModel.industry;
        self.companyField.text = _companyInfoModel.name;
        self.addressField.text = [NSString stringWithFormat:@"%@%@%@",_companyInfoModel.province,_companyInfoModel.city,_companyInfoModel.region];
        self.detailAddressField.text = _companyInfoModel.detailAddress;
        self.phoneField.text = _companyInfoModel.companyPhone;
        self.departmentField.text = _companyInfoModel.department;
        self.positionField.text = _companyInfoModel.position;
        
        [_btnNextBtn setTitle:@"保存" forState:UIControlStateNormal];
    }
}

#pragma mark - 设置子视图
- (void)configueSubViews{
    
    self.mainView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.mainView setBackgroundColor:[UIColor whiteColor]];
    self.mainView.showsVerticalScrollIndicator = NO;
    self.mainView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.mainView];

    // 行业
    UIView *industryView = [self createViewWithTitle:@"行业" isShowArrow:YES];
    self.industryField = (UITextField *)[industryView viewWithTag:1000];
    [self.mainView addSubview:industryView];
    industryView.top = 0.0;
    
    UIButton *industryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [industryBtn setFrame:CGRectMake(0, 0, industryView.width, industryView.height)];
    [industryBtn addTarget:self action:@selector(clickTextFieldBtn:) forControlEvents:UIControlEventTouchUpInside];
    industryBtn.tag = 1;
    [industryView addSubview:industryBtn];
    
    // 其他行业
    self.otherIndustryView = [self createViewWithTitle:@"" isShowArrow:NO];
    self.otherIndustryField = (UITextField *)[self.otherIndustryView viewWithTag:1000];
    [self.mainView addSubview:self.otherIndustryView];
    self.otherIndustryField.placeholder = @"请填写行业";
    self.otherIndustryView.top = 50.0;
    self.otherIndustryView.hidden = YES;
    
    // 中心view
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(0, industryView.bottom, SCREEN_WIDTH, 245)];
    self.centerView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.centerView];
    
    // 公司名称
    UIView *companyView = [self createViewWithTitle:@"公司名称" isShowArrow:NO];
    self.companyField = (UITextField *)[companyView viewWithTag:1000];
    [self.centerView addSubview:companyView];
    companyView.top = 0.0;
    
    // 公司地址
    UIView *addressView = [self createViewWithTitle:@"公司地址" isShowArrow:YES];
    self.addressField = (UITextField *)[addressView viewWithTag:1000];
    [self.centerView addSubview:addressView];
    self.addressField.placeholder = @"请选择省市区";
    addressView.top = companyView.bottom;
    
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addressBtn setFrame:CGRectMake(0, 0, addressView.width, addressView.height)];
    [addressBtn addTarget:self action:@selector(clickAddressButton) forControlEvents:UIControlEventTouchUpInside];
    [addressView addSubview:addressBtn];
    
    // 公司详细地址
    UIView *detailView = [self createViewWithTitle:@"" isShowArrow:NO];
    self.detailAddressField = (UITextField *)[detailView viewWithTag:1000];
    [self.centerView addSubview:detailView];
    detailView.top = addressView.bottom;
    
    // 公司电话
    UIView *phoneView = [self createViewWithTitle:@"公司电话" isShowArrow:NO];
    self.phoneField = (UITextField *)[phoneView viewWithTag:1000];
    [self.centerView addSubview:phoneView];
    phoneView.top = detailView.bottom;
    
    // 任职部门
    UIView *departmentView = [self createViewWithTitle:@"任职部门" isShowArrow:NO];
    self.departmentField = (UITextField *)[departmentView viewWithTag:1000];
    [self.centerView addSubview:departmentView];
    departmentView.top = phoneView.bottom;
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _centerView.bottom, SCREEN_WIDTH, 98)];
    [self.bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.mainView addSubview:self.bottomView];
    
    // 任职岗位
    UIView *positionView = [self createViewWithTitle:@"任职岗位" isShowArrow:YES];
    self.positionField = (UITextField *)[positionView viewWithTag:1000];
    [self.bottomView addSubview:positionView];
    positionView.top = 0.0;
    
    UIButton *positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [positionBtn setFrame:CGRectMake(0, 0, positionView.width, positionView.height)];
    [positionBtn addTarget:self action:@selector(clickTextFieldBtn:) forControlEvents:UIControlEventTouchUpInside];
    positionBtn.tag = 2;
    [positionView addSubview:positionBtn];
    
    // 其他任职岗位
    UIView *otherPositionView = [self createViewWithTitle:@"" isShowArrow:NO];
    self.otherPositionField = (UITextField *)[otherPositionView viewWithTag:1000];
    [self.bottomView addSubview:otherPositionView];
    otherPositionView.top = positionView.bottom;
    otherPositionView.hidden = YES;
    
    [self.mainView addSubview:self.btnNextBtn];
    self.btnNextBtn.top = self.bottomView.bottom + 26.0;
}

-(XLButton*)btnNextBtn{
    if (!_btnNextBtn) {
        _btnNextBtn = [XLButton buttonWithType:UIButtonTypeCustom];
        [_btnNextBtn setFrame:CGRectMake(0,0, AdaptedWidth(280), AdaptedWidth(44))];
        _btnNextBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
        _btnNextBtn.centerX = Main_Screen_Width/2.;
        [_btnNextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_btnNextBtn addTarget:self action:@selector(btnNextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNextBtn;
}

#pragma mark - 私有方法
- (UIView *)createViewWithTitle:(NSString *)title isShowArrow:(BOOL)showArrow{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 49.0)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(15) alignment:NSTextAlignmentLeft];
    [titleLabel setFrame:CGRectMake(12, 0, AdaptedWidth(75), 20)];
    titleLabel.centerY = view.height/2.;
    [titleLabel setText:title];
    [view addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(AdaptedWidth(87.0), 0, SCREEN_HEIGHT-AdaptedWidth(87.0)-26.0, 49)];
    textField.centerY = view.height/2.;
    [textField setFont:[UIFont systemFontOfSize:AdaptedWidth(15)]];
    [textField setTextColor:[UIColor colorWithHexString:COLOR_GRAY_STR]];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = [NSString stringWithFormat:@"请填写%@",title];
    textField.tag = 1000;
    [view addSubview:textField];
    
    if (showArrow) {
        UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 14)];
        arrowImgView.right = SCREEN_WIDTH-12.0;
        arrowImgView.centerY = view.height/2.;
        arrowImgView.image = [UIImage imageNamed:@"mine_right_arrow"];
        [view addSubview:arrowImgView];
    }
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(AdaptedWidth(87.0), view.height-1.0, SCREEN_WIDTH-AdaptedWidth(87.0)-12.0, 1.0)];
    [lineLabel setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [view addSubview:lineLabel];
    
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self configueSubViews];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.mainView.contentSize = CGSizeMake(0, self.btnNextBtn.bottom + 20.0);
}

@end
