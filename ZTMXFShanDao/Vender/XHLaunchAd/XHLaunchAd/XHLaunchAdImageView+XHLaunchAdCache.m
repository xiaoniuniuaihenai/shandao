//
//  XHLaunchAdImageView+XHLaunchAdCache.m
//  XHLaunchAdExample
//

#import "XHLaunchAdImageView+XHLaunchAdCache.h"
#import "FLAnimatedImage.h"
#import "XHLaunchAdConst.h"

@implementation XHLaunchAdImageView (XHLaunchAdCache)
- (void)xh_setImageWithURL:(nonnull NSURL *)url{
    [self xh_setImageWithURL:url placeholderImage:nil];
}

- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder{
    [self xh_setImageWithURL:url placeholderImage:placeholder options:XHLaunchAdImageDefault];
}

-(void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(XHLaunchAdImageOptions)options{
    [self xh_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)xh_setImageWithURL:(nonnull NSURL *)url completed:(nullable XHExternalCompletionBlock)completedBlock {
    
    [self xh_setImageWithURL:url placeholderImage:nil completed:completedBlock];
}

- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable XHExternalCompletionBlock)completedBlock{
    [self xh_setImageWithURL:url placeholderImage:placeholder options:XHLaunchAdImageDefault completed:completedBlock];
}

-(void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(XHLaunchAdImageOptions)options completed:(nullable XHExternalCompletionBlock)completedBlock{
    [self xh_setImageWithURL:url placeholderImage:placeholder GIFImageCycleOnce:NO options:options completed:completedBlock];
}

- (void)xh_setImageWithURL:(nonnull NSURL *)url placeholderImage:(nullable UIImage *)placeholder GIFImageCycleOnce:(BOOL)GIFImageCycleOnce options:(XHLaunchAdImageOptions)options completed:(nullable XHExternalCompletionBlock)completedBlock{
    if(placeholder) self.image = placeholder;
    if(!url) return;
    XHWeakSelf
    [[XHLaunchAdImageManager sharedManager] loadImageWithURL:url options:options progress:nil completed:^(UIImage * _Nullable image,  NSData *_Nullable imageData, NSError * _Nullable error, NSURL * _Nullable imageURL) {
        if(XHISGIFTypeWithData(imageData)){
            weakSelf.image = nil;
            weakSelf.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
            weakSelf.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
                if(GIFImageCycleOnce) [weakSelf stopAnimating];
            };
        }else{
            weakSelf.image = image;
            weakSelf.animatedImage = nil;
        }
        if(completedBlock) completedBlock(image,imageData,error,imageURL);
    }];
}

@end