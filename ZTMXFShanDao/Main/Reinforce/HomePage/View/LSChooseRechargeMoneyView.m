//
//  LSChooseRechargeMoneyView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//
#define CELL_IDF @"LSPayMobileCellIdF"
#import "LSChooseRechargeMoneyView.h"
#import "ZTMXFMobileRechargeMoneyModel.h"
#import "MobileRechargeItemView.h"

@interface LSChooseRechargeMoneyView ()<MobileRechargeItemViewDelegate>
@property (nonatomic,strong) UILabel * lbTitleLb;
@property (nonatomic,strong) NSMutableArray * arrRecyclingItem;
@property (nonatomic,strong) MobileRechargeItemView * itemSelectItem;

@end

@implementation LSChooseRechargeMoneyView
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _arrRecyclingItem = [[NSMutableArray alloc]init];
        _itemEditorState = YES;
        [self addSubview:self.lbTitleLb];
    }
    return self;
}

#pragma mark ---
-(void)mobileRechargeItemViewSelectItem:(MobileRechargeItemView *)itemView{
    [_itemSelectItem restoreBtnState:RechargeItemStateNormal];
    _itemSelectItem = itemView;
    if ([_delegate respondsToSelector:@selector(chooseRechargeMoneyView:didSelect:)]&&[_arrPayMoneyArr count]>itemView.tag) {
        [_delegate chooseRechargeMoneyView:self didSelect:_arrPayMoneyArr[itemView.tag]];
    }
}
#pragma mark - Get/set
-(void)setItemEditorState:(BOOL)itemEditorState{
    _itemEditorState = itemEditorState;
    for (int i =0;i<[_arrRecyclingItem count];i++) {
        MobileRechargeItemView * item = _arrRecyclingItem[i];
        item.userInteractionEnabled = _itemEditorState;
        if (itemEditorState) {
            [item restoreBtnState:RechargeItemStateNormal];
        }else{
            [item restoreBtnState:RechargeItemStateNotEditor];
        }
        if (item == _itemSelectItem&&_itemSelectItem) {
            if (itemEditorState) {
                [item restoreBtnState:RechargeItemStateSelect];
            }else{
                [item restoreBtnState:RechargeItemStateNotEditorSelect];

            }
        }
    }
}

-(MobileRechargeItemView *)createPayMobileItem{
    MobileRechargeItemView * item = [[MobileRechargeItemView alloc]initWithDelegate:self];
    item.defColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
    item.notColor = [UIColor colorWithHexString:@"E7E7E7"];
    item.selectColor = [UIColor colorWithHexString:COLOR_RED_STR];
    item.notSelectColor = item.notColor;
    item.borderColor = [UIColor colorWithHexString:@"FCCEC4"];
    item.borderNotColor = [UIColor colorWithHexString:@"F1F1F1"];
    item.borderSelectColor = [UIColor clearColor];
    
    item.defTwoColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
    item.notTwoColor = item.notColor;
    item.selectTwoColor = item.selectColor;
    item.notSelectTwoColor = item.notSelectColor;
    
    item.defBgColor = [UIColor clearColor];
    item.notBgColor = [UIColor clearColor];
    item.selectBgColor = [UIColor colorWithHexString:@"FEEEEB"];
    item.notSelectBorderColor = [UIColor clearColor];
    item.notSelectBgColor = [UIColor colorWithHexString:@"FEF7F5"];
    [item setFrame:CGRectMake(0, 0, AdaptedWidth(110), AdaptedWidth(50))];
    item.clipsToBounds = YES;
    return item;
}


-(UILabel *)lbTitleLb{
    if (!_lbTitleLb) {
        _lbTitleLb = [[UILabel alloc]init];
        [_lbTitleLb setFrame:CGRectMake(AdaptedWidth(12), 0, 100, AdaptedWidth(25))];
        _lbTitleLb.font = [UIFont systemFontOfSize:AdaptedWidth(18)];
        _lbTitleLb.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _lbTitleLb.text = @"充值金额";
    }
    return _lbTitleLb;
}
-(void)setArrPayMoneyArr:(NSMutableArray *)arrPayMoneyArr{
    _arrPayMoneyArr = arrPayMoneyArr;
    for (int i =0; i <_arrPayMoneyArr.count; i++) {
        MobileRechargeItemView * item = nil;
        if (_arrRecyclingItem.count>i) {
            item = _arrRecyclingItem[i];
        }else{
            item = [self createPayMobileItem];
            [_arrRecyclingItem addObject:item];
        }
//        样式初始
        [item restoreBtnState:RechargeItemStateNormal];
        item.left = AdaptedWidth(12)+ i%3*(item.width+AdaptedWidth(10));
        item.top  =_lbTitleLb.bottom+AdaptedWidth(20) + i/3*(AdaptedWidth(10)+item.height);
        item.tag = i;
        if (i==0) {
            _itemSelectItem = item;
            [_itemSelectItem restoreBtnState:RechargeItemStateSelect];
            [_itemSelectItem.layer setBorderColor:[UIColor clearColor].CGColor];
        }
//       恢复初始状态
        item.hidden = NO;
        [self addSubview:item];
        ZTMXFMobileRechargeMoneyModel * itemModel = arrPayMoneyArr[i];
        NSString * titleStr = [NSString stringWithFormat:@"%@元",itemModel.amount];
        NSString * twoStr = [NSString stringWithFormat:@"售价：%@元",itemModel.actual];
        item.oneValue = titleStr;
        item.twoValue = twoStr;
//        视图
        self.height = item.bottom;
    }
//    隐藏多余的
    NSInteger hideIndex = _arrPayMoneyArr.count;
    for (NSInteger i = hideIndex; i<_arrRecyclingItem.count; i++) {
        MobileRechargeItemView * item = _arrRecyclingItem[i];
        item.hidden = YES;
    }
//    同步一下
    self.itemEditorState = _itemEditorState;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
