//
//  DLImageTextFieldView.h
//  DaddyLoan
//
//  Created by 刘波 on 23/02/2018.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 用于创建多种样式的文本输入框样式，左侧可添加图标
 * 共有三种
 * 默认样式-与一般的textfield一样
 * 密码输入框-右侧会有操作按钮控制密码是否显示
 * 验证码样式-右侧会有获取验证码的按钮
 **/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DLImageTextFieldViewType) {
  DLImageTextFieldViewDefaultType,
  DLImageTextFieldViewPasswordType,
  DLImageTextFieldViewVerificationType,
};

@protocol DLImageTextFieldViewDelegate <NSObject>

@optional
-(void)clickVertifyBtn:(UIButton *)sender;
-(void)textFieldDidChange:(UITextField *)textField;

@end

@interface DLImageTextFieldView : UIView

@property (nonatomic, strong) id<DLImageTextFieldViewDelegate> delegate;
@property (nonatomic, strong) UITextField *textField;

- (instancetype)initWithFrame:(CGRect)frame withTextViewType:(DLImageTextFieldViewType)textFieldViewType withPlaceholder:(NSString *)placeholderStr tag:(NSInteger)tag image:(UIImage *)image;

@end
