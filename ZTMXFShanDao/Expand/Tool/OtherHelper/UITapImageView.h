//
//  UITapImageView.h
//  zxptUser
//

#import <UIKit/UIKit.h>

@interface UITapImageView : UIImageView

- (void)addTapBlock:(void(^)(id obj))tapAction;

-(void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tapBlock:(void(^)(id obj))tapAction;

@end
