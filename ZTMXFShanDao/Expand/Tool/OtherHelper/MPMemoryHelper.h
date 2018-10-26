//
//  MPMemoryHelper.h
//  MobileProject

#import <Foundation/Foundation.h>

@interface MPMemoryHelper : NSObject

// 获取当前设备可用内存(单位：MB）
- (double)availableMemory;

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory;

@end
