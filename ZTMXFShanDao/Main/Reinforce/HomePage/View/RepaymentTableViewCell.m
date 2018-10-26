//
//  RepaymentTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "RepaymentTableViewCell.h"
#import "OrderDetailInfoModel.h"
@interface RepaymentTableViewCell ()
@property (nonatomic,strong) UILabel * lbLeftLb;
@property (nonatomic,strong) UILabel * lbOneLb;
@property (nonatomic,strong) UIView  * viLineView;
@property (nonatomic,strong) UILabel * lbTwoLb;

@end
@implementation RepaymentTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configAddSubview];
        [self configSubviewFrame];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark ---
-(void)setNperInfoModel:(OrderGoodsNperInfoModel *)nperInfoModel{
    _nperInfoModel = nperInfoModel;
    _lbLeftLb.text = _nperInfoModel.stageNum;
    NSString * stageAmount = [NSString moneyDeleteMoreZeroWithAmountStr:_nperInfoModel.stageAmount];
    _lbOneLb.text = [NSString stringWithFormat:@"￥ %@",stageAmount];
    _lbTwoLb.text = _nperInfoModel.stageDetail;
}
#pragma mark-----
-(void)configAddSubview{
    [self.contentView addSubview:self.lbLeftLb];
    [self.contentView addSubview:self.viLineView];
    [self.contentView addSubview:self.lbOneLb];
    [self.contentView addSubview:self.lbTwoLb];
    
}
-(void)configSubviewFrame{
    _lbLeftLb.left = 0;
    _lbLeftLb.top = AdaptedWidth(12);
    _lbLeftLb.width = AdaptedWidth(80);
    _lbLeftLb.height = AdaptedWidth(22);
    
    [_viLineView setFrame:CGRectMake(_lbLeftLb.right, _lbLeftLb.top, 1, AdaptedWidth(40))];
    [_lbOneLb setFrame:CGRectMake(_viLineView.right +AdaptedWidth(8), _viLineView.top, AdaptedWidth(320)-_lbLeftLb.left, AdaptedWidth(22))];
    [_lbTwoLb setFrame:CGRectMake(_lbOneLb.left, _lbOneLb.bottom + AdaptedWidth(5),_lbOneLb.width, AdaptedWidth(20))];
}
#pragma mark -----
-(UILabel *)lbLeftLb{
    if (!_lbLeftLb) {
        _lbLeftLb = [[UILabel alloc]init];
        [_lbLeftLb setFont:[UIFont systemFontOfSize:AdaptedWidth(16)]];
        [_lbLeftLb setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
        _lbLeftLb.textAlignment = NSTextAlignmentCenter;
        _lbLeftLb.numberOfLines = 0;
    }
    return _lbLeftLb;
}
-(UIView *)viLineView{
    if (!_viLineView) {
        _viLineView = [[UIView alloc]init];
        [_viLineView setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    }
    return _viLineView;
}
-(UILabel *)lbOneLb{
    if (!_lbOneLb) {
        _lbOneLb = [[UILabel alloc]init];
        [_lbOneLb setFont:[UIFont systemFontOfSize:AdaptedWidth(17)]];
        [_lbOneLb setTextColor:[UIColor colorWithHexString:COLOR_BLACK_STR]];
        _lbOneLb.textAlignment = NSTextAlignmentLeft;
        
    }
    return _lbOneLb;
}
-(UILabel *)lbTwoLb{
    if (!_lbTwoLb) {
        _lbTwoLb = [[UILabel alloc]init];
        [_lbTwoLb setFont:[UIFont systemFontOfSize:AdaptedWidth(14)]];
        [_lbTwoLb setTextColor:[UIColor colorWithHexString:COLOR_LIGHT_GRAY_STR]];
        _lbTwoLb.textAlignment = NSTextAlignmentLeft;
        _lbTwoLb.adjustsFontSizeToFitWidth = YES;
    }
    return _lbTwoLb;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
@end
