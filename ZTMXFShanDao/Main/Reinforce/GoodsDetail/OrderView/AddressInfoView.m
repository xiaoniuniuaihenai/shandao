//
//  AddressInfoView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "AddressInfoView.h"
#import "LSAddressModel.h"

@interface AddressInfoView ()

/** 左侧图片 */
@property (nonatomic, strong) UIImageView *leftImageView;

/** 显示地址view */
@property (nonatomic, strong) UIView *showAddressView;
/** 用户名 */
@property (nonatomic, strong) UILabel *userNameLabel;
/** icon */
@property (nonatomic, strong) UIImageView *addressIcon;
/** 用户地址 */
@property (nonatomic, strong) UILabel *userAddressLabel;
/** 箭头按钮 */
@property (nonatomic, strong) UIButton *rowButton;

/** 显示地址view */
@property (nonatomic, strong) UIView *noAddressView;
/** icon */
@property (nonatomic, strong) UIImageView *noAddressIcon;
/** 没有地址描述 */
@property (nonatomic, strong) UILabel *noAddressLabel;
/** 添加地址按钮 */
@property (nonatomic, strong) UIButton *addAddressButton;

@end

@implementation AddressInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupViews{
    
    /** 左侧图片 */
    [self addSubview:self.leftImageView];
    
    /** 显示地址view */
    [self addSubview:self.showAddressView];
    /** 用户名 */
    [self.showAddressView addSubview:self.userNameLabel];
    /** icon */
    [self.showAddressView addSubview:self.addressIcon];
    /** 用户地址 */
    [self.showAddressView addSubview:self.userAddressLabel];
    /** 箭头 */
    [self.showAddressView addSubview:self.rowButton];
    
    /** 显示地址view */
    [self addSubview:self.noAddressView];
    /** icon */
    [self.noAddressView addSubview:self.noAddressIcon];
    /** 没有地址描述 */
    [self.noAddressView addSubview:self.noAddressLabel];
    /** 添加地址按钮 */
    [self.noAddressView addSubview:self.addAddressButton];
    self.noAddressView.hidden = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    
    /** 左侧图片 */
    self.leftImageView.frame = CGRectMake(AdaptedWidth(3), 0.0, AdaptedWidth(14), viewHeight);
    
    /** 显示地址view */
    CGFloat showAddressViewW = viewWidth - CGRectGetMaxX(self.leftImageView.frame) + 3.0;
    CGFloat showAddressViewX = CGRectGetMaxX(self.leftImageView.frame) - 3.0;
    if (self.leftImageView.isHidden) {
        showAddressViewX = 0.0;
    }
    self.showAddressView.frame = CGRectMake(showAddressViewX, 0.0, showAddressViewW, viewHeight);
    /** 用户名 */
    self.userNameLabel.frame = CGRectMake(AdaptedWidth(20.0), AdaptedHeight(16.0), showAddressViewW - 60.0, AdaptedHeight(22.0));
    /** icon */
    self.addressIcon.frame = CGRectMake(CGRectGetMinX(self.userNameLabel.frame), CGRectGetMaxY(self.userNameLabel.frame) + AdaptedHeight(6.0), AdaptedWidth(10.0), AdaptedHeight(20.0));
    /** 用户地址 */
    CGFloat userAddressLabelW = showAddressViewW - AdaptedWidth(50.0);
    CGFloat userAddressLabelH = [self.userAddressLabel.text sizeWithFont:self.userAddressLabel.font maxW:userAddressLabelW].height;
    self.userAddressLabel.frame = CGRectMake(CGRectGetMaxX(self.addressIcon.frame) + AdaptedWidth(4.0), CGRectGetMinY(self.addressIcon.frame), userAddressLabelW, userAddressLabelH);
    /** 箭头 */
    self.rowButton.frame = CGRectMake(0.0, 0.0, showAddressViewW - AdaptedWidth(12.0), viewHeight);
    
    /** 显示地址view */
    CGFloat noAddressViewW = viewWidth - CGRectGetMaxX(self.leftImageView.frame) + 3.0;
    self.noAddressView.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame) - 3.0, 0.0, noAddressViewW, viewHeight);
    /** icon */
    self.noAddressIcon.frame = CGRectMake(AdaptedWidth(20.0), 0.0, AdaptedWidth(10.0), viewHeight);
    /** 没有地址描述 */
    self.noAddressLabel.frame = CGRectMake(CGRectGetMaxX(self.noAddressIcon.frame) + AdaptedWidth(10.0), 0.0, AdaptedWidth(180.0), viewHeight);
    /** 添加地址按钮 */
    CGFloat addAddressButtonW = AdaptedWidth(100.0);
    CGFloat addAddressButtonH = AdaptedHeight(34.0);
    CGFloat addAddressButtonY = (viewHeight - addAddressButtonH) / 2.0;
    self.addAddressButton.frame = CGRectMake(noAddressViewW - addAddressButtonW - AdaptedWidth(12.0), addAddressButtonY, addAddressButtonW, addAddressButtonH);
    self.addAddressButton.layer.cornerRadius = addAddressButtonH / 2.0;

}

#pragma mark - getter/setter
/** 左侧图片 */
- (UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.image = [UIImage imageNamed:@"addresss_left_icon"];
    }
    return _leftImageView;
}

