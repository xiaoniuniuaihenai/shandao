//
//  OrderDetailStyleOneCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderDetailStyleOneCell.h"

@interface ZTMXFOrderDetailStyleOneCell ()

@property (nonatomic, assign) CGFloat lineLeftMargin;

@end

@implementation ZTMXFOrderDetailStyleOneCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"OrderListTableViewCell";
    ZTMXFOrderDetailStyleOneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZTMXFOrderDetailStyleOneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



//  添加子控件
- (void)setupViews{
    /** title label */
    [self addSubview:self.titleLabel];
    /** value label */
    [self addSubview:self.valueLabel];
    /** value Button */
    [self addSubview:self.valueButton];
    self.valueButton.hidden = YES;
    /** bottom lineView */
    [self addSubview:self.lineView];
    /** top rowImageView */
    [self addSubview:self.topRowImageView];
    self.topRowImageView.hidden = YES;
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
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat leftMargin = AdaptedWidth(12.0);
    CGFloat rightMargin = AdaptedWidth(12.0);
    /** title label */
    self.titleLabel.frame = CGRectMake(leftMargin, 0.0, AdaptedWidth(160.0), viewHeight);
    /** value label */
    CGFloat valueLabelW = AdaptedWidth(200.0);
    CGFloat valueLabelX = viewWidth - valueLabelW - rightMargin;
    if (!self.valueButton.isHidden) {
        valueLabelX = viewWidth - valueLabelW - rightMargin - 20.0;
    }
    self.valueLabel.frame = CGRectMake(valueLabelX, 0.0, valueLabelW, viewHeight);
    /** value Button */
    CGFloat valueButtonW = AdaptedWidth(200.0);
    self.valueButton.frame = CGRectMake(viewWidth - valueButtonW - rightMargin, 0.0, valueButtonW, viewHeight);
    /** bottom lineView */
    if (_lineLeftMargin > 0) {
        self.lineView.frame = CGRectMake(_lineLeftMargin, viewHeight - 0.5, viewWidth - _lineLeftMargin, 0.5);
    } else {
        self.lineView.frame = CGRectMake(0.0, viewHeight - 0.5, viewWidth, 0.5);
    }

    /** top rowImageView */
    CGFloat topRowImageViewW = AdaptedWidth(15.0);
    CGFloat topRowImageViewH = AdaptedHeight(15.0);
    CGFloat topRowImageRightMargin = AdaptedWidth(30.0);
    self.topRowImageView.frame = CGRectMake(viewWidth - topRowImageRightMargin - topRowImageViewW, viewHeight - topRowImageViewH + 4.0, topRowImageViewW, topRowImageViewH);
}

/** title label */
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:14 alignment:NSTextAlignmentLeft];
        _titleLabel.text = @"";
    }
    return _titleLabel;
}
/** value label */
- (UILabel *)valueLabel{
    if (_valueLabel == nil) {
        _valueLabel = [UILabel labelWithTitleColorStr:COLOR_BLACK_STR fontSize:14 alignment:NSTextAlignmentRight];
        _valueLabel.text = @"";
    }
    return _valueLabel;
}
/** value Button */
- (UIButton *)valueButton{
    if (_valueButton == nil) {
        _valueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_valueButton setImage:[UIImage imageNamed:@"goods_nper_icon"] forState:UIControlStateNormal];
        _valueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_valueButton addTarget:self action:@selector(valueButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _valueButton;
}

/** top rowImageView */
- (UIImageView *)topRowImageView{
    if (_topRowImageView == nil) {
        _topRowImageView = [[UIImageView alloc] init];
        _topRowImageView.contentMode = UIViewContentModeScaleAspectFit;
        _topRowImageView.image = [UIImage imageNamed:@"row_top"];
        _topRowImageView.userInteractionEnabled = YES;
    }
    return _topRowImageView;
}

/** bottom lineView */
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

/** 显示valueButton */
- (void)showValueButton:(BOOL)show{
    if (show) {
        self.valueButton.hidden = NO;
    } else {
        self.valueButton.hidden = YES;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/** 细线左边间距 */
- (void)showLineLeftMargin:(CGFloat)leftMargin{
    _lineLeftMargin = leftMargin;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 点击事件
- (void)valueButtonAction{
    NSLog(@"ddd");
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderDetailStyleOneCellClickValueButtonAction)]) {
        [self.delegate orderDetailStyleOneCellClickValueButtonAction];
    }
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
