//
//  LSTitleValueTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSTitleValueTableViewCell.h"
#import "ZTMXFMessageVoiceAlertView.h"

@implementation LSTitleValueTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSTitleValueTableViewCell";
    LSTitleValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSTitleValueTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _showRowImageView = YES;
        [self setupViews];
        
    }
    return self;
}

//  添加子控件
- (void)setupViews{
    
    /** title label */
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:16 alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    /** value label */
    self.valueLabel = [UILabel labelWithTitleColor:COLOR_WORD_GRAY_2 fontSize:14 alignment:NSTextAlignmentRight];
    self.valueLabel.numberOfLines = 0;
    [self.contentView addSubview:self.valueLabel];
    
    self.rowImageView = [UIImageView setupImageViewWithImageName:@"XL_common_right_arrow" withSuperView:self.contentView];
    self.rowImageView.contentMode = UIViewContentModeCenter;
    
    self.logoLabel = [UILabel labelWithTitleColorStr:COLOR_BLUE_STR fontSize:11 alignment:NSTextAlignmentCenter];
    self.logoLabel.layer.cornerRadius = 8.0;
    self.logoLabel.clipsToBounds = YES;
    [self.contentView addSubview:self.logoLabel];
    self.logoLabel.hidden = YES;
    
    /** bottomLineView */
    self.bottomLineView = [UIView setupViewWithSuperView:self.contentView withBGColor:COLOR_BORDER_STR];
    
    self.voiceSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KW - 60, 6, 100, 40)];
    _voiceSwitch.onTintColor = K_MainColor;
    _voiceSwitch.transform = CGAffineTransformMakeScale(0.9, 0.9);//缩放
    [self.contentView addSubview:self.voiceSwitch];
    [self.voiceSwitch addTarget:self action:@selector(voiceSwitchAction) forControlEvents:UIControlEventValueChanged];
    _voiceSwitch.hidden = YES;
    _voiceSwitch.on = ![USER_DEFAULT boolForKey:k_VoiceSwitch];

}
- (void)voiceSwitchAction
{
    if (![USER_DEFAULT boolForKey:k_VoiceSwitch]) {
        [ZTMXFMessageVoiceAlertView showVoiceWithConfirmBlock:^{
            _voiceSwitch.on = YES;
            [USER_DEFAULT setBool:NO forKey:k_VoiceSwitch];
            [USER_DEFAULT synchronize];
            
        } cancelBlock:^{
            _voiceSwitch.on = NO;
            [USER_DEFAULT setBool:YES forKey:k_VoiceSwitch];
            [USER_DEFAULT synchronize];

        }];
    }else{
        _voiceSwitch.on = YES;
        [USER_DEFAULT setBool:NO forKey:k_VoiceSwitch];
        [USER_DEFAULT synchronize];
    }
}


//  未认证状态
- (void)identityNotAuthState{
    self.logoLabel.text = @"未认证";
    self.logoLabel.layer.borderColor = [UIColor colorWithHexString:COLOR_BLUE_STR].CGColor;
    self.logoLabel.textColor = [UIColor colorWithHexString:COLOR_BLUE_STR];
    self.logoLabel.layer.borderWidth = 1.0;
}

//  已认证状态
- (void)identityAuthState{
    self.logoLabel.text = @"已认证";
    self.logoLabel.layer.borderColor = [UIColor colorWithHexString:COLOR_RED_STR].CGColor;
    self.logoLabel.textColor = [UIColor colorWithHexString:COLOR_RED_STR];
    self.logoLabel.layer.borderWidth = 1.0;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    CGFloat leftMargin = 12.0;
    CGFloat rowImageViewWidth = 8.0;
    
    self.titleLabel.frame = CGRectMake(leftMargin, 0.0, cellWidth - 200.0, cellHeight);
    
    if (self.showRowImageView) {
        self.rowImageView.hidden = NO;
        self.valueLabel.frame = CGRectMake(0.0, 0.0, cellWidth - leftMargin - rowImageViewWidth - 5.0, cellHeight);
        self.rowImageView.frame = CGRectMake(cellWidth - leftMargin - rowImageViewWidth, 0.0, rowImageViewWidth, cellHeight);
        
    } else {
        self.rowImageView.hidden = YES;
        self.valueLabel.frame = CGRectMake(0.0, 0.0, cellWidth - leftMargin, cellHeight);
    }
    
    if ([self.logoLabel.text isEqualToString:@"已认证"] || [self.logoLabel.text isEqualToString:@"未认证"]) {
        self.logoLabel.hidden = NO;
        self.rowImageView.hidden = YES;
        CGFloat logoLabelWidth = 46.0;
        CGFloat logoLabelHeight = 18.0;
        self.valueLabel.frame = CGRectMake(cellWidth - 220.0, 0.0, 220.0 - leftMargin - 8.0 - logoLabelWidth, cellHeight);
        self.logoLabel.frame = CGRectMake(cellWidth - leftMargin - logoLabelWidth, (cellHeight - logoLabelHeight) / 2.0, logoLabelWidth, logoLabelHeight);
    } else {
        self.logoLabel.text = @"";
        self.logoLabel.hidden = YES;
    }
    
    self.bottomLineView.frame = CGRectMake(0.0, cellHeight - 0.5, cellWidth, 0.5);
}

- (void)setShowRowImageView:(BOOL)showRowImageView{
    _showRowImageView = showRowImageView;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)identityAuthWithState:(BOOL)state{
    self.logoLabel.hidden = NO;
    self.rowImageView.hidden = YES;
    if (state) {
        //  已认证
        [self identityAuthState];
    } else {
        //  未认证
        [self identityNotAuthState];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
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
