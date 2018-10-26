//
//  ImageItemView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ImageItemView.h"
@interface ImageItemView ()
@property (nonatomic,strong) UIButton * btnItemBtn;
@property (nonatomic,strong) UIButton * btnDeleteBtn;


@end
@implementation ImageItemView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.btnItemBtn];
        [self addSubview:self.btnDeleteBtn];
    }
    return self;
}
-(void)changeStateWithIsSelect:(BOOL)isSelect imageSelect:(UIImage *)image{
    _btnItemBtn.selected = isSelect;
    [_btnItemBtn setImage:image forState:UIControlStateSelected];
    _btnDeleteBtn.hidden = !isSelect;
    _btnItemBtn.userInteractionEnabled = _btnDeleteBtn.hidden;

}
-(void)btnItemBtnClick:(UIButton *)btn{

    if ([_delegate respondsToSelector:@selector(didSelectImageItemView:)]) {
        [_delegate didSelectImageItemView:self];
        }
}
-(void)btnDeleteBtnClick:(UIButton *)btn{
    if ([_delegate respondsToSelector:@selector(removeImageItemView:)]) {
        [_delegate removeImageItemView:self];
    }
}
#pragma mark ----- Get
-(UIButton*)btnItemBtn{
    if (!_btnItemBtn) {
        _btnItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnItemBtn setImage:[UIImage imageNamed:@"feedback_add"] forState:UIControlStateNormal];
        [_btnItemBtn addTarget:self action:@selector(btnItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnItemBtn;
}
-(UIButton*)btnDeleteBtn{
    if (!_btnDeleteBtn) {
        _btnDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDeleteBtn setImage:[UIImage imageNamed:@"feedback_delete"] forState:UIControlStateNormal];
        _btnDeleteBtn.hidden = YES;
        [_btnDeleteBtn addTarget:self action:@selector(btnDeleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDeleteBtn;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)layoutSubviews{
    [super layoutSubviews];
    self.width = self.width+AdaptedWidth(10);
    self.height = self.height+AdaptedWidth(10);
    [_btnItemBtn setFrame:CGRectMake(0, 0, self.width-AdaptedWidth(10),self.height-AdaptedWidth(10))];
    [_btnDeleteBtn setFrame:CGRectMake(0, 0, AdaptedWidth(20),AdaptedWidth(20))];
    _btnDeleteBtn.center = CGPointMake(_btnItemBtn.right, _btnItemBtn.top);
}

@end
