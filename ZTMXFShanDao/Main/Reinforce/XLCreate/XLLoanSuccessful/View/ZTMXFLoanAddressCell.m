//
//  ZTMXFLoanAddressCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/6/1.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanAddressCell.h"
#import "LSAddressModel.h"
@implementation ZTMXFLoanAddressCell







- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
        [_chooseBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(chooseBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_chooseBtn];
        
        _nameLabel = [UILabel new];
        _nameLabel.textColor = K_333333;
        _nameLabel.font = FONT_Regular(18 * PX);
        [self.contentView addSubview:_nameLabel];
        
        _phoneLabel = [UILabel new];
        _phoneLabel.textColor = K_333333;
        _phoneLabel.font = FONT_Regular(18 * PX);
        [self.contentView addSubview:_phoneLabel];
        
        _addressLabel = [UILabel new];
        _addressLabel.textColor = K_666666;
        _addressLabel.font = FONT_Regular(13 * PX);
        [self.contentView addSubview:_addressLabel];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"  编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = FONT_Regular(13 * PX);
        [_editBtn setTitleColor:K_666666 forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"XL_address_edit"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];

        [self.contentView addSubview:_editBtn];
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = K_BackgroundColor;
        [self.contentView addSubview:lineView];
        
        _chooseBtn.sd_layout
        .leftEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .widthIs(42)
        .heightIs(42);
        
        _nameLabel.sd_layout
        .leftSpaceToView(_chooseBtn, 1)
        .centerYEqualToView(_chooseBtn)
        .heightIs(25 * PX);
        [_nameLabel setSingleLineAutoResizeWithMaxWidth:KW / 3];
        
      
        _editBtn.sd_layout
        .rightSpaceToView(self.contentView, 13 * PX)
        .centerYEqualToView(_chooseBtn)
        .widthIs(60)
        .heightIs(25 * PX);
        
        _phoneLabel.sd_layout
        .leftSpaceToView(_nameLabel, 30 * PX)
        .centerYEqualToView(_chooseBtn)
        .heightIs(25 * PX )
        .rightSpaceToView(_editBtn, 10);
        
        _addressLabel.sd_layout
        .leftEqualToView(_nameLabel)
        .rightEqualToView(_editBtn)
        .autoHeightRatio(0)
        .topSpaceToView(_nameLabel, 5)
        .maxHeightIs(40 * PX);
        _addressLabel.numberOfLines = 2;
        lineView.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .heightIs(6 * PX);
        
//        [self setupAutoHeightWithBottomView:_addressLabel bottomMargin:16 * PX];
        
    }
    return self;
}

- (void)editBtnAction
{
    if (self.delegete && [self.delegete respondsToSelector:@selector(loanAddressCell:flag:)]) {
        [_delegete loanAddressCell:self flag:1];
    }
}

- (void)chooseBtnAction
{
    _chooseBtn.selected =  !_chooseBtn.selected;
    _addressModel.isDefault = _chooseBtn.selected;
    if (self.delegete && [self.delegete respondsToSelector:@selector(loanAddressCell:flag:)]) {
        [_delegete loanAddressCell:self flag:2];
    }
}

#pragma mark - setter
- (void)setAddressModel:(LSAddressModel *)addressModel
{
    _addressModel = addressModel;
    if (_addressModel) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@",_addressModel.consignee];
        _phoneLabel.text = _addressModel.consigneeMobile;
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",_addressModel.province,_addressModel.city,_addressModel.region,_addressModel.detailAddress];
        self.chooseBtn.selected = _addressModel.isSelected;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (ZTMXFLoanAddressCell *)loanAddressCellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFLoanAddressCell";
    ZTMXFLoanAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFLoanAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
