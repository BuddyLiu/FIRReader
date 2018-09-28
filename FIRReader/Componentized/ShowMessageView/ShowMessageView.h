//
//  ShowMessageView.h
//  IntegralWall
//
//  Created by Paul on 2018/8/2.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 自定义的对话框，仅支持查看消息，不能添加新的操作
 **/

#import <UIKit/UIKit.h>

typedef void(^ShowMessageViewBlock)(void);

@interface ShowMessageView : UIView

@property (nonatomic, strong) ShowMessageViewBlock delegate;

- (instancetype)initShowMessageViewWithMessage:(NSString *)message;
- (instancetype)initShowMessageViewWithMessage:(NSString *)message delegate:(ShowMessageViewBlock)delegate;
- (instancetype)initShowMessageViewWithMessage:(NSString *)message titleStr:(NSString *)titleStr;
- (instancetype)initShowMessageViewWithMessage:(NSString *)message titleStr:(NSString *)titleStr delegate:(ShowMessageViewBlock)delegate;

-(void)show;

@end
