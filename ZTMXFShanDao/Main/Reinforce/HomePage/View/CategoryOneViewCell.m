//
//  CategoryOneViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CategoryOneViewCell.h"
#import "ALATitleValueCellView.h"

@interface CategoryOneViewCell ()
@property (nonatomic, strong) UIView    *gapView;

@property (nonatomic, strong) ALATitleValueCellView *titleCellView;
@property (nonatomic, strong) UIButton *topImageButton;
@property (nonatomic, strong) UIButton *leftImageButton;
@property (nonatomic, strong) UIButton *rightImageButton;

@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *leftValueLabel;

@property (nonatomic, strong) UILabel *rightTitleLabel;
@property (nonatomic, strong) UILabel *rightValueLabel;

@end

@implementation CategoryOneViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CategoryOneViewCell";
    CategoryOneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CategoryOneViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



//  添加子控件
- (void)setupViews{
    [self.contentView addSubview:self.gapView];
    [self.contentView addSubview:self.titleCellView];
    [self.contentView addSubview:self.topImageButton];
    [self.contentView addSubview:self.leftImageButton];
    [self.contentView addSubview:self.rightImageButton];
 
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.leftValueLabel];
    
    [self.contentView addSubview:self.rightTitleLabel];
    [self.contentView addSubview:self.rightValueLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellWidth = self.bounds.size.width;
    self.gapView.frame = CGRectMake(0.0, 0.0, cellWidth, AdaptedHeight(8.0));
    
    CGFloat leftMargin = AdaptedWidth(12.0);
    self.titleCellView.frame = CGRectMake(0.0, CGRectGetMaxY(self.gapView.frame), cellWidth, AdaptedHeight(46.0));
    self.topImageButton.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.titleCellView.frame), Main_Screen_Width - leftMargin * 2, AdaptedHeight(118.0));
    
    CGFloat buttonMargin = AdaptedWidth(7.0);
    CGFloat buttonWidth = (cellWidth - leftMargin * 2 -  buttonMargin) / 2.0;
    CGFloat buttonHeight = AdaptedHeight(98.0);
    self.leftImageButton.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.topImageButton.frame) + AdaptedHeight(10.0), buttonWidth, buttonHeight);
    self.rightImageButton.frame = CGRectMake(CGRectGetMaxX(self.leftImageButton.frame) + buttonMargin, CGRectGetMinY(self.leftImageButton.frame), buttonWidth, buttonHeight);
    
    CGSize leftTitleSize = [self.leftTitleLabel.text sizeWithFont:self.leftTitleLabel.font maxW:MAXFLOAT];
    self.leftTitleLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.leftImageButton.frame) + AdaptedHeight(6.0), leftTitleSize.width + 10.0, leftTitleSize.height + 8.0);

    CGSize leftValueSize = [self.leftValueLabel.text sizeWithFont:self.leftValueLabel.font maxW:MAXFLOAT];
    self.leftValueLabel.frame = CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame) - 2.0, CGRectGetMaxY(self.leftImageButton.frame) + AdaptedHeight(6.0), leftValueSize.width + 10.0, leftValueSize.height + 8.0);

    CGSize rightTitleSize = [self.rightTitleLabel.text sizeWithFont:self.rightTitleLabel.font maxW:MAXFLOAT];
    self.rightTitleLabel.frame = CGRectMake(CGRectGetMinX(self.rightImageButton.frame), CGRectGetMaxY(self.leftImageButton.frame) + AdaptedHeight(6.0), rightTitleSize.width + 10.0, rightTitleSize.height + 8.0);

    CGSize rightValueSize = [self.rightValueLabel.text sizeWithFont:self.rightValueLabel.font maxW:MAXFLOAT];
    self.rightValueLabel.frame = CGRectMake(CGRectGetMaxX(self.rightTitleLabel.frame) - 2.0, CGRectGetMaxY(self.leftImageButton.frame) + AdaptedHeight(6.0), rightValueSize.width + 10.0, rightValueSize.height + 8.0);

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
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}
- (UIView *)gapView{
    if (_gapView == nil) {
        _gapView = [[UIView alloc] init];
        _gapView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _gapView;
}

- (ALATitleValueCellView *)titleCellView{
    if (_titleCellView == nil) {
        _titleCellView = [[ALATitleValueCellView alloc] initWithTitle:@"手机数码" value:@"更多" target:self action:@selector(viewMoreAction)];
        _titleCellView.showRowImageView = YES;
        _titleCellView.showBottomLineView = NO;
        _titleCellView.backgroundColor = [UIColor whiteColor];
    }
    return _titleCellView;
}

- (UIButton *)topImageButton{
    if (_topImageButton == nil) {
        _topImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topImageButton.backgroundColor = [UIColor redColor];
        [_topImageButton addTarget:self action:@selector(topImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topImageButton;
}

- (UIButton *)leftImageButton{
    if (_leftImageButton == nil) {
        _leftImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftImageButton.backgroundColor = [UIColor orangeColor];
        [_leftImageButton addTarget:self action:@selector(leftImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftImageButton;
}

- (UIButton *)rightImageButton{
    if (_rightImageButton == nil) {
        _rightImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightImageButton.backgroundColor = [UIColor greenColor];
        [_rightImageButton addTarget:self action:@selector(rightImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightImageButton;
}

- (UILabel *)leftTitleLabel{
    if (_leftTitleLabel == nil) {
        _leftTitleLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:11 alignment:NSTextAlignmentCenter];
        _leftTitleLabel.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_STR];
        _leftTitleLabel.text = @"月供";
    }
    return _leftTitleLabel;
}

- (UILabel *)leftValueLabel{
    if (_leftValueLabel == nil) {
        _leftValueLabel = [UILabel labelWithTitleColorStr:COLOR_BLUE_STR fontSize:11 alignment:NSTextAlignmentCenter];
        _leftValueLabel.layer.borderWidth = 1.0;
        _leftValueLabel.layer.borderColor = [UIColor colorWithHexString:COLOR_BLUE_STR].CGColor;
        _leftValueLabel.layer.cornerRadius = 2;
        _leftValueLabel.text = @"最低400/6期";
    }
    return _leftValueLabel;
}

- (UILabel *)rightTitleLabel{
    if (_rightTitleLabel == nil) {
        _rightTitleLabel = [UILabel labelWithTitleColorStr:COLOR_WHITE_STR fontSize:11 alignment:NSTextAlignmentCenter];
        _rightTitleLabel.backgroundColor = [UIColor colorWithHexString:COLOR_BLUE_STR];
        _rightTitleLabel.text = @"月供";
    }
    return _rightTitleLabel;
}

- (UILabel *)rightValueLabel{
    if (_rightValueLabel == nil) {
        _rightValueLabel = [UILabel labelWithTitleColorStr:COLOR_BLUE_STR fontSize:11 alignment:NSTextAlignmentCenter];
        _rightValueLabel.layer.borderWidth = 1.0;
        _rightValueLabel.layer.borderColor = [UIColor colorWithHexString:COLOR_BLUE_STR].CGColor;
        _rightValueLabel.layer.cornerRadius = 2;
        _rightValueLabel.text = @"最低400/6期";
    }
    return _rightValueLabel;
}


#pragma mark - 点击事件
//  查看更多
- (void)viewMoreAction{
    
}

//  点击上面图片按钮
- (void)topImageButtonAction{
    
}

//  点击左下图片按钮
- (void)leftImageButtonAction{
    
}

//  点击右下图片按钮
- (void)rightImageButtonAction{
    
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
