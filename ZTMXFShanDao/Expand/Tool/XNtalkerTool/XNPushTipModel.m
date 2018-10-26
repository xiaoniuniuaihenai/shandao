//
//  XNPushTipModel.m
//  ChatDemo
//
//  Created by NTalker-zhou on 16/12/20.
//  Copyright © 2016年 NTalker. All rights reserved.
//（demo 演示）

#import "XNPushTipModel.h"

@implementation XNPushTipModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    return;
}




/**
 *  从文件中读取对象
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    //注意：在构造方法中需要先初始化父类的方法
    if (self=[super init]) {
        self.settingid=[aDecoder decodeObjectForKey:@"settingid"];
        self.contentString= [aDecoder decodeObjectForKey:@"contentString"];
    }
    return self;
}
//涉及到好几个页面需要使用同样的推送消息数据，因此做归档操作
/**
 *  保存对象到文件中
 *
 *  @param aCoder <#aCoder description#>
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.settingid forKey:@"settingid"];
    [aCoder encodeObject:self.contentString forKey:@"contentString"];
}
@end
