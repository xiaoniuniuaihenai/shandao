//
//  LSAssistiveTouchView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSAssistiveTouchView.h"
@interface LSAssistiveTouchView()
@property (nonatomic,strong) UIButton * btnTouchBtn;
@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,weak  ) id delegate;
@end
@implementation LSAssistiveTouchView
-(instancetype)initWithAssistiveTouchWithDelegate:(id)delegate andBgColor:(NSString*)hexStr andTitle:(NSString*)title{
    if (self = [super init]) {
        _delegate = delegate;
        self.clipsToBounds = YES;
        [self setBackgroundColor:[UIColor colorWithHexString:hexStr]];
        [self addSubview:self.btnTouchBtn];
        [_btnTouchBtn setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

-(void)btnTouchBtnClick:(UIButton*)btn{
    btn.userInteractionEnabled = NO;

    if ([_delegate respondsToSelector:@selector(assistiveTouchViewAction)]) {
        [_delegate assistiveTouchViewAction];
    }
    btn.userInteractionEnabled = YES;
}
-(UIButton*)btnTouchBtn{
    if (!_btnTouchBtn) {
        _btnTouchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTouchBtn setFrame:CGRectMake(0, 0, self.width, self.height)];
        _btnTouchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _btnTouchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        [_btnTouchBtn addTarget:self action:@selector(btnTouchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnTouchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnTouchBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];

//        //放一个拖动手势，用来改变控件的位置
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [_btnTouchBtn addGestureRecognizer:pan];
        
    }
    return _btnTouchBtn;
}
//手势事件 －－ 改变位置
-(void)changePostion:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    CGRect originalFrame = self.frame;
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
//        暂不x轴移动
//        originalFrame.origin.x += point.x;
    }
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        originalFrame.origin.y += point.y;
    }
    self.frame = originalFrame;
    [pan setTranslation:CGPointZero inView:self];

    if (pan.state == UIGestureRecognizerStateBegan) {
        _btnTouchBtn.enabled = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged){

    } else {

        CGRect frame = self.frame;
        //记录是否越界
        BOOL isOver = NO;

        if (frame.origin.x < 0) {
            frame.origin.x = 0;
            isOver = YES;
        } else if (frame.origin.x+frame.size.width > width) {
            frame.origin.x = width - frame.size.width;
            isOver = YES;
        }

        if (frame.origin.y < _minY) {
            frame.origin.y = _minY;
            isOver = YES;
        } else if (frame.origin.y+frame.size.height > _maxY) {
            frame.origin.y = _maxY - frame.size.height;
            isOver = YES;
        }
        
        if (isOver) {
            [UIView animateWithDuration:0.3 animations:^{
                    self.top = frame.origin.y;
            }];
        }
        _btnTouchBtn.enabled = YES;
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    _btnTouchBtn.height = self.height;
    _btnTouchBtn.width = self.width;
    _btnTouchBtn.centerX = self.width/2.;
    _btnTouchBtn.centerY = self.height/2.;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(self.height/2.,self.height/2.)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


@end
