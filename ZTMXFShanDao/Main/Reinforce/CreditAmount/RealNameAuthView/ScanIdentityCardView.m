//
//  ScanIdentityCardView.m
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//

#import "ScanIdentityCardView.h"
#include "ZTMXFLabelTextFeild.h"
#import "UILabel+Attribute.h"
#import "ZTMXFShadowView.h"
#import "ZTMXFCreditxTextField.h"
@interface ScanIdentityCardView ()<UITextFieldDelegate>

/** 正面 */
@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *headLabel;

/** 识别出来的身份证号码和姓名 */
@property (nonatomic, strong) ZTMXFShadowView *identifyView;
@property (nonatomic, strong) ZTMXFLabelTextFeild  *nameTextField;
@property (nonatomic, strong) ZTMXFLabelTextFeild  *idNumberTextField;
@property (nonatomic, strong) UILabel *remindLabel;

@property (nonatomic, strong) UIView *lineView;

/** 反面 */
@property (nonatomic, strong) UIImageView *tailImageView;

@property (nonatomic, strong) UILabel *tailLabel;

/** 下一步 */
@property (nonatomic, strong) ZTMXFButton *nextButton;

@property (nonatomic, strong) UIImageView  *headImageViewBackground;
@property (nonatomic, strong) UIImageView  *tailImageViewBackground;

@end

@implementation ScanIdentityCardView



- (void)setupViews{
    
//    UILabel * mainTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 14, KW, 28 * PX)];
//    mainTitleLabel.text = @"请扫描身份证完成以下信息";
//    mainTitleLabel.font = FONT_LIGHT(20 * PX);
//    mainTitleLabel.textColor = COLOR_SRT(@"#333333");
//    [self addSubview:mainTitleLabel];
//
//    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainTitleLabel.left, mainTitleLabel.bottom + 5, KW, 20 * PX)];
//    titleLabel.text = @"拍摄时请确保身份证边框完整 字迹均衡";
//    titleLabel.font = FONT_Regular(14 * PX);
//    titleLabel.textColor = COLOR_SRT(@"#999999");
//    [self addSubview:titleLabel];
//
    UIView * topGaryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KW, 363 * PX)];
    topGaryView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topGaryView];
    
    self.headImageView = [UIImageView setupImageViewWithImageName:@"JZ_RZ_IDCard_Scan_Behind" withSuperView:topGaryView];
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * headImageTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageTapGRAction)];
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:headImageTapGR];
    
    self.headImageViewBackground = [UIImageView setupImageViewWithImage:[self headBackgroundImage] withSuperView:self.headImageView];
    self.headImageViewBackground.contentMode = UIViewContentModeScaleAspectFill;
    
    
    UIView * whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    self.remindLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    self.remindLabel.backgroundColor = [UIColor whiteColor];
    self.remindLabel.text = @"    *如身份信息错误，请点击修改，否则无法通过认证";
    [self addSubview:self.remindLabel];
    [UILabel attributeWithLabel:self.remindLabel text:self.remindLabel.text textColor:@"4A4A4A" attributes:@[@"*"] attributeColors:@[K_GoldenColor]];
    _remindLabel.font = FONT_Medium(14 * PX);

    self.nameTextField = [[ZTMXFLabelTextFeild alloc] init];
    self.nameTextField.inputText = @"";
    self.nameTextField.leftTitle = @"姓名";
