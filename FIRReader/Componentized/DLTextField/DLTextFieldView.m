//
//  DLTextFieldView.m
//  DaddyLoan
//
//  Created by Sara on 20/10/2017.
//  Copyright © 2017 QingHu. All rights reserved.
//

#import "DLTextFieldView.h"

@interface DLTextFieldView()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *eyesButton;
@property (nonatomic, strong) UIButton *verificationButton;
@property (nonatomic, assign) DLTextFieldViewType textFieldViewType;

@end

static CGFloat textSpace = 10;

@implementation DLTextFieldView

- (instancetype)initWithFrame:(CGRect)frame withTextViewType:(DLTextFieldViewType)textFieldViewType withPlaceholder:(NSString *)placeholderStr tag:(NSInteger)tag {
  self = [super initWithFrame:frame];
  if (self)
  {
      self.textFieldViewType = textFieldViewType;
      self.clipsToBounds = YES;
      self.layer.cornerRadius = textSpace;
      self.backgroundColor = [UIColor whiteColor];
      
      self.textField = [[UITextField alloc] initWithFrame:CGRectMake(textSpace, 0, self.width - textSpace*2.0, self.height)];
      self.textField.placeholder = placeholderStr;
      self.textField.delegate = self;
      self.textField.tag = tag;
      self.textField.font = [UIFont systemFontOfSize:14];
      [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
      
      switch (textFieldViewType)
      {
        case DLTextFieldViewDefaultType:
            [self createDefaultTextFieldView];
            break;
        case DLTextFieldViewPasswordType:
            [self createPasswordTextFieldView];
            break;
        case DLTextFieldViewVerificationType:
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
  [self addSubview:self.textField];
}

-(void)createPasswordTextFieldView {
  [self removeAllSubviews];
  self.textField.frame = ({
      CGRect frame = self.textField.frame;
      frame.size.width = self.width - textSpace*2.0 - 20;
      frame;
  });
  self.textField.secureTextEntry = YES;
  [self addSubview:self.textField];
  
  self.eyesButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - textSpace - 20, (self.height - 10)/2.0, 20, 10)];
  [self.eyesButton setImage:[UIImage imageNamed:@"closeEye"] forState:UIControlStateNormal];
  self.eyesButton.tag = 25300;
  [self.eyesButton addTarget:self action:@selector(openOrCloseEyeClick:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.eyesButton];
}

-(void)createVerificationTextFieldView {
  [self removeAllSubviews];
  self.textField.frame = ({
      CGRect frame = self.textField.frame;
      frame.size.width = self.width - textSpace*2.0 - 80;
      frame;
  });
  [self addSubview:self.textField];

  self.verificationButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - textSpace*2.0 - 70, 0, 70, self.height)];
  [self.verificationButton setTitle:@"点此获取" forState:UIControlStateNormal];
  [self.verificationButton setTitleColor:MainColor forState:UIControlStateNormal];
  [self.verificationButton addTarget:self action:@selector(verificationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
  [self.verificationButton setFont:[UIFont systemFontOfSize:13]];
  [self addSubview:self.verificationButton];
  
  UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.verificationButton.left-10, self.height/4.0, 1.5, self.height/2.0)];
  lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
  [self addSubview:lineLabel];
}

-(void)openOrCloseEyeClick:(UIButton *)sender {
  if(self.eyesButton.tag == 25300)
  {
      [self.eyesButton setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
      self.textField.secureTextEntry = NO;
      self.eyesButton.tag = 25301;
  }
  else
  {
      [self.eyesButton setImage:[UIImage imageNamed:@"closeEye"] forState:UIControlStateNormal];
      self.textField.secureTextEntry = YES;
      self.eyesButton.tag = 25300;
  }
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
