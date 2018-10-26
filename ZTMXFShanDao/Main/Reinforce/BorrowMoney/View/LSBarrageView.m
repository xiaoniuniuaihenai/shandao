//
//  LSBarrageView.m
//  ALAFanBei
//
//  Created by Try on 2017/7/27.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "LSBarrageView.h"
#import "NSString+Additions.h"
#import "LSBorrowGoodsScrollBarModel.h"
@interface LSBarrageView ()
@property (nonatomic,strong) UILabel * lbBarrageOneLb;
@property (nonatomic,strong) UIView * viLbView;
@property (nonatomic,strong) UIImageView * imgLeftView;
@property (nonatomic,strong) UIButton * btnClose;
@property (nonatomic,weak  ) id delegate;
@end
@implementation LSBarrageView
-(instancetype)initWithBarrageWithDelegate:(id)delegate andFrame:(CGRect)frame
{
    if (self = [super init]) {
        _delegate = delegate;
        [self setFrame:frame];
        [self setBackgroundColor:[UIColor colorWithHexString:@"fefdf2"]];
        [self addSubview:self.btnClose];
        [self addSubview:self.imgLeftView];
        
        [self addSubview:self.viLbView];
        _viLbView.clipsToBounds = YES;
        [self.viLbView addSubview:self.lbBarrageOneLb];
    }
    return self;
}

-(UILabel*)lbBarrageOneLb{
    if (!_lbBarrageOneLb) {
        _lbBarrageOneLb = [[UILabel alloc]init];
        [_lbBarrageOneLb setFont:[UIFont systemFontOfSize:14]];
        [_lbBarrageOneLb setFrame:CGRectMake(0, 0, 21, 21)];
        [_lbBarrageOneLb setTextColor:[UIColor colorWithHexString:@"fd6200"]];
        _lbBarrageOneLb.textAlignment = NSTextAlignmentLeft;
        _lbBarrageOneLb.userInteractionEnabled = NO;
    }
    return _lbBarrageOneLb;
}

-(UIView*)viLbView{
    if (!_viLbView) {
        _viLbView = [[UIView alloc]init];
        [_viLbView setBackgroundColor:[UIColor clearColor]];
        _viLbView.clipsToBounds = YES;
        [_viLbView setFrame:CGRectMake(_imgLeftView.right+5, 0, _btnClose.left-_imgLeftView.right-5, self.height)];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerContent)];
        [_viLbView addGestureRecognizer:tap];
    }
    return _viLbView;
}
-(UIImageView*)imgLeftView{
    if (!_imgLeftView) {
        _imgLeftView = [[UIImageView alloc]init];
        [_imgLeftView setImage:[UIImage imageNamed:@"horn"]];
        [_imgLeftView setFrame:CGRectMake(12, 0, AdaptedWidth(14), AdaptedWidth(15))];
        _imgLeftView.centerY = self.height/2.;
    }
    return _imgLeftView;
}
-(UIButton*)btnClose{
    if (!_btnClose) {
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnClose setImage:[UIImage imageNamed:@"closeBarrage"] forState:UIControlStateNormal];
        _btnClose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _btnClose.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 12);
        [_btnClose setFrame:CGRectMake(0, 0, 36, self.height)];
        _btnClose.right = self.width;
        _btnClose.centerY = _imgLeftView.centerY;
        [_btnClose addTarget:self action:@selector(btnCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}

-(void)setBarModel:(LSBorrowGoodsScrollBarModel *)barModel{
    _barModel = barModel;
//    [_barModel.content sizeWithFont:_lbBarrageOneLb.font maxW:<#(CGFloat)#>]
//    CGFloat contentW = [NSString widthForString:_barModel.content andFont:_lbBarrageOneLb.font andheight:_lbBarrageOneLb.height];
//    _lbBarrageOneLb.width = contentW;
//    _lbBarrageOneLb.text = barModel.content;
//
//    if (contentW>_viLbView.width) {
//        _lbBarrageOneLb.left = _viLbView.right;
//        [self startBarrageAnimationWithDuration:contentW/_viLbView.width*4];
//       }
}

-(void)startBarrageAnimationWithDuration:(CGFloat)duration{
    [UIView beginAnimations:@"Barrage" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    [UIView setAnimationDuration:duration];
    _lbBarrageOneLb.right = 0;
    [UIView commitAnimations];
}
#pragma mark -- Action
-(void)btnCloseClick:(UIButton*)btn{
    if ([_delegate respondsToSelector:@selector(didCloseBarrageViewWithBarrageView:)]) {
        [_delegate didCloseBarrageViewWithBarrageView:self];
    }
}
-(void)tapGestureRecognizerContent{
    if ([_barModel.type isEqualToString:@"H5_URL"]) {
//        ALANewcomerTutorialViewController *VC = [[ALANewcomerTutorialViewController alloc] init];
//        VC.webUrl = _barModel.wordUrl;
//        UIViewController * superVc = (UIViewController*)_delegate;
//        [superVc.navigationController  pushViewController:VC animated:YES];
    }
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    _imgLeftView.centerY = self.height/2.;
    _btnClose.right = self.width;
    _btnClose.centerY = _imgLeftView.centerY;
    [_viLbView setFrame:CGRectMake(_imgLeftView.right+5, 0, _btnClose.left-_imgLeftView.right-5, self.height)];
    _lbBarrageOneLb.centerY = _viLbView.height/2.;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
