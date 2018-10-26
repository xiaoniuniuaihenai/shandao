//
//  LSCouponListTableViewCellNew.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/6/22.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LSCouponListTableViewCellNew.h"
#import "CounponModel.h"

@interface LSCouponListTableViewCellNew ()

//左侧渐变色背景View
@property (nonatomic, strong) UIImageView  *backgroundImageView;
//人民币标志Label
@property (nonatomic, strong) UILabel       *RMBLabel;
//左侧 借款券/还款券
@property (nonatomic, strong) UILabel *vouchersTypeLabel;
//优惠券金额
@property (nonatomic, strong) UILabel *vouchersFeeLabel;
//优惠券title
@property (nonatomic, strong) UILabel *vouchersNameLabel;
//优惠券限制条件
@property (nonatomic, strong) UILabel *vouchersLimitLabel;
//立即使用按钮
@property (nonatomic, strong) UILabel  *selectedLabel;
//有效期
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation LSCouponListTableViewCellNew

- (void)setCouponModel:(CounponModel *)couponModel{
    _couponModel = couponModel;
    self.vouchersNameLabel.text = _couponModel.name;
    self.vouchersLimitLabel.text = _couponModel.useRule;
    
    UIFont *bigFont = FONT_Medium(X(50));
    UIFont *smallFont = FONT_Medium(X(16));
    CGFloat capHeight = bigFont.pointSize - smallFont.pointSize;
     NSAttributedString *string25 = [[NSAttributedString alloc] initWithString:@"￥" attributes:@{NSFontAttributeName : smallFont,NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @(capHeight - 5)}];
    
    NSAttributedString *string26 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f", _couponModel.amount] attributes:@{NSFontAttributeName : bigFont,NSForegroundColorAttributeName : [UIColor whiteColor],NSBaselineOffsetAttributeName : @(0)}];
    NSMutableAttributedString *attributeString6 = [[NSMutableAttributedString alloc] init];
    [attributeString6 appendAttributedString:string25];
    [attributeString6 appendAttributedString:string26];
    self.vouchersFeeLabel.attributedText = attributeString6;
    
    NSString *dateStart = [NSDate dateYMDacrossStringFromLongDate:_couponModel.gmtStart];
    NSString *dateEnd = [NSDate dateYMDacrossStringFromLongDate:_couponModel.gmtEnd];
    self.timeLabel.text = [NSString stringWithFormat:@"有效期: %@至%@",dateStart,dateEnd];
    
    /*
    if ([couponModel.type isEqualToString:@"0"]) {
        self.vouchersTypeLabel.text = @"还款券";
        self.backgroundImageView.image = [UIImage imageNamed:@"XL_HuanKuanQuan"];
    }else if ([couponModel.type isEqualToString:@"6"]){
        self.vouchersTypeLabel.text = @"借款券";
        self.backgroundImageView.image = [UIImage imageNamed:@"XL_JieKuanQuan"];
    }
     */
    if ([couponModel.type isEqualToString:@"6"]) {
        self.vouchersTypeLabel.text = @"借款券";
        self.backgroundImageView.image = [UIImage imageNamed:@"XL_JieKuanQuan"];
        
    }else{
        self.vouchersTypeLabel.text = @"还款券";
        self.backgroundImageView.image = [UIImage imageNamed:@"XL_HuanKuanQuan"];
    }
    
    //1.2.0_lis
    if (couponModel.status == 1) {
        self.RMBLabel.textColor = UIColor.whiteColor;
        self.vouchersFeeLabel.textColor = K_FFFFFF;
        self.vouchersTypeLabel.backgroundColor = K_FFFFFF;
        self.vouchersTypeLabel.textColor = [UIColor colorWithHexString:@"#FD6B5A"];
        self.selectedLabel.text = @"立即使用";
        self.selectedLabel.backgroundColor = [UIColor colorWithHexString:@"##FD4F3C"];
        self.vouchersNameLabel.textColor = K_FFFFFF;
        self.vouchersLimitLabel.textColor = K_FFFFFF;
        self.selectedLabel.textColor = K_FFFFFF;
        self.selectedLabel.layer.borderColor = K_FFFFFF.CGColor;
        self.timeLabel.textColor = K_FFFFFF;
    }else{
        self.RMBLabel.textColor = [UIColor colorWithHexString:@"#F0F0F0"];
        self.vouchersFeeLabel.textColor = [UIColor colorWithHexString:@"#F0F0F0"];
        self.vouchersTypeLabel.backgroundColor = K_FFFFFF;
        self.vouchersTypeLabel.textColor = [UIColor colorWithHexString:@"#FE924A"];
        self.selectedLabel.text = @"暂不可用";
        self.selectedLabel.backgroundColor = [UIColor colorWithHexString:@"##F5D1B8"];
        self.vouchersNameLabel.textColor = [UIColor colorWithHexString:@"#F0F0F0"];
        self.vouchersLimitLabel.textColor = [UIColor colorWithHexString:@"#F0F0F0"];
        self.selectedLabel.textColor = K_888888;
        self.selectedLabel.layer.borderWidth = 0;
        //self.selectedLabel.layer.borderColor = [UIColor colorWithHexString:@"#F0F0F0"].CGColor;
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#F0F0F0"];
    }
}

