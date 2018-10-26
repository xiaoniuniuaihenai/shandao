//
//  ZTMXFCertificationSectionView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFCertificationSectionView.h"

@implementation ZTMXFCertificationSectionView

+ (id)headerFooterViewWithTable:(UITableView *)tableView
{
    static NSString * cellstr = @"section";
    ZTMXFCertificationSectionView * sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellstr];
    if (!sectionView) {
        sectionView = [[ZTMXFCertificationSectionView alloc] initWithReuseIdentifier:cellstr];
        sectionView.leftLineView.backgroundColor = K_MainColor;
    }
    return sectionView;
}



- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.contentView.backgroundColor = K_LineColor;
        _leftLineView = [UIView new];
        _leftLineView.backgroundColor = K_MainColor;
        [self.contentView addSubview:_leftLineView];
        self.lineView = [UIView new];
//        [self.contentView addSubview:_lineView];
        self.titleLabel = [UILabel new];
        _titleLabel.font = FONT_SYSTEM(15);
        _titleLabel.textColor = [UIColor colorWithHexString:@"5c5c5c"];
        [self.contentView addSubview:_titleLabel];
        
        _leftLineView.sd_layout
        .leftSpaceToView(self.contentView, 12)
        .centerYEqualToView(self.contentView)
        .widthIs(4)
        .heightIs(12);
        
        _leftLineView.sd_cornerRadius = @2;
        
        _titleLabel.sd_layout
        .leftSpaceToView(_leftLineView, 9)
        .topEqualToView(self.contentView)
        .widthIs(KW / 2)
        .bottomEqualToView(self.contentView);
        
//        _lineView.sd_layout
//        .leftEqualToView(self.contentView)
//        .bottomEqualToView(self.contentView)
//        .widthIs(KW)
//        .heightIs(1);
        
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
