//
//  StyleFooterCollectionReusableView.m
//  ALAFanBei
//
//  Created by yangpenghua on 2017/7/18.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "StyleFooterCollectionReusableView.h"
#import "AddNumberView.h"

@implementation StyleFooterCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    //  编辑数量
    self.addNumberView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 50.0);
    
    //  分期可选
    self.bystageLabel.frame = CGRectMake(10.0, CGRectGetMaxY(self.addNumberView.frame), SCREEN_WIDTH - 24.0, 40.0);
}
- (void)setupViews{
    
    // 编辑数量
    self.addNumberView = [[AddNumberView alloc] init];
    self.addNumberView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.addNumberView];
    
    /** 分期可选 */
    self.bystageLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:13 alignment:NSTextAlignmentLeft];
    self.bystageLabel.text = @"返呗分期 (可选)";
    self.bystageLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bystageLabel];
    self.bystageLabel.hidden = YES;
    
}
@end
