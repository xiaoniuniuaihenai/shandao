//
//  LogisticsInfoListView.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LogisticsInfoListView.h"
#import "LogistcsInfoModel.h"
#import "NSDate+Extension.h"
@interface LogisticsInfoListView ()
@property (nonatomic,strong) UILabel * lbAddressLb;
@property (nonatomic,strong) UIImageView * imgStartView;
@property (nonatomic,strong) UIImageView * imgEndView;
@property (nonatomic,strong) UIView * viLineView;
@end
@implementation LogisticsInfoListView
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = Main_Screen_Width;
    }
    return self;
}
-(void)setInfoModel:(LogistcsInfoModel *)infoModel{
    _infoModel = infoModel;
    if (infoModel) {
        [self configAddSubview];
    }
}



-(void)configAddSubview{
    CGFloat bottomY = AdaptedWidth(15);
    [self addSubview:self.lbAddressLb];
    _lbAddressLb.top = bottomY;
    CGFloat maxW = Main_Screen_Width-AdaptedWidth(90);
    _lbAddressLb.width = maxW;
    _lbAddressLb.left = AdaptedWidth(60);
    
//    地址信息
    NSString * addresStr = [NSString stringWithFormat:@"[将配送至] %@",_infoModel.address];
    NSMutableAttributedString * arrStr = [[NSMutableAttributedString alloc]initWithString:addresStr];
    [arrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_BLACK_STR] range:[addresStr rangeOfString:@"[将配送至]"]];
    _lbAddressLb.attributedText = arrStr;
    [_lbAddressLb sizeToFit];
    bottomY = _lbAddressLb.bottom+AdaptedWidth(25);
    
    [self addSubview:self.viLineView];
    [self addSubview:self.imgStartView];
    [self addSubview:self.imgEndView];
    _imgStartView.hidden = YES;
    _imgEndView.hidden = YES;
//
    for (int i =0; i <_infoModel.tracesInfo.count; i++) {
        LogistcsProgressModel * proModel = _infoModel.tracesInfo[i];
        UILabel * lbOneLb = [[UILabel alloc] init];
        NSString * colorStr = i==0?COLOR_RED_STR:COLOR_LIGHT_GRAY_STR;
        UIColor * color = [UIColor colorWithHexString:colorStr];
        NSInteger fontSize = i==0?14:12;
        bottomY += AdaptedWidth(20);
        lbOneLb.top = bottomY;
        lbOneLb.width = maxW-AdaptedWidth(2);
        lbOneLb.left = _lbAddressLb.left+AdaptedWidth(2);
        lbOneLb.textColor = color;
        lbOneLb.font = [UIFont systemFontOfSize:AdaptedWidth(fontSize)];
        lbOneLb.numberOfLines = 0;
        lbOneLb.text = proModel.AcceptStation;
        [self addSubview:lbOneLb];
        [lbOneLb sizeToFit];
        UILabel * lbTimerLb = [[UILabel alloc]init];
        lbTimerLb.font = [UIFont systemFontOfSize:AdaptedWidth(12)];
        lbTimerLb.textColor = color;
        lbTimerLb.left = lbOneLb.left;
        lbTimerLb.text = proModel.AcceptTime;

        lbTimerLb.top = lbOneLb.bottom + AdaptedWidth(6);
        lbTimerLb.width = lbOneLb.width;
        [self addSubview:lbTimerLb];
        [lbTimerLb sizeToFit];
        bottomY = lbTimerLb.bottom;
        
        if (i ==0) {
            _imgStartView.top = lbOneLb.top;
            _imgStartView.hidden = NO;
        }else if(i==(_infoModel.tracesInfo.count-1)){
            _imgEndView.top = lbOneLb.top;
            _imgEndView.hidden = NO;
            _viLineView.height = _imgEndView.centerY - _imgStartView.centerY;
        }else{
            UIView * viRound = [[UIView alloc]init];
            [viRound setFrame:CGRectMake(0, 0, AdaptedWidth(4), AdaptedWidth(4))];
            [viRound setBackgroundColor:[UIColor colorWithHexString:@"d8d8d8"]];
            [viRound.layer setCornerRadius:viRound.height/2.];
            [self addSubview:viRound];
            viRound.top = lbOneLb.centerY;
            viRound.centerX = _imgStartView.centerX;
            _viLineView.height = viRound.centerY - _imgStartView.centerY;
        }
        
    }
    _viLineView.centerX = _imgStartView.centerX;
    _viLineView.top = _imgStartView.centerY;
    [self bringSubviewToFront:_imgStartView];
    [self bringSubviewToFront:_imgEndView];
    [UIView drawVerticalDashLine:_viLineView lineLength:2 lineSpacing:2 lineColor:[UIColor colorWithHexString:@"EDEFF0"]];
    self.height = bottomY+AdaptedWidth(22);
    
}
#pragma mark -- set/get

-(UIImageView *)imgStartView{
    if (!_imgStartView) {
        _imgStartView = [[UIImageView alloc]init];
        [_imgStartView setFrame:CGRectMake(AdaptedWidth(28), 0, AdaptedWidth(12), AdaptedWidth(14))];
        [_imgStartView setImage:[UIImage imageNamed:@"logisticsStart"]];
    }
    return _imgStartView;
}
-(UIImageView *)imgEndView{
    if (!_imgEndView) {
        _imgEndView = [[UIImageView alloc]init];
        [_imgEndView setFrame:CGRectMake(AdaptedWidth(28), 0, AdaptedWidth(12), AdaptedWidth(12))];
        [_imgEndView setImage:[UIImage imageNamed:@"logisticsEnd"]];
    }
    return _imgEndView;
}
-(UIView *)viLineView{
    if (!_viLineView) {
        _viLineView = [[UIView alloc]init];
        _viLineView.clipsToBounds = YES;
        _viLineView.width = 1;
    }
    return _viLineView;
}
-(UILabel * )lbAddressLb{
    if (!_lbAddressLb) {
        _lbAddressLb = [[UILabel alloc]init];
        [_lbAddressLb setFont:[UIFont systemFontOfSize:AdaptedWidth(12)]];
        _lbAddressLb.textColor = [UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR];
        _lbAddressLb.textAlignment = NSTextAlignmentLeft;
        _lbAddressLb.numberOfLines = 0;
    }
    return _lbAddressLb;
}
//-(NSMutableArray *)arrLogisticsArr{
//    if (!_arrLogisticsArr) {
//        _arrLogisticsArr = [[NSMutableArray alloc]init];
//    }
//    return _arrLogisticsArr;
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


@end
