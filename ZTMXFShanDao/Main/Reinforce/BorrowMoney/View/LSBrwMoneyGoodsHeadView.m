//
//  LSBrwMoneyGoodsHeadView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSBrwMoneyGoodsHeadView.h"
#import "LSLoanSupermarketLabelModel.h"
@interface LSBrwMoneyGoodsHeadView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollViewHead;
@property (nonatomic,strong) NSMutableArray * arrHeadMenuBtn;
@property (nonatomic,strong) NSArray * arrHeadMenuData;
// 借款超市当前页面
@property (nonatomic,strong) UIButton * btnCurrBtn;

@property (nonatomic,strong) UIView * viHeadLine;
@property (nonatomic,strong) UIView * viLineView;

@end
@implementation LSBrwMoneyGoodsHeadView
-(instancetype)initWithGoodsHeadView{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
//        _sortingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _sortingBtn.frame = CGRectMake(KW - 50 * PX, 0, 50 * PX, 60);
//        [_sortingBtn setImage:[UIImage imageNamed:@"DC_sorting"] forState:UIControlStateNormal];
//        [self addSubview:_sortingBtn];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(_sortingBtn.left, _sortingBtn.top + 10, 1, _sortingBtn.height - 20)];
        lineView.backgroundColor = K_LineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//        _sortingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _sortingBtn.frame = CGRectMake(KW - 50 * PX, 0, 50 * PX, self.height);
//        [_sortingBtn setImage:[UIImage imageNamed:@"DC_sorting"] forState:UIControlStateNormal];
//        [self addSubview:_sortingBtn];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(_sortingBtn.left, _sortingBtn.top + 10, 1, _sortingBtn.height - 20)];
        lineView.backgroundColor = K_LineColor;
        [self addSubview:lineView];
    }
    return self;
}


- (void)setCurrentMenuIndex:(NSInteger)currentMenuIndex
{
    _currentMenuIndex = currentMenuIndex;
    UIButton * btn = _arrHeadMenuBtn[currentMenuIndex];
    btn.selected = YES;
    _btnCurrBtn.selected = NO;
    _btnCurrBtn = btn;
    [UIView animateWithDuration:.5 animations:^{
        _viHeadLine.centerX = btn.centerX;
    } completion:^(BOOL finished) {
        _btnCurrBtn.selected = YES;
    }];
}

#pragma mark - Action
-(void)btnHeadLabelClick:(UIButton*)sender{
    
    if (_btnCurrBtn == sender) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(brwMoneyGoodsHeadView:currentMenuIndex:)]) {
        [_delegate brwMoneyGoodsHeadView:self currentMenuIndex:sender.tag];
    }
    
    [self btnClasseStateWith:sender.tag];

}
#pragma
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView ==_scrollViewHead) {
        
    }else{
        CGFloat page = scrollView.contentOffset.x/scrollView.width;
        if (_btnCurrBtn.tag == page) {
            return;
        }
        [self btnClasseStateWith:page];
    }
}
-(void)btnClasseStateWith:(NSUInteger)page{
    UIButton * btn = _arrHeadMenuBtn[page];
    btn.selected = YES;
    _btnCurrBtn.selected = NO;
    _btnCurrBtn = btn;
    [UIView animateWithDuration:.5 animations:^{
        _viHeadLine.centerX = btn.centerX;
    } completion:^(BOOL finished) {
        _btnCurrBtn.selected = YES;
        //        刷新数据
        if ([_delegate respondsToSelector:@selector(brwMoneyGoodsUpdateDataWithGoodsData:)]) {
            [_delegate brwMoneyGoodsUpdateDataWithGoodsData:_arrHeadMenuData[page]];
        }
    }];
}


-(void)updateBrwMoneyGoodsHeadViewWith:(NSArray *)arrList{
    _arrHeadMenuData = arrList;
    
    for (UIView *view in _scrollViewHead.subviews) {
        [view removeFromSuperview];
    }
    [_scrollViewHead removeFromSuperview];

    _arrHeadMenuBtn = [[NSMutableArray alloc] init];
    
    [self addSubview:self.scrollViewHead];
    //            创建新的视图
    CGFloat viThreeW = SCREEN_WIDTH;
    CGFloat btnW = viThreeW / 4.0;
    CGFloat spaceW = (viThreeW-btnW*(_arrHeadMenuData.count))/(_arrHeadMenuData.count-1);
    CGFloat btnLeft = 40.0;
    if (arrList.count == 0) {
        return;
    }
//    CGFloat W = KW / _arrHeadMenuData.count;

    for (int i =0; i<[_arrHeadMenuData count]; i++) {
        LSLoanSupermarketLabelModel * lbelModel = _arrHeadMenuData[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake((btnW + 1) * i, 0, btnW, self.height)];
        [btn setTitle:lbelModel.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:COLOR_RED_STR] forState:UIControlStateSelected];
//        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnHeadLabelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewHead addSubview:btn];
        btnLeft = btn.right + spaceW;
        [self.scrollViewHead setContentSize:CGSizeMake(btn.right + 0.1, 0)];
        [_arrHeadMenuBtn addObject:btn];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(btn.left - 1, btn.top + 10, 1, btn.height - 20)];
        lineView.backgroundColor = K_LineColor;
        [self.scrollViewHead addSubview:lineView];
    }
    
    [self.scrollViewHead addSubview:self.viHeadLine];
    [self addSubview:self.viLineView];
    
    _viHeadLine.bottom = self.scrollViewHead.height;
    [self btnHeadLabelClick:_arrHeadMenuBtn.firstObject];

}

-(UIScrollView*)scrollViewHead{
    if (!_scrollViewHead) {
        _scrollViewHead = [[UIScrollView alloc]init];
        [_scrollViewHead setFrame:CGRectMake(0, 0, Main_Screen_Width, self.height)];
        _scrollViewHead.showsVerticalScrollIndicator = NO;
        _scrollViewHead.showsHorizontalScrollIndicator = NO;
        [_scrollViewHead setBackgroundColor:[UIColor clearColor]];
        _scrollViewHead.delegate = self;
    }
    return _scrollViewHead;
}
-(UIView *)viHeadLine{
    if (!_viHeadLine) {
        _viHeadLine = [[UIView alloc]init];
        [_viHeadLine setFrame:CGRectMake(10, 0, 48,2)];
        [_viHeadLine setBackgroundColor:K_MainColor];
    }
    return _viHeadLine;
}
-(UIView *)viLineView{
    if (!_viLineView) {
        _viLineView = [[UIView alloc]init];
        [_viLineView setFrame:CGRectMake(0, 59, Main_Screen_Width,1)];
        [_viLineView setBackgroundColor:[UIColor colorWithHexString:@"efefef"]];
    }
    return _viLineView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    _scrollViewHead.height = self.height;
//    _scrollViewHead.width = self.width;
//    _scrollViewHead.top = 0;
//    _scrollViewHead.left = 0;
//    _viLineView.bottom = self.height;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
//    _scrollViewHead.height = self.height;
//    _scrollViewHead.width = self.width;
//    _viLineView.bottom = self.height;

    
}


@end