//    self.nameTextField.rightImageStr = @"creditEdit";
    self.nameTextField.titleMargin = 25.0;
    self.nameTextField.leftLabel.textColor = [UIColor colorWithHexString:COLOR_LIGHT_STR];
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.bottomLineView.hidden = YES;
    //氪信input
    self.nameTextField.inputTextField.inputActionName = CXInputVerifyIDName;
    [self.nameTextField.inputTextField addTarget:self action:@selector(nameTextFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    [whiteView addSubview:self.nameTextField];
    self.nameTextField.inputTextField.delegate = self;
    [self.nameTextField.rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventAllEvents];
    
    self.idNumberTextField = [[ZTMXFLabelTextFeild alloc] init];
    self.idNumberTextField.inputText = @"";
    self.idNumberTextField.leftTitle = @"身份证";
    self.idNumberTextField.titleMargin = 10.0;
    self.idNumberTextField.backgroundColor = [UIColor whiteColor];
    self.idNumberTextField.leftLabel.textColor = [UIColor colorWithHexString:COLOR_LIGHT_STR];
    self.idNumberTextField.bottomLineView.hidden = YES;
    self.idNumberTextField.userInteractionEnabled = NO;
    //氪信input
    self.idNumberTextField.inputTextField.inputActionName = CXInputVerifyIDIdentity;
    [whiteView addSubview:self.idNumberTextField];
    
    self.lineView = [UIView setupViewWithSuperView:whiteView withBGColor:@"#F5F5F5"];
    
    self.tailImageView = [UIImageView setupImageViewWithImageName:@"JZ_RZ_IDCard_Scan_Front" withSuperView:topGaryView];
    self.tailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _tailImageView.userInteractionEnabled = YES;
//    self.tailButton = [UIButton setupButtonWithSuperView:self withObject:self action:@selector(tailButtonAction)];
    UITapGestureRecognizer * tailImageTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tailImageTapGRAction)];
    [_tailImageView addGestureRecognizer:tailImageTapGR];
    
    self.tailImageViewBackground = [UIImageView setupImageViewWithImage:[self headBackgroundImage] withSuperView:self.tailImageView];
    //    self.tailImageViewBackground.backgroundColor = UIColor.redColor;
    //    self.headImageViewBackground.backgroundColor = UIColor.redColor;
    self.tailImageViewBackground.contentMode = UIViewContentModeScaleAspectFill;
    self.tailImageViewBackground.hidden = self.headImageViewBackground.hidden = YES;
    
    UIButton * promptBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //promptBtn.frame = CGRectMake(23, whiteView.bottom + X(10), X(18), X(18));
    [promptBtn setImage:[UIImage imageNamed:@"XL_JX_TiShi"] forState:UIControlStateNormal];
    [promptBtn setTitle:@"" forState:UIControlStateNormal];
    [promptBtn setTitleColor:COLOR_SRT(@"#999999") forState:UIControlStateNormal];
    promptBtn.userInteractionEnabled = NO;
    [self addSubview:promptBtn];
    
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.text = @"温馨提示：所有信息只用于平台信息认证, 请放心填写";
    descLabel.font = FONT_Regular(12 * PX);
    descLabel.textColor = COLOR_SRT(@"#999999");
    [self addSubview:descLabel];
    
    self.nextButton = [ZTMXFButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nextButton];
    
    _headImageView.sd_layout
    .topSpaceToView(topGaryView, X(14))
    .centerXEqualToView(topGaryView)
    .widthIs(KW - X(84))
    .heightIs(158 * PX);
    _headImageView.sd_cornerRadius = @4;
    
    _headImageViewBackground.sd_layout
    .leftEqualToView(_headImageView)
    .rightEqualToView(_headImageView)
    .topEqualToView(_headImageView)
    .bottomEqualToView(_headImageView);
    
    _tailImageView.sd_cornerRadius = @4;

    //
    _tailImageView.sd_layout
    .topSpaceToView(_headImageView, X(14))
    .centerXEqualToView(topGaryView)
    .widthIs(KW - X(84))
    .heightIs(158 * PX);
    _tailImageView.sd_cornerRadius = @4;
    
    _tailImageViewBackground.sd_layout
    .leftEqualToView(_tailImageView)
    .rightEqualToView(_tailImageView)
    .topEqualToView(_tailImageView)
    .bottomEqualToView(_tailImageView);

    self.nextButton.sd_layout
    .leftSpaceToView(self, X(20))
    .rightSpaceToView(self, X(20))
    .bottomSpaceToView(self, X(15))
    .heightIs(42 * PX);
    self.nextButton.sd_cornerRadius = @(self.nextButton.height/2);
    
    whiteView.sd_layout
    .leftEqualToView(topGaryView)
    .rightEqualToView(topGaryView)
    .topSpaceToView(topGaryView, 47 * PX)
    .heightIs(99 * PX);
    
    self.nameTextField.sd_layout
    .leftSpaceToView(whiteView, X(18))
    .rightSpaceToView(whiteView, X(30))
    .heightIs(52 * PX)
    .topEqualToView(whiteView);
    
    _idNumberTextField.sd_layout
    .leftEqualToView(_nameTextField)
    .rightEqualToView(_nameTextField)
    .bottomEqualToView(whiteView)
    .heightIs(52 * PX);

    _lineView.sd_layout
    .leftEqualToView(_idNumberTextField)
    .rightEqualToView(whiteView)
    .topEqualToView(_idNumberTextField)
    .heightIs(1);
    
    _remindLabel.sd_layout
    .leftSpaceToView(self, 0)
    .topSpaceToView(topGaryView, X(8))
    .heightIs(38 * PX)
    .widthIs(KW);
    
    //promptBtn.frame = CGRectMake(23, whiteView.bottom + X(10), X(18), X(18));
    //WithFrame:CGRectMake(promptBtn.right + X(5), whiteView.bottom + X(10), KW - 50, 18 * PX)
    promptBtn.sd_layout
    .leftSpaceToView(self, X(20))
    .topSpaceToView(whiteView, X(10))
    .heightIs(X(18))
    .widthIs(X(18));
    
    descLabel.sd_layout
    .leftSpaceToView(promptBtn, X(5))
    .topEqualToView(promptBtn)
    .heightIs(X(18))
    .widthIs(KW-50);
}

