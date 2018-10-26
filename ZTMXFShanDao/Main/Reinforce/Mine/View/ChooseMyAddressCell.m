//
//  ChooseMyAddressCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/17.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ChooseMyAddressCell.h"
#import "LSAddressModel.h"

@interface ChooseMyAddressCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

@end

@implementation ChooseMyAddressCell

- (void)setAddressModel:(LSAddressModel *)addressModel{
    _addressModel = addressModel;
    
    if (_addressModel) {
        self.nameLabel.text = _addressModel.consignee;
        self.phoneLabel.text = _addressModel.consigneeMobile;
        if (_addressModel.isDefault == 1) {
            NSString *defaultAddressStr = [NSString stringWithFormat:@"[默认地址]%@%@%@%@",_addressModel.province,_addressModel.city,_addressModel.region,_addressModel.detailAddress];
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:defaultAddressStr];
            [attrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_RED_STR]} range:[defaultAddressStr rangeOfString:@"[默认地址]"]];
            self.detailAddressLabel.attributedText = attrStr;
        }else{
            NSString *addressStr = [NSString stringWithFormat:@"%@%@%@%@",_addressModel.province,_addressModel.city,_addressModel.region,_addressModel.detailAddress];
            self.detailAddressLabel.text = addressStr;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupViews];
}

- (void)setupViews{

    [self.nameLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
    [self.phoneLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
    [self.detailAddressLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
