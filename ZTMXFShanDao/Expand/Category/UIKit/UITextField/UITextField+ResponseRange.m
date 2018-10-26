//
//  UITextField+ResponseRange.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/30.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "UITextField+ResponseRange.h"
#import <objc/runtime.h>

static NSString *responseRangeKey  = @"responseRangeKey";

@implementation UITextField (ResponseRange)
/*
 * 添加结构体属性
 * 需要包装成NSValue
 */
- (void)setResponseRange:(UIEdgeInsets)responseRange {
    
    NSValue *value = [NSValue value:&responseRange withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self,&responseRangeKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIEdgeInsets)responseRange {
    
    NSValue *value = objc_getAssociatedObject(self, &responseRangeKey);
    if(value) {
        UIEdgeInsets  responseRange;
        [value getValue:&responseRange];
        return responseRange;
    }else {
        return UIEdgeInsetsZero;
    }
    
}
//检查点击事件点击范围是否能够交给self处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    // 当前控件上的点转换到chatView上
    CGPoint chatP = [self convertPoint:point toView:self];
    
    // 判断下点在不在chatView上
    if (chatP.x>=self.responseRange.left&&chatP.x<self.responseRange.right&&chatP.y>=-self.responseRange.top&&chatP.y<=self.responseRange.bottom) {
        return self;
    }else{
        return [super hitTest:point withEvent:event];
    }
}
//检查是点击事件的点是否在slider范围内
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    //调用父类判断
    BOOL result = [super pointInside:point withEvent:event];
    if (!result) {
        CGPoint chatP = [self convertPoint:point toView:self];
        if (chatP.x>=self.responseRange.left&&chatP.x<self.responseRange.right&&chatP.y>=-self.responseRange.top&&chatP.y<=self.responseRange.bottom) {
            return YES;
        }
    }
    
    //否则返回父类的结果
    return result;
}
@end
