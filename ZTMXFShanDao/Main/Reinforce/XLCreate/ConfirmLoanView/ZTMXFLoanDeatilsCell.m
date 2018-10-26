//
//  ZTMXFLoanDeatilsCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/17.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFLoanDeatilsCell.h"
#import "LSBorrwingCashInfoModel.h"
@interface ZTMXFLoanDeatilsCell ()
/**
 借款期限
 */
@property (nonatomic, strong)UILabel * timeLimitLabel;
/**
 商品金额
 */
@property (nonatomic, strong)UILabel * amountLabel;
/**
 借款用途
 */
@property (nonatomic, strong)UILabel * useLabel;
/**
 服务费
 */
@property (nonatomic, strong)UILabel *  serviceFeeLabel;



@end


@implementation ZTMXFLoanDeatilsCell



+(id)cellWithTableView:(UITableView *)tableView
{
    static NSString * cellStr = @"ZTMXFLoanDeatilsCell";
    ZTMXFLoanDeatilsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[ZTMXFLoanDeatilsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        UIView * garyView = [[UIView alloc] init];
//        garyView.backgroundColor = UIColor.yellowColor; FAB179
        garyView.backgroundColor = [COLOR_SRT(@"#FAB179") colorWithAlphaComponent:0.06]; //F6F7F9
        [self addSubview:garyView];
        garyView.frame = CGRectMake(X(16), 0, KW - X(32), 80 * PX);
//        [garyView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.mas_left).mas_offset(@(X(12)));
//            make.right.mas_equalTo(self.mas_right).mas_offset(@(X(-12)));
//            make.top.mas_equalTo(self.mas_top);
//            make.height.mas_equalTo(@(X(80)));
//        }];
//        garyView.sd_layout
//        .leftSpaceToView(self.contentView, 12)
//        .rightSpaceToView(self.contentView, 12)
//        .topEqualToView(self.contentView)
//        .heightIs(80 * PX);
        NSArray * titles = @[@"提现期限",@"商品金额",@"提现用途",@"服务费"];
        int count = 0;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(j * garyView.width / 2 + 20 * PX, i * garyView.height / 2, X(70), garyView.height / 2)];
                label.text = titles[count];
                label.font = FONT_Regular(12 * PX);
                label.textColor = COLOR_SRT(@"#9B9B9B");
                [garyView addSubview:label];
                
//                [label mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.mas_equalTo(garyView.mas_left).mas_offset(@(j * garyView.width / 2 + 20 * PX));
//                    make.top.mas_equalTo(garyView.mas_top).mas_offset(@(i * garyView.height / 2));
//                    make.width.mas_equalTo(X(70));
//                    make.height.mas_equalTo(@(garyView.height / 2));
//                }];
                
                UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.right + X(10), label.top, label.width, label.height)];
                textLabel.font = FONT_Regular(12 * PX);
                textLabel.textColor = COLOR_SRT(@"#4A4A4A");
                [garyView addSubview:textLabel];
//                [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.mas_equalTo(label.mas_right).mas_offset(@(X(10)));
//                    make.top.mas_equalTo(label.mas_top);
//                    make.width.mas_equalTo(label.mas_width);
//                    make.height.mas_equalTo(label.mas_height);
//                }];
                if (count == 0) {
                    _timeLimitLabel = textLabel;
                }else if (count == 1){
                    _amountLabel = textLabel;
                }else if (count == 2){
                    _useLabel = textLabel;
                }else if (count == 3){
                    _serviceFeeLabel = textLabel;
                }
                
                count++;
            }
        }
    }
    return self;
}

- (void)setCashInfoModel:(LSBorrwingCashInfoModel *)cashInfoModel
{
    _cashInfoModel = cashInfoModel;
    _timeLimitLabel.text = [NSString stringWithFormat:@"%@天", _cashInfoModel.borrowDays];
    _amountLabel.text = [NSString stringWithFormat:@"%.2f元", _cashInfoModel.goodPrice];
     if (_cashInfoModel.borrowApplications.count > 0) {
         _useLabel.text = _cashInfoModel.borrowApplications[0];
     }
    _serviceFeeLabel.text = [NSString stringWithFormat:@"%@元", _cashInfoModel.serviceAmount];

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
