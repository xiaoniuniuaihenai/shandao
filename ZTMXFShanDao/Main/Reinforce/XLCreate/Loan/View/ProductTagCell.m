//
//  ProductTagCell.m
//  YuCaiShi
//
//  Created by 陈传亮 on 2017/3/28.
//  Copyright © 2017年 陈传亮. All rights reserved.
//

#import "ProductTagCell.h"

@implementation ProductTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.autoresizesSubviews = YES;
        self.tagLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_tagLabel];
        _tagLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tagLabel.font = FONT_Regular(12 * PX);
        self.contentView.layer.cornerRadius   = 3;
        self.contentView.layer.borderWidth = 1;
    }
    return self;
}

- (void)setTagString:(NSString *)tagString
{
    _tagString = tagString;
    _tagLabel.text = tagString;
}

+ (CGFloat)adaptionWidth:(NSString *)str
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, 18 * PX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_Regular(12 * PX)} context:nil];
    return rect.size.width + 15;
}

@end
