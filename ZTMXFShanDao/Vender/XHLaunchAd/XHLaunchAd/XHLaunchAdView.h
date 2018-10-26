//
//  XHLaunchAdView.h
//  XHLaunchAdExample
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

#if __has_include(<FLAnimatedImage/FLAnimatedImage.h>)
#import <FLAnimatedImage/FLAnimatedImage.h>
#else
#import "FLAnimatedImage.h"
#endif

#if __has_include(<FLAnimatedImage/FLAnimatedImageView.h>)
#import <FLAnimatedImage/FLAnimatedImageView.h>
#else
#import "FLAnimatedImageView.h"
#endif


#pragma mark - image
@interface XHLaunchAdImageView : FLAnimatedImageView

@property (nonatomic, copy) void(^click)();

@end

#pragma mark - video
@interface XHLaunchAdVideoView : UIView

@property (nonatomic, copy) void(^click)();
@property (strong, nonatomic) MPMoviePlayerController *videoPlayer;
@property(nonatomic,assign)MPMovieScalingMode videoScalingMode;
@property (nonatomic, assign) BOOL videoCycleOnce;

-(void)stopVideoPlayer;

@end

