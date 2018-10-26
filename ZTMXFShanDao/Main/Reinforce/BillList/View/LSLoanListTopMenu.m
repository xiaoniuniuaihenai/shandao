//
//  LSLoanListTopMenu.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/9.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSLoanListTopMenu.h"

@interface LSLoanListTopMenu ()

@property (nonatomic, strong) UIView *redSelectedLine;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation LSLoanListTopMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.bottomLine];
        [self addSubview:self.redSelectedLine];
    }
    return self;
}

#pragma mark - 点击按钮


-(void)setMenuList:(NSArray *)menuList{
    _menuList = menuList;
    if (_menuList.count > 0) {
        CGFloat width = SCREEN_WIDTH / _menuList.count;
        CGFloat height = self.height - 3;
        for (int i=0; i<_menuList.count; i++) {
            NSString *title = _menuList[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(i*width, 0, width, height)];
            [button.titleLabel setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"4a4a4a"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateSelected];
            button.tag = i;
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            if (i == 0) {
                button.selected = YES;
                self.selectedButton = button;
                self.redSelectedLine.width = width;
                self.redSelectedLine.left = button.left;
            }
        }
    }
}
- (void)clickButton:(UIButton *)sender{
    if (sender != self.selectedButton) {
        self.selectedButton.selected = NO;
        sender.selected = YES;
        self.selectedButton = sender;
    }else{
        return;
    }
    // 底部红线移动
    [UIView animateWithDuration:.5 animations:^{
        _redSelectedLine.centerX = sender.centerX;
    } completion:^(BOOL finished) {
        //   刷新数据
        if (self.delegate && [self.delegate respondsToSelector:@selector(uploadLoanListDataWithIndex:)]) {
            [self.delegate uploadLoanListDataWithIndex:sender.tag];
        }
    }];
}


-(UIView *)redSelectedLine{
    if (!_redSelectedLine) {
        _redSelectedLine = [[UIView alloc]init];
        [_redSelectedLine setFrame:CGRectMake(0, 0, 100,2)];
        [_redSelectedLine setBackgroundColor:K_MainColor];
    }
    return _redSelectedLine;
}
-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        [_bottomLine setFrame:CGRectMake(0, 0, Main_Screen_Width,1)];
        [_bottomLine setBackgroundColor:[UIColor colorWithHexString:@"efefef"]];
    }
    return _bottomLine;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.redSelectedLine.bottom = self.height;
    self.bottomLine.bottom = self.height;
}

@end
