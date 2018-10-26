//
//  XHLaunchImageView.h
//  XHLaunchAdExample
//

#import <UIKit/UIKit.h>

/** 启动图来源 */
typedef NS_ENUM(NSInteger,LaunchImagesSource){
    LaunchImagesSourceLaunchImage = 1,//LaunchAdImage (default)
    LaunchImagesSourceLaunchScreen = 2,//LaunchScreen.storyboard
};

@interface XHLaunchImageView : UIImageView

- (instancetype)initWithLaunchImagesSource:(LaunchImagesSource)source;

@end
