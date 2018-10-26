//
//  LSShareView.m
//
//  Created by Try on 2017/3/3.
//  Copyright © 2017年 讯秒. All rights reserved.
//

#import "ZTMXFLSShareView.h"
#import "ShareAddRecommendApi.h"
@interface ZTMXFLSShareView()
@property (weak, nonatomic) IBOutlet UIButton *btnHideBtn;
@property (weak, nonatomic) IBOutlet UIView *viOneView; // 微信
@property (weak, nonatomic) IBOutlet UIView *vitTwoView;// 微信朋友圈
@property (weak, nonatomic) IBOutlet UIView *viThreeView;// qq
@property (weak, nonatomic) IBOutlet UIView *viFourView;// qq空间
@property (weak, nonatomic) IBOutlet UIView *viBgView;
@property (nonatomic,strong) NSMutableArray * arrShareArr;
@property (weak, nonatomic) IBOutlet UIView *viMianView;

@property (nonatomic,strong) UIImage * imgCode;
@end
@implementation ZTMXFLSShareView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setBackgroundColor:[UIColor clearColor]];
    
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UITapGestureRecognizer * tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideShareView)];
    [_viBgView addGestureRecognizer:tapG];
    
    _viMianView.layer.cornerRadius = 10;
    _viMianView.layer.masksToBounds = YES;
}
-(NSMutableArray*)arrShareArr
{
    if (!_arrShareArr) {
        _arrShareArr = [[NSMutableArray alloc]init];
       
    }
    return _arrShareArr;
}


- (void)showShareViewWithAnimation{
    _viMianView.frame = CGRectMake(0.0, Main_Screen_Height, SCREEN_WIDTH, 200.0);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.38 animations:^{
        _viMianView.frame = CGRectMake(0.0, Main_Screen_Height - 244.0, SCREEN_WIDTH, 244.0);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)showShareView{
    _viMianView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        _viMianView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}



-(void)hideShareView{
    [UIView animateWithDuration:.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
- (IBAction)btnHideBtnClick:(UIButton *)sender {
    [self hideShareView];
 
}


- (IBAction)btnShareBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        {
//            微信好友
        }
            break;
        case 1:{
//            朋友圈
        }break;
        case 2:{
//            QQ

        }break;
        case 3:{
//            QQ空间

        }
            break;
        default:
            break;
    }
}





 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 // Drawing code
     CGFloat SpaceW = (SCREEN_WIDTH-24-_viOneView.width*4)/3.;
     for (int i = 0; i<[self.arrShareArr count]; i++) {
         UIView * vi = _arrShareArr[i];
         vi.left = 12+i*(vi.width+SpaceW);
     }

 }
 

@end
