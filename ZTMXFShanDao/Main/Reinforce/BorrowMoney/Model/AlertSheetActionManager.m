//
//  AlertSheetActionManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "AlertSheetActionManager.h"

@implementation AlertSheetActionManager
+(void)sheetActionTitle:(NSString*)title message:(NSString *)msg arrTitleAction:(NSArray*)arrTitle superVc:(UIViewController*)superVc blockClick:(BlockActionClick)blockClick{
    UIAlertController * alertVc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i =0; i<arrTitle.count; i++) {
        NSString * actionTitle = arrTitle[i];
        UIAlertAction * actionAlert = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger index = [arrTitle indexOfObject:action.title];
            blockClick(index);
        }];
        [alertVc addAction:actionAlert];
    }
    UIAlertAction * actionThree = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:actionThree];
    //修改title
    if (title.length>0) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 2)];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:COLOR_GRAY_STR1] range:NSMakeRange(0, 2)];
        [alertVc setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    [superVc presentViewController:alertVc animated:YES completion:nil];
}
@end
