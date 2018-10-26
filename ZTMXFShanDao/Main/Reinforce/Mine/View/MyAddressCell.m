//
//  MyAddressCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/8.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MyAddressCell.h"
#import "LSAddressModel.h"

@interface MyAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIButton *delateButton;

@end

@implementation MyAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.lineLabel setBackgroundColor:[UIColor colorWithHexString:COLOR_LIGHTBG_STR]];
    [self.nameLabel setFont:FONT_Regular(X(18))];
    [self.phoneLabel setFont:FONT_Regular(X(18))];
    [self.addressLabel setFont:FONT_Regular(X(13))];
    [_defaultAddressBtn setTitleColor:K_666666 forState:UIControlStateNormal];
    [_defaultAddressBtn setTitleColor:K_666666 forState:UIControlStateSelected];
    [_defaultAddressBtn setTitle:@"设为默认" forState:UIControlStateNormal];
    [_defaultAddressBtn setTitle:@"默认地址" forState:UIControlStateSelected];
    [_defaultAddressBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
    [_defaultAddressBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
    [_defaultAddressBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"dfdfdf"]] forState:UIControlStateHighlighted];
    [_defaultAddressBtn.titleLabel setFont:FONT_Regular(X(13))];
    _defaultAddressBtn.tag = 1;
    
    [_defaultAddressBtn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_editButton setTitle:@" 编辑" forState:UIControlStateNormal];
    [_editButton.titleLabel setFont:FONT_Regular(X(13))];
    [_editButton setTitleColor:K_666666 forState:UIControlStateNormal];
    [_editButton setImage:[UIImage imageNamed:@"XL_address_edit"] forState:UIControlStateNormal];
    _editButton.tag = 2;
    [_editButton addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_delateButton setTitle:@" 删除" forState:UIControlStateNormal];
    [_delateButton.titleLabel setFont:FONT_Regular(X(13))];
    [_delateButton setTitleColor:K_666666 forState:UIControlStateNormal];
    [_delateButton setImage:[UIImage imageNamed:@"XL_address_delete"] forState:UIControlStateNormal];
    _delateButton.tag = 3;
    [_delateButton addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - setter
- (void)setAddressModel:(LSAddressModel *)addressModel{
    _addressModel = addressModel;
    if (_addressModel) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@    %@",_addressModel.consignee,_addressModel.consigneeMobile];
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",_addressModel.province,_addressModel.city,_addressModel.region,_addressModel.detailAddress];
        self.defaultAddressBtn.selected = _addressModel.isDefault == 1 ? YES : NO;
    }
}

#pragma mark - 点击默认按钮
- (void)addressBtnClick:(UIButton *)sender{
    if (sender.tag == 1) {
        // 请求后台接口,设置默认地址成功则更改按钮状态 
        if (self.delegete && [self.delegete respondsToSelector:@selector(clickMyAddressBtn:)]) {
            [self.delegete clickMyAddressBtn:sender];
         }
    }else{
        // 直接回调
        if (self.delegete && [self.delegete respondsToSelector:@selector(clickMyAddressBtn:)]) {
            [self.delegete clickMyAddressBtn:sender];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
