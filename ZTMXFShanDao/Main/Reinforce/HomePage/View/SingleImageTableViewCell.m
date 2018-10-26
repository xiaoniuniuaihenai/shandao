//
//  SingleImageTableViewCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/3.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "SingleImageTableViewCell.h"

@interface SingleImageTableViewCell ()

@property (nonatomic, strong) UIImageView *singleImageView;
@property (nonatomic, strong) UIView *gapView;

@end

@implementation SingleImageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SingleImageTableViewCell";
    SingleImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SingleImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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

//  添加子控件


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellWidth = self.bounds.size.width;
    CGFloat cellHeight = self.bounds.size.height;
    self.singleImageView.frame = CGRectMake(0.0, 0.0, cellWidth, cellHeight - AdaptedHeight(5.0));
    self.gapView.frame = CGRectMake(0.0, CGRectGetMaxY(self.singleImageView.frame), cellWidth, AdaptedHeight(5.0));
}


- (void)setupViews{
    [self.contentView addSubview:self.singleImageView];
    [self.contentView addSubview:self.gapView];
}
- (UIImageView *)singleImageView{
    if (_singleImageView == nil) {
        _singleImageView = [[UIImageView alloc] init];
        _singleImageView.userInteractionEnabled = YES;
        _singleImageView.contentMode = UIViewContentModeScaleAspectFill;
        _singleImageView.image = [UIImage imageNamed:@"banner_takeout"];
        _singleImageView.clipsToBounds = YES;
    }
    return _singleImageView;
}

- (UIView *)gapView{
    if (_gapView == nil) {
        _gapView = [[UIView alloc] init];
        _gapView.backgroundColor = [UIColor colorWithHexString:COLOR_LIGHTBG_STR];
    }
    return _gapView;
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
