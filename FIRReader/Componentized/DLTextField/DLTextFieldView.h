//
//  DLTextFieldView.h
//  DaddyLoan
//
//  Created by Sara on 20/10/2017.
//  Copyright © 2017 QingHu. All rights reserved.
//

/**
 * 用于创建多种样式的文本输入框样式
 * 共有三种
 * 默认样式-与一般的textfield一样
 * 密码输入框-右侧会有操作按钮控制密码是否显示
 * 验证码样式-右侧会有获取验证码的按钮
 **/

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, DLTextFieldViewType) {
  DLTextFieldViewDefaultType,
  DLTextFieldViewPasswordType,
  DLTextFieldViewVerificationType,
};

@protocol DLTextFieldViewDelegate <NSObject>

@optional
-(void)clickVertifyBtn:(UIButton *)sender;
-(void)clickEyesBtn:(UIButton *)sender;
-(void)textFieldDidChange:(UITextField *)textField;

@end

@interface DLTextFieldView : UIView

@property (nonatomic, strong) id<DLTextFieldViewDelegate> delegate;
@property (nonatomic, strong) UITextField *textField;

- (instancetype)initWithFrame:(CGRect)frame withTextViewType:(DLTextFieldViewType)textFieldViewType withPlaceholder:(NSString *)placeholderStr tag:(NSInteger)tag;

@end
