//
//  LSIdCardTypeCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSIdCardTypeCell.h"
#import "LSBankCardTypeModel.h"
@implementation LSIdCardTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"EDEFF0"];
}


-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    _imgSelectImgView.hidden = !_isSelect;
}
-(void)setCardTypeModel:(LSBankCardTypeModel *)cardTypeModel{
    _cardTypeModel = cardTypeModel;
    _lbBankName.text = _cardTypeModel.bankName;
    _lbBankType.text = [[_cardTypeModel.invalidDesc stringByReplacingOccurrencesOfString:@"（" withString:@""] stringByReplacingOccurrencesOfString:@"）" withString:@""]?:@"";
    NSURL * url = [NSURL URLWithString:_cardTypeModel.bankIcon];
    [_imgIcon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (!image) {
            [_imgIcon setBackgroundColor:[UIColor colorWithHexString:@"e3e3e3"]];
        }else{
            [_imgIcon setBackgroundColor:[UIColor clearColor]];
        }
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

