//
//  UIView+Background.h
//  ladygo
//
//  Created by square on 15/1/22.
//  Copyright (c) 2015年 ju.taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Background)

@property (nonatomic, readonly) UIImageView * backgroundImageView;

- (void)setBackgroundImage:(UIImage *)image;

@end
