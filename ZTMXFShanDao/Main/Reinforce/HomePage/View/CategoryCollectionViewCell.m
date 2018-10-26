//
//  CategoryCollectionViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/18.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "HomePageMallModel.h"

@interface CategoryCollectionViewCell ()

@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) UILabel     *categoryNameLabel;

@end

@implementation CategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    
    self.categoryImageView.frame = CGRectMake(0.0, 0.0, viewWidth, AdaptedWidth(50.0));
    self.categoryNameLabel.frame = CGRectMake(0.0, CGRectGetMaxY(self.categoryImageView.frame) + AdaptedHeight(8.0), viewWidth, AdaptedHeight(17.0));
}
- (void)setupViews{
    [self.contentView addSubview:self.categoryImageView];
    [self.contentView addSubview:self.categoryNameLabel];
}


#pragma mark - getter/setter
- (UIImageView *)categoryImageView{
    if (_categoryImageView == nil) {
        _categoryImageView = [[UIImageView alloc] init];
        _categoryImageView.backgroundColor = [UIColor clearColor];
        _categoryImageView.userInteractionEnabled = YES;
        _categoryImageView.clipsToBounds = YES;
        _categoryImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _categoryImageView;
}

- (UILabel *)categoryNameLabel{
    if (_categoryNameLabel == nil) {
        _categoryNameLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:12 alignment:NSTextAlignmentCenter];
        _categoryNameLabel.text = @"";
        if (Main_Screen_Width < 370.0) {
            _categoryNameLabel.font = [UIFont systemFontOfSize:10];
        } else if (Main_Screen_Width > 370 && Main_Screen_Width < 410) {
            _categoryNameLabel.font = [UIFont systemFontOfSize:12];
        } else {
            _categoryNameLabel.font = [UIFont systemFontOfSize:13];
        }
    }
    return _categoryNameLabel;
}

#pragma mark - 设置分类数据
- (void)setMallCategoryModel:(MallCategoryModel *)mallCategoryModel{
    _mallCategoryModel = mallCategoryModel;
    
    /** 分类Icon */
    [self.categoryImageView sd_setImageWithURL:[NSURL URLWithString:_mallCategoryModel.categoryIcon]];
    [self.categoryImageView sd_setImageFadeEffectWithURLstr:_mallCategoryModel.categoryIcon placeholderImage:@"placeholder_45"];
    /** 分类名称 */
    self.categoryNameLabel.text = _mallCategoryModel.name;
    /** 分类字体颜色 */
    if (mallCategoryModel.categoryFontColor.length > 0) {
        self.categoryNameLabel.textColor = [UIColor colorWithHexString:mallCategoryModel.categoryFontColor];
    }
}

@end
