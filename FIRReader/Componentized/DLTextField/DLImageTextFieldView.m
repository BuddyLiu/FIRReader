//
//  DLImageTextFieldView.m
//  DaddyLoan
//
//  Created by 刘波 on 23/02/2018.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "DLImageTextFieldView.h"

@interface DLImageTextFieldView()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UIButton *verificationButton;
@property (nonatomic, assign) DLImageTextFieldViewType textFieldViewType;

@end

static CGFloat textSpace = 10;


@implementation DLImageTextFieldView

- (instancetype)initWithFrame:(CGRect)frame withTextViewType:(DLImageTextFieldViewType)textFieldViewType withPlaceholder:(NSString *)placeholderStr tag:(NSInteger)tag image:(UIImage *)image {
  self = [super initWithFrame:frame];
  if (self)
  {
      self.textFieldViewType = textFieldViewType;
      self.backgroundColor = [UIColor whiteColor];
      
      self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(textSpace, (frame.size.height - 30)/2.0, 30, 30)];
      self.leftImageView.image = image;
      
      self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.leftImageView.right + textSpace, 0, self.width - textSpace*2.0 - self.leftImageView.right, self.height)];
      self.textField.placeholder = placeholderStr;
      self.textField.delegate = self;
      self.textField.tag = tag;
      self.textField.font = [UIFont systemFontOfSize:14];
      [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
      
      self.borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.textField.right, self.textField.height)];
      self.borderView.clipsToBounds = NO;
      self.borderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
      self.borderView.layer.cornerRadius = 5;
      self.borderView.layer.shadowOpacity = 0.5;
      self.borderView.layer.shadowColor = [UIColor blackColor].CGColor;
      self.borderView.layer.shadowOffset = CGSizeMake(2, 2);
      self.borderView.layer.shadowRadius = 2;
      
      switch (textFieldViewType)
      {
        case DLImageTextFieldViewDefaultType:
            [self createDefaultTextFieldView];
            break;
        case DLImageTextFieldViewPasswordType:
            [self createPasswordTextFieldView];
            break;
        case DLImageTextFieldViewVerificationType:
            [self createVerificationTextFieldView];
            break;
        default:
            [self createDefaultTextFieldView];
            break;
      }
  }
  return self;
}

-(void)createDefaultTextFieldView {
  [self removeAllSubviews];
  [self addSubview:self.borderView];
  [self addSubview:self.leftImageView];
  [self addSubview:self.textField];
  
  self.textField.frame = ({
      CGRect frame = self.textField.frame;
      frame.size.width = self.width - textSpace*2.0 - self.leftImageView.right;
      frame;
  });
  
  self.borderView.frame = ({
      CGRect frame = self.borderView.frame;
      frame.size.width = self.textField.right;
      frame;
  });

}

-(void)createPasswordTextFieldView {
  [self removeAllSubviews];
  
  [self addSubview:self.borderView];
  [self addSubview:self.leftImageView];
  
  self.textField.frame = ({
      CGRect frame = self.textField.frame;
      frame.size.width = self.width - textSpace*2.0 - self.leftImageView.width;
      frame;
  });
  
  self.borderView.frame = ({
      CGRect frame = self.borderView.frame;
      frame.size.width = self.textField.right;
      frame;
  });
  
  self.textField.secureTextEntry = YES;
  [self addSubview:self.textField];
}

-(void)createVerificationTextFieldView {
  [self removeAllSubviews];
  
  [self addSubview:self.borderView];
  [self addSubview:self.leftImageView];
  
  self.textField.frame = ({
      CGRect frame = self.textField.frame;
      frame.size.width = self.width - textSpace*2.0 - 100 - self.leftImageView.right;
      frame;
  });
  
  self.borderView.frame = ({
      CGRect frame = self.borderView.frame;
      frame.size.width = self.textField.right;
      frame;
  });
  
  [self addSubview:self.textField];
  
  self.verificationButton = [[UIButton alloc] initWithFrame:CGRectMake(self.textField.right + 10, 0, 90, self.height)];
  [self.verificationButton setBackgroundColor:MainColor];
  self.verificationButton.clipsToBounds = YES;
  self.verificationButton.layer.cornerRadius = 5;
  [self.verificationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [self.verificationButton addTarget:self action:@selector(verificationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
  self.verificationButton.titleLabel.font = [UIFont systemFontOfSize:13];
  [self addSubview:self.verificationButton];
}

-(void)verificationButtonClick:(UIButton *)sender {
  if(self.delegate && [self.delegate respondsToSelector:@selector(clickVertifyBtn:)])
  {
      [self.delegate clickVertifyBtn:sender];
  }
}

-(void)textFieldDidChange:(UITextField *)textField {
  if(self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidChange:)])
  {
      [self.delegate textFieldDidChange:textField];
  }
}

@end
