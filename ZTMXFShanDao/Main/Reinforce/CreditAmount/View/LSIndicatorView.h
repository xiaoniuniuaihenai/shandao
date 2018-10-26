//
//  LSIndicatorView.h
//  tryTest
//
//  Created by 朱吉达 on 2017/11/7.
//  Copyright © 2017年 try. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LSIndicatorView : UIView

@property (nonatomic, copy) NSString *amountDesc;
@property (nonatomic, copy) NSString *amountStr;

-(instancetype)initWithPgColor:(UIColor*)PgColor strokeColor:(UIColor*)strokeColor andLineWidth:(CGFloat)lineWidth;
-(void)runSpeedProgress;
@end
