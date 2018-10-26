//
//  LSIndustryCell.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSIndustryCell.h"

@interface LSIndustryCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation LSIndustryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"LSLoanListTableViewCell";
    LSIndustryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LSIndustryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}



#pragma mark - setter
- (void)setIndustryTitle:(NSString *)industryTitle{
    _industryTitle = industryTitle;
    
    self.titleLabel.text = _industryTitle;
}

#pragma mark - 设置视图
- (void)setupViews{
    
    self.titleLabel = [UILabel labelWithTitleColor:[UIColor colorWithHexString:COLOR_BLACK_STR] fontSize:AdaptedWidth(14) alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    self.lineLabel = [[UILabel alloc] init];
    [self.lineLabel setBackgroundColor:[UIColor colorWithHexString:@"EDEFF0"]];
    [self.contentView addSubview:self.lineLabel];
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
        [self setupViews];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    
    [self.titleLabel setFrame:CGRectMake(12.0, 0, cellWidth-12.0, cellHeight-1.0)];
    [self.lineLabel setFrame:CGRectMake(12.0, cellHeight-1.0, cellWidth-24.0, 1.0)];
}

@end
