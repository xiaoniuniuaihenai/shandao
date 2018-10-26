//
//  UIButton+Addition.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/2/1.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "UIButton+Addition.h"
#import <UIButton+WebCache.h>

@implementation UIButton (Addition)
-(void)sd_setImageFadeEffectWithURLstr:(NSString*)imgUrl placeholderImage:(NSString*)imgName{
    NSURL * url = [NSURL URLWithString:imgUrl];
    [self sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:imgName]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image&&cacheType!=SDImageCacheTypeMemory) {
            self.alpha=0;
            [UIView animateWithDuration:1.0 animations:^{
                self.alpha= 1;
            }];
        }else{
            self.alpha = 1;
        }
    }];
}
@end
