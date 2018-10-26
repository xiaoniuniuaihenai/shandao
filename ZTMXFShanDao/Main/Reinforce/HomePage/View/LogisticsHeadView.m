//
//  LogisticsHeadView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LogisticsHeadView.h"
#import "LogistcsInfoModel.h"
@interface LogisticsHeadView ()
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * lbStateLb;
@property (nonatomic,strong) UILabel * lbNumberLb;
@property (nonatomic,strong) UILabel * lbStateTitleLb;
@property (nonatomic,strong) UILabel * lbNameLb;
@property (nonatomic,strong) UIButton * btnCopyBtn;
@end
@implementation LogisticsHeadView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configAddSubView];
        [self configSubViewFrame];
    }
    return self;
}

#pragma mark --- Action
-(void)btnCopyBtnClick{
    if (![_lbNumberLb.text isKindOfClass:[NSNull class]] && _lbNumberLb.text.length>0) {
        [kKeyWindow makeCenterToast:@"复制成功"];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _lbNumberLb.text;
    }else{
        
    }
}
#pragma mark -- Model
-(void)setInfoModel:(LogistcsInfoModel *)infoModel{
    _infoModel = infoModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:infoModel.goodsIcon] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    _lbStateLb.text = _infoModel.stateDesc;
    _lbNameLb.text =  [NSString stringWithFormat:@"%@：",_infoModel.shipperName];
    _lbNumberLb.text = _infoModel.shipperCode;
    [self configSubViewFrame];
}
#pragma mark --
-(void)configAddSubView{
    [self addSubview:self.imgView];
    [self addSubview:self.lbStateTitleLb];
    [self addSubview:self.lbStateLb];
    [self addSubview:self.lbNameLb];
    [self addSubview:self.lbNumberLb];
    [self addSubview:self.btnCopyBtn];
    
}
-(void)configSubViewFrame{
    
    [_imgView setFrame:CGRectMake(AdaptedWidth(12), AdaptedWidth(10), AdaptedWidth(70), AdaptedWidth(70))];
    [_lbStateTitleLb setFrame:CGRectMake(_imgView.right+AdaptedWidth(15), AdaptedWidth(17), AdaptedWidth(70), AdaptedWidth(20))];
    _lbNameLb.left = _lbStateTitleLb.left;
    _lbNameLb.top = _lbStateTitleLb.bottom+AdaptedWidth(12);
    _lbNameLb.height = _lbStateTitleLb.height;
    
    [_lbStateLb setFrame:CGRectMake(_lbStateTitleLb.right+AdaptedWidth(5), _lbStateTitleLb.top, Main_Screen_Width-_lbStateTitleLb.right-AdaptedWidth(5),_lbStateTitleLb.height)];
    
    _lbNumberLb.left = _lbStateLb.left;
    _lbNumberLb.top = _lbNameLb.top;
    _lbNumberLb.height = _lbStateTitleLb.height;
    
    [_btnCopyBtn setFrame:CGRectMake(0, 0, AdaptedWidth(60), AdaptedWidth(24))];
    _btnCopyBtn.right = Main_Screen_Width - AdaptedWidth(10);
    _btnCopyBtn.centerY = _lbNameLb.centerY;
    
    [_lbStateTitleLb sizeToFit];
    
    [_lbNameLb sizeToFit];
    [_lbNumberLb sizeToFit];
    CGFloat  widthNumber = _btnCopyBtn.left - _lbNameLb.right-AdaptedWidth(15);
    _lbNumberLb.width = _lbNumberLb.width>widthNumber?widthNumber:_lbNumberLb.width;
    
}
#pragma mark -- set/get
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        [_imgView.layer setBorderColor:[UIColor colorWithHexString:COLOR_BORDER_STR].CGColor];
        [_imgView.layer setBorderWidth:1];
    }
    return _imgView;
}
-(UILabel *)lbStateTitleLb{
    if (!_lbStateTitleLb) {
        _lbStateTitleLb = [[UILabel alloc]init];
        _lbStateTitleLb.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        _lbStateTitleLb.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        _lbStateTitleLb.textAlignment = NSTextAlignmentLeft;
        _lbStateTitleLb.text = @"物流状态：";
    }
    return _lbStateTitleLb;
}
-(UILabel *)lbStateLb{
    if (!_lbStateLb) {
        _lbStateLb = [[UILabel alloc]init];
        _lbStateLb.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        _lbStateLb.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        _lbStateLb.textAlignment = NSTextAlignmentLeft;
    }
    return _lbStateLb;
}
-(UILabel *)lbNameLb{
    if (!_lbNameLb) {
        _lbNameLb = [[UILabel alloc]init];
        _lbNameLb.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        _lbNameLb.textColor = [UIColor colorWithHexString:COLOR_BLACK_STR];
        _lbNameLb.textAlignment = NSTextAlignmentLeft;
    }
    return _lbNameLb;
}
-(UILabel *)lbNumberLb{
    if (!_lbNumberLb) {
        _lbNumberLb = [[UILabel alloc]init];
        _lbNumberLb.font = [UIFont systemFontOfSize:AdaptedWidth(15)];
        _lbNumberLb.textColor = [UIColor colorWithHexString:COLOR_GRAY_STR];
        _lbNumberLb.textAlignment = NSTextAlignmentLeft;
    }
    return _lbNumberLb;
}
-(UIButton *)btnCopyBtn{
    if (!_btnCopyBtn) {
        _btnCopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_btnCopyBtn setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        _btnCopyBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
        [_btnCopyBtn.layer setBorderColor:[UIColor colorWithHexString:COLOR_BORDER_STR].CGColor];
        [_btnCopyBtn.layer setCornerRadius:AdaptedWidth(5)];
        [_btnCopyBtn.layer setBorderWidth:1];
        [_btnCopyBtn addTarget:self action:@selector(btnCopyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCopyBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
