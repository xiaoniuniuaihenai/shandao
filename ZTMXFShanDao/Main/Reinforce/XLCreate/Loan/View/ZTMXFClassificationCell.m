//
//  ZTMXFClassificationCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFClassificationCell.h"
#import "CategoryListModel.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+OSS.h"
@implementation ZTMXFClassificationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 81 * PX) / 2, 20 * PX, 81 * PX, 78 * PX)];
        _imgView.clipsToBounds = YES;
        [self.contentView addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgView.bottom + 10 * PX, self.width - 20, 20 * PX)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = FONT_Regular(12 * PX);
        _titleLabel.textColor = COLOR_SRT(@"#333333");
//        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setCategoryGoodsInfoModel:(CategoryGoodsInfoModel *)categoryGoodsInfoModel
{
    if (_categoryGoodsInfoModel != categoryGoodsInfoModel) {
        _categoryGoodsInfoModel = categoryGoodsInfoModel;
    }
    _titleLabel.text = _categoryGoodsInfoModel.title;
    
   NSString * imgStr = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,h_%.f", _categoryGoodsInfoModel.goodsIcon,self.height * 2];
    NSURL * url = [NSURL URLWithString:imgStr];
    [_imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"goods_placeholder_2"]];
//    [_imgView OSS_setImageWithString:_categoryGoodsInfoModel.goodsIcon h:self.height placeholderImage:[UIImage imageNamed:@"goods_placeholder_2"]];
}
@end
