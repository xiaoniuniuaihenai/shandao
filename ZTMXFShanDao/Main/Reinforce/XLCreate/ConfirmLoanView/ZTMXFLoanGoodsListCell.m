//
//  ZTMXFLoanGoodsListCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanGoodsListCell.h"
#import "LSBorrwingCashInfoModel.h"
#import "LSBorrwingCashInfoModel.h"


@implementation ZTMXFLoanGoodsListCell


+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFLoanGoodsListCell";
    ZTMXFLoanGoodsListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFLoanGoodsListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(void)setFrame:(CGRect)frame{
    
    frame.origin.y += X(5);
    frame.size.height -= X(5);
    [super setFrame:frame];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _goodsIconView = [UIImageView new];
        
        [self.contentView addSubview:_goodsIconView];
        
        
        self.goodsIconView.backgroundColor = K_BackgroundColor;
        
        self.goodsTextLabel = [[UILabel alloc]init];
        self.goodsTextLabel.font = FONT_Regular(16 * PX);
        self.goodsTextLabel.textColor = K_333333;
        self.goodsTextLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.goodsTextLabel];
        
        self.goodsDetailTextLabel = [[UILabel alloc]init];
        self.goodsDetailTextLabel.font = FONT_Regular(14 * PX);
        self.goodsDetailTextLabel.textColor = K_333333;
        self.goodsDetailTextLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.goodsDetailTextLabel];
        //lis
        /*
         [self.detailTextLabel setSingleLineAutoResizeWithMaxWidth:KW / 2];
         self.textLabel.font = FONT_Regular(16 * PX);
         self.textLabel.textColor = K_333333;
         self.detailTextLabel.font = FONT_Regular(14 * PX);
         self.detailTextLabel.textColor = K_333333;
         _bottomLine = [UIView new];
         _bottomLine.backgroundColor = K_LineColor;
         [self.contentView addSubview:_bottomLine];
         
         */
        
        _originalPriceLabel = [UILabel new];
        self.originalPriceLabel.font = FONT_Regular(12 * PX);
        self.originalPriceLabel.textColor = COLOR_SRT(@"#B8B8B8");
        [self.contentView addSubview:_originalPriceLabel];
        
        
        [_originalPriceLabel setSingleLineAutoResizeWithMaxWidth:KW / 2];
        
        
        //lis
        /*
         _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [self.contentView addSubview:_arrowBtn];
         [_arrowBtn setImage:[UIImage imageNamed:@"mine_right_arrow"] forState:UIControlStateNormal];
         
         _detailsTextLabel = [UILabel new];
         self.detailsTextLabel.font = FONT_Regular(14 * PX);
         self.detailsTextLabel.textColor = COLOR_SRT(@"#B8B8B8");
         [self.contentView addSubview:_detailsTextLabel];
         [_detailsTextLabel setSingleLineAutoResizeWithMaxWidth:100];
         _detailsTextLabel.text = @"商品详情";
         */
        
        
        
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setImage:[UIImage imageNamed:@"XL_bill_normal"] forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@"XL_bill_selected"] forState:UIControlStateSelected];
        [_chooseBtn addTarget:self action:@selector(chooseAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_chooseBtn];
        
        self.bottomLine.hidden = YES;
        
        //lis
        
        
        [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(self.contentView);
            make.width.mas_equalTo(X(50));
        }];
        
        [self.goodsIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_chooseBtn.mas_right).offset(X(1));
            make.centerY.mas_equalTo(self.contentView);
            make.width.height.mas_equalTo(X(55));
        }];
        
        [self.goodsTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsIconView.mas_right).offset(X(12));
            make.top.mas_equalTo(_goodsIconView.mas_top).offset(X(2));
            make.right.mas_equalTo(self.contentView.mas_right).offset(20);
            make.height.mas_offset(X(22));
        }];
        
        [self.goodsDetailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsIconView.mas_right).offset(X(12));
            make.bottom.mas_equalTo(_goodsIconView.mas_bottom).offset(X(-2));
            make.height.mas_equalTo(X(20));
            make.width.mas_equalTo(X(100));
        }];
        [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsDetailTextLabel.mas_right).offset(X(8));
            make.bottom.mas_equalTo(_goodsIconView.mas_bottom).offset(X(-2));
            make.height.mas_equalTo(X(17));
            make.width.mas_equalTo(X(65));
        }];
        //lis
        /*
         self.chooseBtn.sd_layout
         .leftEqualToView(self.contentView)
         .topEqualToView(self.contentView)
         .bottomEqualToView(self.contentView)
         .widthIs(50 * PX);
         
         self.goodsIconView.sd_layout
         .leftSpaceToView(self.chooseBtn, 1)
         .heightIs(55 * PX)
         .widthIs(55 * PX)
         .centerYEqualToView(self.contentView);
         
         self.textLabel.sd_layout
         .leftSpaceToView(self.goodsIconView, 12)
         .topSpaceToView(self.goodsIconView,2)
         .heightIs(22 * PX)
         .rightSpaceToView(self.contentView, 20);
         
         self.detailTextLabel.sd_layout
         .leftEqualToView(self.textLabel)
         .heightIs(20 * PX)
         .bottomSpaceToView(self.goodsIconView,2);
         
         self.bottomLine.hidden = YES;
         
         self.originalPriceLabel.sd_layout
         .leftSpaceToView(self.detailTextLabel, 8)
         .bottomEqualToView(self.detailTextLabel)
         .heightIs(17 * PX);
         
         
         
         self.arrowBtn.sd_layout
         .rightSpaceToView(self.contentView, 10)
         .centerYEqualToView(self.detailTextLabel)
         .heightIs(20)
         .widthIs(15);
         
         
         self.detailsTextLabel.sd_layout
         .centerYEqualToView(self.arrowBtn)
         .heightIs(20 * PX)
         .rightSpaceToView(self.arrowBtn, 1);
         */
        
    }
    return self;
}



- (void)setGoodsInfoModel:(GoodsInfoModel *)goodsInfoModel
{
    _goodsInfoModel = goodsInfoModel;
    _chooseBtn.selected = goodsInfoModel.selected;
    [self.goodsIconView sd_setImageWithURL:[NSURL URLWithString:_goodsInfoModel.goodsIcon] placeholderImage:nil];
    self.goodsTextLabel.text = _goodsInfoModel.name;
    self.goodsDetailTextLabel.text = [NSString stringWithFormat:@"优惠价:%@元", [NSDecimalNumber decimalNumberWithString:_goodsInfoModel.price]];
    
    NSString *oldPrice = [NSString stringWithFormat:@"原价:%@元", [NSDecimalNumber decimalNumberWithString:_goodsInfoModel.originPrice]];
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:COLOR_SRT(@"#CFCECE") range:NSMakeRange(0, length)];
    [_originalPriceLabel setAttributedText:attri];
    
}
- (void)chooseAction
{
    _chooseBtn.selected = YES;
    _chooseBtn.transform = CGAffineTransformMakeScale(0.7, 0.7);
    self.goodsInfoModel.selected = YES;
    if (_clickHandle) {
        _clickHandle(self);
    }
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        _chooseBtn.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        //        if (_clickHandle) {
        //            self.goodsInfoModel.selected = YES;
        //            _clickHandle(self);
        //        }
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
