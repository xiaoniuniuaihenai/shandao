//
//  ZTMXFMineFirstSectionItem.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFMineFirstSectionItem.h"

@interface ZTMXFMineFirstSectionItem ()

@property (nonatomic, strong) UIImageView    *iconView;
@property (nonatomic, strong) UILabel     *titleLabel;

@end

@implementation ZTMXFMineFirstSectionItem

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIView *bgView = [[UIView alloc]init];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self.contentView);
        }];
        bgView.backgroundColor = UIColor.whiteColor;
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = FONT_Regular(X(15));
        self.titleLabel.textColor = COLOR_SRT(@"838383");
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(X(16)));
            make.right.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView).mas_offset(@(X(-10)));
            make.left.mas_equalTo(self.contentView);
        }];
        self.iconView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.iconView];
        self.iconView.contentMode = UIViewContentModeBottomLeft;
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.titleLabel.mas_left);
//            make.bottom.mas_equalTo(self.titleLabel.mas_top).mas_offset(X(-5));
            make.top.mas_equalTo(self.contentView).mas_offset(@(X(14)));
            make.centerX.mas_equalTo(self.contentView);
            make.width.mas_equalTo(@(X(26)));
            make.height.mas_equalTo(@(X(22)));
//            make.right.mas_equalTo(self.contentView);
        }];
        
        
        bgView.layer.shadowOffset = CGSizeMake(0, 0);
        bgView.layer.shadowOpacity = 0.8f;
        bgView.layer.shadowColor = COLOR_SRT(@"B9B9B9").CGColor;
        bgView.hidden = YES;
    }
    return self;
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.titleLabel.text = _dict.allKeys.firstObject;
    [self.iconView setImage:[UIImage imageNamed:_dict.allValues.firstObject]];
}

@end
