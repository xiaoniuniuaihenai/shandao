//
//  LSMsgListTableViewCell.m
//  ALAFanBei
//
//  Created by Try on 2017/2/15.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import "LSMsgListTableViewCell.h"
#import "LSNotificationModel.h"
//NSString+Additions
@interface LSMsgListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *lbTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *lbInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *lbTimerLb;
@property (weak, nonatomic) IBOutlet UIView *viBgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgIconView;

@end
@implementation LSMsgListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    _viBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    _viBgView.layer.shadowOffset = CGSizeMake(0,0);
    _viBgView.layer.shadowOpacity = .09;
    _viBgView.layer.shadowRadius = 4;
    [_viBgView.layer setCornerRadius:4];
    _lbTimerLb.font = [UIFont systemFontOfSize:AdaptedWidth(16)];
    _lbInfoLb.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
    _lbTimerLb.font = [UIFont systemFontOfSize:AdaptedWidth(14)];
}
-(void)drawRect:(CGRect)rect{
    _lbInfoLb.numberOfLines = 0;
}
-(void)setNotModel:(LSNotificationModel *)notModel{
    _notModel = notModel;
    NSString * prefixStr = [notModel.pushJumpType substringToIndex:1];
    NSString * imgIconStr = @"";
    if (prefixStr.length>0) {
        NSInteger prefix = [prefixStr integerValue];
        switch (prefix) {
            case 2:
            case 3:
            case 4:{
//            系统消息
                imgIconStr = @"XL_msgNotIcon";
                _notModel.title = @"系统通知";
            }
                break;
            case 5:
            case 6:{
//                物流
                imgIconStr = @"XL_msgLogisticsIcon";
                _notModel.title = @"订单物流";

            }break;
            case 7:{
//                活动
                imgIconStr = @"XL_msgActivityIcon";
                _notModel.title = @"优惠活动";
            }break;
                
            default:
                break;
        }
    }
    _imgIconView.image = [UIImage imageNamed:imgIconStr];
    _lbTitleLb.text = [_notModel.title length]?_notModel.title:@"";
    _lbInfoLb.text = _notModel.message;
    _lbTimerLb.text = [_notModel.time length]?[NSString timeNowNotMsgTimeString:[_notModel.time longLongValue]/1000.]:@"";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
