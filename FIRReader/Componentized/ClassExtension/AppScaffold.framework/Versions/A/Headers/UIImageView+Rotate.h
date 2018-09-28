//
//  UIImageView+Rotate.h
//  ladygo
//
//  Created by square on 15/1/27.
//  Copyright (c) 2015年 ju.taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (Rotate)
- (void)rotate360WithDuration:(CGFloat)duration repeatCount:(float)repeatCount;
- (void)pauseAnimations;
- (void)resumeAnimations;
- (void)stopAllAnimations;
@end