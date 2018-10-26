//
//  ZTMXFLoanSupermarketTagCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanSupermarketTagCell.h"

@implementation ZTMXFLoanSupermarketTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.contentView.autoresizesSubviews = YES;
        self.tagLabel = [[UILabel alloc] init];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_tagLabel];
        _tagLabel.sd_layout
        .leftEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, 14);
        _tagLabel.font = FONT_Regular(12 * PX);
        self.tagLabel.layer.cornerRadius   = 3;
        self.tagLabel.layer.borderWidth = 1;
    }
    return self;
}



+ (CGFloat)adaptionWidth:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, 18 * PX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_Regular(12 * PX)} context:nil];
    return rect.size.width + 15;
}
- (void)setTagString:(NSString *)tagString
{
    _tagString = tagString;
    _tagLabel.text = tagString;
}

@end

