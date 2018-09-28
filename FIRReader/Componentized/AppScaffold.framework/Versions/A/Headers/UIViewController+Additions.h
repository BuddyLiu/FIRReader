//
//  UIViewController+Additions.h
//  Pods
//
//  Created by square on 15/9/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (Additions)

+ (UIViewController *)topViewController;

- (UIViewController *)topVisibleViewController;

@end
