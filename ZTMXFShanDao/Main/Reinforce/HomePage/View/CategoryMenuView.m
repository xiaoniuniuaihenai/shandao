//
//  CategoryMenuView.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CategoryMenuView.h"
#import "HomePageMallModel.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation CategoryMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}



//  配置分类
- (void)configCategoryMenuView{
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if (_categoryArray.count > 0) {
        CGFloat buttonTopPadding = AdaptedHeight(24.0);
        CGFloat buttonRowMargin = AdaptedHeight(14.0);
        CGFloat leftMargin = AdaptedWidth(12.0);
        CGFloat buttonMargin = AdaptedWidth(14.0);
        CGFloat buttonWidth = (Main_Screen_Width - (leftMargin + buttonMargin) * 2) / 3.0;
        CGFloat buttonHeight = AdaptedHeight(48.0);
        for (int i = 0; i < _categoryArray.count; i ++) {
            MallCategoryModel *categoryModel = _categoryArray[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:categoryModel.categoryIcon] forState:UIControlStateNormal];
            button.layer.cornerRadius = 2.0;
            button.tag = 2000 + i;
            NSInteger row = i / 3;
            NSInteger line = i % 3;
            CGFloat buttonX = leftMargin + (buttonMargin + buttonWidth) * line;
            CGFloat buttonY = buttonTopPadding + (buttonHeight + buttonRowMargin) * row;
            button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
            [button addTarget:self action:@selector(categoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}
- (void)setCategoryArray:(NSArray *)categoryArray{
    if (_categoryArray != categoryArray) {
        _categoryArray = categoryArray;
    }
    
    [self configCategoryMenuView];
}
#pragma mark - 按钮点击事件
- (void)categoryButtonAction:(UIButton *)sender{
    NSInteger categoryIndex = sender.tag - 2000;
    if (categoryIndex >= 0 && categoryIndex < self.categoryArray.count) {
        MallCategoryModel *categoryModel = self.categoryArray[categoryIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(categoryMenuViewClickCategory:)]) {
            [self.delegate categoryMenuViewClickCategory:categoryModel];
        }
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
