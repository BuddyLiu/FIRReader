//
//  UIImage+AutoStretching.h
//  JU
//
//  Created by zeha fu on 12-5-9.
//  Copyright (c) 2012年 ju.taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (AutoStretching) 

- (UIImage*) autoStrethingImage;

// 压缩图片到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
