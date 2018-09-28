//
//  DLLRButton.m
//  DaddyLoan
//
//  Created by 刘波 on 24/02/2018.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "DLLRButton.h"

@implementation DLLRButton

//图片在按钮中的显示位置和大小
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
  return CGRectMake(self.height/4.0, self.height/4.0, self.height/2.0, self.height/2.0);
}

//标题在按钮中的显示位置和大小
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
  return CGRectMake(self.height, 0, self.width - self.height, self.height);
}

@end
