//
//  DLButton.m
//  DaddyLoan
//
//  Created by QingHu on 2017/11/16.
//  Copyright © 2017年 QingHu. All rights reserved.
//

#import "DLButton.h"

@implementation DLButton

//标题在按钮中的显示位置和大小
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
  CGFloat longerSide = self.height < self.width ? self.height : self.width;
  CGFloat labelHeight = longerSide/2.0;
  return CGRectMake(0, labelHeight, contentRect.size.width, labelHeight);
}

//图片在按钮中的显示位置和大小
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
  CGFloat longerSide = self.height < self.width ? self.height : self.width;
  CGFloat imageWidth = longerSide/2.0;
  return CGRectMake((contentRect.size.width - imageWidth)/2.0, 0, imageWidth, imageWidth);
}

@end
