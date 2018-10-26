//
//  ZTMXFLoanHeaderSectionView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/16.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanHeaderSectionView.h"
#import "LSLoanSupermarketLabelModel.h"

@interface ZTMXFLoanHeaderSectionView ()

@property (nonatomic, strong)UIView * bottomView;

@end


@implementation ZTMXFLoanHeaderSectionView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 58, 100, 2)];
        _bottomView.backgroundColor = K_MainColor;
        [self.contentView addSubview:_bottomView];
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = [titleArray copy];
    for (UIView * view in self.contentView.subviews) {
        if (![view isEqual:_bottomView]) {
            [view removeFromSuperview];
        }
    }
    if (titleArray.count == 0) {
        return;
    }
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KW, 50 - 1)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:whiteView];
    
    float w = KW / titleArray.count;
    for (int i = 0; i < titleArray.count; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(w * i, 10, w, whiteView.height)];
        label.textAlignment = NSTextAlignmentCenter;
        LSLoanSupermarketLabelModel * model = titleArray[i];
        label.text = model.name;
        [self.contentView addSubview:label];
        
        UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(label.right, label.top + 10, 1, label.height - 20)];
        lineview.backgroundColor = K_LineColor;
        [self.contentView addSubview:lineview];
    }
    [_bottomView bringSubviewToFront:self.contentView];
}

- (void)setCurrentName:(NSString *)currentName
{
    for (UIView * view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel * label = (UILabel *)view;
            if ([label.text isEqualToString:currentName]) {
                [UIView animateWithDuration:.5f animations:^{
                    _bottomView.centerX = label.centerY;
                }];
            }
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