/** 显示地址view */
- (UIView *)showAddressView{
    if (_showAddressView == nil) {
        _showAddressView = [[UIView alloc] init];
        _showAddressView.backgroundColor = [UIColor whiteColor];
    }
    return _showAddressView;
}
/** 用户名 */
- (UILabel *)userNameLabel{
    if (_userNameLabel == nil) {
        _userNameLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:16 alignment:NSTextAlignmentLeft];
        _userNameLabel.font = [UIFont boldSystemFontOfSize:16];
        _userNameLabel.text = @"";
    }
    return _userNameLabel;
}
/** icon */
- (UIImageView *)addressIcon{
    if (_addressIcon == nil) {
        _addressIcon = [[UIImageView alloc] init];
        _addressIcon.contentMode = UIViewContentModeScaleAspectFit;
        _addressIcon.image = [UIImage imageNamed:@"addresss_show_icon"];
    }
    return _addressIcon;
}
/** 用户地址 */
- (UILabel *)userAddressLabel{
    if (_userAddressLabel == nil) {
        _userAddressLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _userAddressLabel.text = @"";
    }
    return _userAddressLabel;
}

/** 箭头按钮 */
- (UIButton *)rowButton{
    if (_rowButton == nil) {
        _rowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rowButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_rowButton setImage:[UIImage imageNamed:@"XL_common_right_arrow"] forState:UIControlStateNormal];
        [_rowButton addTarget:self action:@selector(choiseAddressAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rowButton;
}

/** 显示地址view */
- (UIView *)noAddressView{
    if (_noAddressView == nil) {
        _noAddressView = [[UIView alloc] init];
        _noAddressView.backgroundColor = [UIColor whiteColor];
    }
    return _noAddressView;
}

/** icon */
- (UIImageView *)noAddressIcon{
    if (_noAddressIcon == nil) {
        _noAddressIcon = [[UIImageView alloc] init];
        _noAddressIcon.contentMode = UIViewContentModeScaleAspectFit;
        _noAddressIcon.image = [UIImage imageNamed:@"addresss_add_icon"];
    }
    return _noAddressIcon;
}

/** 没有地址描述 */
- (UILabel *)noAddressLabel{
    if (_noAddressLabel == nil) {
        _noAddressLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _noAddressLabel.text = @"您还没有收货地址";
    }
    return _noAddressLabel;
}
/** 添加地址按钮 */
- (UIButton *)addAddressButton{
    if (_addAddressButton == nil) {
        _addAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addAddressButton setTitle:@"+ 添加地址" forState:UIControlStateNormal];
        [_addAddressButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        _addAddressButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _addAddressButton.layer.borderColor = [UIColor colorWithHexString:COLOR_UNUSABLE_BUTTON].CGColor;
        _addAddressButton.layer.borderWidth = 1.0;
        [_addAddressButton addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressButton;
}

/** 设置地址信息 */
- (void)setAddressModel:(LSAddressModel *)addressModel{
    if (_addressModel != addressModel) {
        _addressModel = addressModel;
    }
    
    NSString *conginee = [NSString string];
    if (!kStringIsEmpty(_addressModel.consignee)) {
        conginee = _addressModel.consignee;
    }
    NSString *congineeMobile = [NSString string];
    if (!kStringIsEmpty(_addressModel.consigneeMobile)) {
        congineeMobile = _addressModel.consigneeMobile;
    }
    NSString *addDetail = [NSString string];
    if (!kStringIsEmpty(_addressModel.detailAddress)) {
        addDetail = _addressModel.detailAddress;
    } else {
        NSString *province = [NSString string];
        if (!kStringIsEmpty(_addressModel.province)) {
            province = _addressModel.province;
        }
        NSString *city = [NSString string];
        if (!kStringIsEmpty(_addressModel.city)) {
            city = _addressModel.city;
        }
        NSString *region = [NSString string];
        if (!kStringIsEmpty(_addressModel.region)) {
            region = _addressModel.region;
        }
        NSString *street = [NSString string];
        if (!kStringIsEmpty(_addressModel.street)) {
            street = _addressModel.street;
        }
        addDetail = [NSString stringWithFormat:@"%@%@%@%@", province, city, region, street];
        
    }
    
    self.userNameLabel.text = [NSString stringWithFormat:@"%@  %@", conginee, congineeMobile];
    self.userAddressLabel.text = addDetail;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/** 显示地址view还是添加地址view */
- (void)setShowAddress:(BOOL)showAddress{
    if (showAddress) {
        self.showAddressView.hidden = NO;
        self.noAddressView.hidden = YES;
    } else {
        self.showAddressView.hidden = YES;
        self.noAddressView.hidden = NO;
    }
}

/** 不显示箭头和左边图片 */
- (void)showRowButtonView:(BOOL)showRow{
    if (showRow) {
        self.rowButton.hidden = NO;
        self.leftImageView.hidden = NO;
    } else {
        self.rowButton.hidden = YES;
        self.leftImageView.hidden = YES;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 按钮点击事件
/** 选择地址 */
- (void)choiseAddressAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addressInfoViewChoiseAddress)]) {
        [self.delegate addressInfoViewChoiseAddress];
    }
}

/** 添加地址 */
- (void)addAddressAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addressInfoViewAddAddress)]) {
        [self.delegate addressInfoViewAddAddress];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
