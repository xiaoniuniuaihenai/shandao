//
//  XLLoanRenewalTopCell.m
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/5/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "XLLoanRenewalTopCell.h"
#import <Masonry.h>

@interface XLLoanRenewalTopCell()

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation XLLoanRenewalTopCell

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.leftLabel.text = dict.allKeys.firstObject;
    self.rightLabel.text = dict.allValues.firstObject;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (UILabel *)leftLabel{
    return _leftLabel?:({
        _leftLabel = [UILabel new];
        _leftLabel.font = FONT_Regular(16 * PX);
        _leftLabel.frame = CGRectMake(10 * PX, 0, KW / 2 - 10, 45);
        _leftLabel;
    });
}

- (UILabel *)rightLabel{
    return _rightLabel?:({
        _rightLabel = [UILabel new];
        _rightLabel.font = FONT_Regular(16 * PX);
        _rightLabel.frame = CGRectMake(KW / 2, 0, KW / 2 - 10, 45);
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel;
    });
}

@end
