//
//  LGUIKit.h
//  ladygo
//
//  Created by square on 15/1/16.
//  Copyright (c) 2015年 ju.taobao.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASCore.h"
#import "UIView+Additions.h"
#import "UIWindow+Extensions.h"

@interface ASUIKit : NSObject

/**
 无数据异常页面
 */
+ (UIView*)emptyViewWithFrame:(CGRect)frame target:(id)target action:(SEL)action;

/**
 无网络异常页面
 */
+ (UIView*)noNetWorkViewWithFrame:(CGRect)frame target:(id)target action:(SEL)action;

@end

@interface UIView (ASCategory)

@end

/**
 * @return TRUE if the keyboard is visible.
 */
FOUNDATION_EXTERN BOOL ASIsKeyboardVisible();

/**
 * A convenient way to show a UIAlertView with a message.
 */
FOUNDATION_EXTERN void ASUIAlert(NSString* message);