- (void)setIsMine:(BOOL)isMine{
    _isMine = isMine;
    if (_isMine == YES) {
        self.selectedLabel.hidden  = YES;
    }else{
        self.selectedLabel.hidden  = NO;
    }
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += X(10);
    frame.origin.y += X(10);
    frame.size.height -= X(10);
    frame.size.width -= X(20);
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    [super setFrame:frame];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSCouponListTableViewCellNew";
    LSCouponListTableViewCellNew *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSCouponListTableViewCellNew alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.backgroundColor = K_BackgroundColor;
    self.backgroundImageView = [[UIImageView alloc]init];
//    self.backgroundImageView.backgroundColor = K_BackgroundColor;
//    self.backgroundImageView.image = [UIImage imageNamed:@"XL_JieKuanQuan"];
    [self addSubview:self.backgroundImageView];
    
    //lis
    self.RMBLabel = [[UILabel alloc]init];
    self.RMBLabel.font = FONT_Medium(16);
    self.RMBLabel.textColor = UIColor.whiteColor;
    self.RMBLabel.text = @"¥";
    self.RMBLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundImageView addSubview:self.RMBLabel];;
    
    self.vouchersTypeLabel = [[UILabel alloc]init];
    self.vouchersTypeLabel.layer.cornerRadius = X(2);
    self.vouchersTypeLabel.layer.masksToBounds = YES;
    self.vouchersTypeLabel.layer.borderColor = UIColor.whiteColor.CGColor;
    self.vouchersTypeLabel.layer.borderWidth = 1;
    self.vouchersTypeLabel.font = FONT_Regular(X(12));
    self.vouchersTypeLabel.textColor = UIColor.whiteColor;
    self.vouchersTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.vouchersTypeLabel.text = @"借款券";
    [self.backgroundImageView addSubview:self.vouchersTypeLabel];
    
    self.vouchersFeeLabel = [[UILabel alloc]init];
    self.vouchersFeeLabel.font = FONT_SYSTEM(50) ;
    self.vouchersFeeLabel.textColor = UIColor.whiteColor;
    //self.vouchersFeeLabel.isAttributedContent = YES;
    self.vouchersFeeLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundImageView addSubview:self.vouchersFeeLabel];
    
    self.vouchersNameLabel = [[UILabel alloc]init];
    self.vouchersNameLabel.textColor = K_333333;
    self.vouchersNameLabel.font = FONT_Medium(X(17));
    [self.backgroundImageView addSubview:self.vouchersNameLabel];
    
    self.vouchersLimitLabel = [[UILabel alloc]init];
    self.vouchersLimitLabel.textColor = K_333333;
    self.vouchersLimitLabel.font = FONT_Regular(X(14));
    [self.backgroundImageView addSubview:self.vouchersLimitLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = FONT_Regular(X(12));
    self.timeLabel.textColor = K_888888;
    [self.backgroundImageView addSubview:self.timeLabel];
    
    self.selectedLabel = [[UILabel alloc]init];
    self.selectedLabel.layer.cornerRadius = X(5);
    self.selectedLabel.layer.borderColor = K_MainColor.CGColor;
    self.selectedLabel.layer.borderWidth = 1;
    self.selectedLabel.layer.masksToBounds = YES;
    self.selectedLabel.font = FONT_Regular(X(14));
    self.selectedLabel.textAlignment = NSTextAlignmentCenter;
    [self.backgroundImageView addSubview:self.selectedLabel];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self);
    }];
    
    //lis
//    [self.RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_backgroundImageView).mas_offset(X(10));
//        make.top.mas_equalTo(X(18));
//        make.width.mas_equalTo(X(10));
//        make.height.mas_equalTo(X(22));
//    }];
    
    [self.vouchersFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(_backgroundImageView.mas_left);
        make.top.mas_equalTo(_backgroundImageView).mas_equalTo(X(5));
        make.width.mas_equalTo(X(90));
        make.height.mas_equalTo(X(73));

    }];
    [self.vouchersTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(X(22));
        make.bottom.mas_equalTo(_backgroundImageView.mas_bottom).mas_offset(X(-15.2));
        make.width.mas_equalTo(X(56));
        make.height.mas_equalTo(X(22.8));
        
    }];
    
    
    [self.vouchersNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backgroundImageView.mas_left).mas_offset(X(120));
        make.centerY.mas_equalTo(_backgroundImageView.mas_top).mas_offset(X(26.5));
        make.width.mas_equalTo(X(150));
    }];
    [self.vouchersLimitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_vouchersNameLabel);
        make.top.mas_equalTo(_vouchersNameLabel.mas_bottom).mas_offset(X(4));
        make.height.mas_equalTo(X(20));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_vouchersNameLabel.mas_left);
        make.centerY.mas_equalTo(_backgroundImageView.mas_bottom).mas_offset(X(-22.5));
        make.width.mas_equalTo(X(200));
        make.height.mas_equalTo(X(17));
    }];
    [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_backgroundImageView.mas_right).mas_equalTo(X(-14));
        make.top.mas_equalTo(X(18));
        make.width.mas_equalTo(X(64));
        make.height.mas_equalTo(X(25.6));
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
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