- (UIImage *)headBackgroundImage{
    //UIImage *watermarkImage = [UIImage imageNamed:@"XL_Privacy_Protection_BG"];
    //UIImage *angleImage = [UIImage imageNamed:@"XL_Privacy_Protection"];
    return [UIImage imageNamed:@"XL_Privacy_Protection_BG"];
}

- (void)rightButtonAction
{
    [self.nameTextField.inputTextField becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.nameTextField.inputTextField) {
        //后台打点
        [XLServerBuriedPointHelper xl_BuriedPointWithPointCode:@"xfd" PointSubCode:@"input.xfd_smrz_mzxg" OtherDict:nil];
    }
}

- (void)nameTextFieldValueChange:(UITextField *)textField{
    if (textField == self.nameTextField.inputTextField) {
        if (textField.text.length > 0) {
            self.nameTextField.rightImageStr = @"creditEdit";
        }else{
            self.nameTextField.rightImageStr = @"";
        }
    }
}

#pragma mark - 按钮点击事件
/** 正面点击 */

- (void)headImageTapGRAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanIdentityCardViewClickHead)]) {
        [self.delegate scanIdentityCardViewClickHead];
        //消费贷face++识别身份证正面
        [ZTMXFUMengHelper mqEvent:k_Idcard_front_faceplus_xf];
    }
}
/** 反面点击 */

- (void)tailImageTapGRAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanIdentityCardViewClickTail)]) {
        [self.delegate scanIdentityCardViewClickTail];
        //消费贷face++识别身份证反面
        [ZTMXFUMengHelper mqEvent:k_idcard_backside_faceplus_xf];
    }
}


///** 正面点击 */
//- (void)headButtonAction{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(scanIdentityCardViewClickHead)]) {
//        [self.delegate scanIdentityCardViewClickHead];
//    }
//}
//
///** 反面点击 */
//- (void)tailButtonAction{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(scanIdentityCardViewClickTail)]) {
//        [self.delegate scanIdentityCardViewClickTail];
//    }
//}

/** 点击下一步 */
- (void)nextButtonAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scanIdentityCardViewClickNextAction)]) {
        [self.delegate scanIdentityCardViewClickNextAction];
    }
}

/** 设置身份证正面 */
- (void)setHeadImage:(UIImage *)headImage{
    if (headImage) {
        self.headImageView.image = headImage;
        self.headImageViewBackground.hidden = NO;
    }
}
/** 设置身份证反面 */
- (void)setTailImage:(UIImage *)tailImage{
    if (tailImage) {
        self.tailImageView.image = tailImage;
        self.tailImageViewBackground.hidden = NO;
    }
}

/** 展示身份信息 */
- (void)showIdentityView{
    self.remindLabel.hidden = NO;
    self.identifyView.hidden = NO;

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setIdentityName:(NSString *)name{
    if (!kStringIsEmpty(name)) {
        self.nameTextField.rightImageStr = @"creditEdit";
        self.nameTextField.inputTextField.text = name;
    }else{
        self.nameTextField.rightImageStr = @"";
    }
}
- (void)setIdentityIdNumber:(NSString *)IdNumber{
    if (!kStringIsEmpty(IdNumber)) {
        self.idNumberTextField.inputTextField.text = IdNumber;
    }
}

/** 身份证名字 */
- (NSString *)identityEditName{
    return self.nameTextField.inputText;
}

/** 设置名字是否可编辑 */
- (void)realNameEdit:(BOOL)edit{
    if (edit) {
        self.nameTextField.inputTextField.userInteractionEnabled = YES;
    } else {
        self.nameTextField.inputTextField.userInteractionEnabled = NO;
    }
}

/** 清除页面信息 */
- (void)clearViewInfo{
    self.headImageView.image = [UIImage imageNamed:@"identity_head"];
    self.tailImageView.image = [UIImage imageNamed:@"identity_tail"];
    self.nameTextField.inputTextField.text = @"";
    self.idNumberTextField.inputTextField.text = @"";
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = K_LineColor;
        [self setupViews];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
