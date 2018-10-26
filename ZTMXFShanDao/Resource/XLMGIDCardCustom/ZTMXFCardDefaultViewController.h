//
//  ZTMXFCardDefaultViewController.h
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/3/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <MGIDCard/MGIDCard.h>
@interface ZTMXFCardDefaultViewController : MGIDCardViewController
/**
 *  检测成功的block回调
 */
@property (nonatomic, copy) VoidBlock_result finishBlock;

/**
 *  检测失败的block回调
 */
@property (nonatomic, copy) VoidBlock_error errorBlcok;

@end
