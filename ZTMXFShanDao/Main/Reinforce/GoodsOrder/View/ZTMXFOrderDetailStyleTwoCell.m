//
//  OrderDetailStyleTwoCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderDetailStyleTwoCell.h"

@interface ZTMXFOrderDetailStyleTwoCell ()

@property (nonatomic, assign) CGFloat lineLeftMargin;

@end

@implementation ZTMXFOrderDetailStyleTwoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"OrderDetailStyleTwoCell";
    ZTMXFOrderDetailStyleTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZTMXFOrderDetailStyleTwoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupViews];
        
    }
    return self;
}



/** title label */
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel labelWithTitleColorStr:COLOR_LIGHT_GRAY_STR fontSize:12 alignment:NSTextAlignmentLeft];
        _titleLabel.text = @"订单编号";
    }
    return _titleLabel;
}
//  添加子控件
- (void)setupViews{
    /** title label */
    [self addSubview:self.titleLabel];
    /** value label */
    [self addSubview:self.valueLabel];
    /** value Button */
    [self addSubview:self.valueButton];
    /** bottom line View */
    [self addSubview:self.lineView];
    self.lineView.hidden = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat viewHeight = self.bounds.size.height;
    CGFloat leftMargin = AdaptedWidth(12.0);
    CGFloat rightMargin = AdaptedWidth(12.0);
    /** title label */
    self.titleLabel.frame = CGRectMake(leftMargin, 0.0, AdaptedWidth(60.0), viewHeight);
    /** value label */
    CGFloat valueLabelW = viewWidth - CGRectGetMaxX(self.titleLabel.frame) - rightMargin;
    self.valueLabel.frame = CGRectMake(viewWidth - valueLabelW - rightMargin, 0.0, valueLabelW, viewHeight);
    /** value Button */
    CGFloat valueButtonW = AdaptedWidth(60.0);
    CGFloat valueButtonH = AdaptedHeight(24.0);
    CGFloat valueButtonY = (viewHeight - valueButtonH) / 2.0;
    self.valueButton.frame = CGRectMake(viewWidth - valueButtonW - AdaptedWidth(20.0), valueButtonY, valueButtonW, valueButtonH);
    /** bottom line View */
    if (_lineLeftMargin > 0) {
        self.lineView.frame = CGRectMake(_lineLeftMargin, viewHeight - 0.5, viewWidth - _lineLeftMargin, 0.5);
    } else {
        self.lineView.frame = CGRectMake(0.0, viewHeight - 0.5, viewWidth, 0.5);
    }
}
/** value label */
- (UILabel *)valueLabel{
    if (_valueLabel == nil) {
        _valueLabel = [UILabel labelWithTitleColorStr:COLOR_GRAY_STR fontSize:13 alignment:NSTextAlignmentLeft];
        _valueLabel.text = @"";
    }
    return _valueLabel;
}
/** value Button */
- (UIButton *)valueButton{
    if (_valueButton == nil) {
        _valueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_valueButton setTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] forState:UIControlStateNormal];
        _valueButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_valueButton setTitle:@"复制" forState:UIControlStateNormal];
        _valueButton.layer.cornerRadius = 5.0;
        _valueButton.layer.borderColor = [UIColor colorWithHexString:@"DEDEDE"].CGColor;
        _valueButton.layer.borderWidth = 1.0;
        [_valueButton addTarget:self action:@selector(valueButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _valueButton;
}
/** bottom line View */
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:COLOR_BORDER_STR];
    }
    return _lineView;
}

#pragma mark - 点击事件
- (void)valueButtonAction{
    //  复制账号到剪切板
    if (!kStringIsEmpty(self.valueLabel.text)) {
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.valueLabel.text;
        [kKeyWindow makeCenterToast:@"复制成功"];
    }
}

/** 细线左边间距 */
- (void)showLineLeftMargin:(CGFloat)leftMargin{
    _lineLeftMargin = leftMargin;
    
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
