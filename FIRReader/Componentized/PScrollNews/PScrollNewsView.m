//
//  Home_NewsView.m
//  GH_ToolBarFrame
//
//  Created by Paul on 2017/6/26.
//  Copyright © 2017年 Paul. All rights reserved.
//

#import "PScrollNewsView.h"

@interface PScrollNewsView()<ScrollRichTextViewDelegate>

@property(strong,nonatomic) ScrollRichTextView *newsScrollRichTextView;
@property (nonatomic, strong) NSMutableArray *viewsArray;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation PScrollNewsView

-(instancetype)initWithRichFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor viewsArray:(NSArray *)viewsArray
{
  self = [super initWithFrame:frame];
  if (self)
  {
      self.backgroundColor = backgroundColor;
      self.viewsArray = [viewsArray mutableCopy];
      [self initRichContentView];
  }
  return self;
}

-(void)initRichContentView
{
  self.newsScrollRichTextView = [[ScrollRichTextView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) views:[self.viewsArray copy]];
  self.newsScrollRichTextView.delegate = self;
  [self addSubview:self.newsScrollRichTextView];
}

-(instancetype)initWithRichFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor viewsArray:(NSArray *)viewsArray icon:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = backgroundColor;
        self.viewsArray = [viewsArray mutableCopy];
        [self initRichContentViewWithImage:image];
    }
    return self;
}

-(void)initRichContentViewWithImage:(UIImage *)image
{
    CGFloat newsImageHeight = 20;
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, (self.height - newsImageHeight)/2.0, newsImageHeight, newsImageHeight)];
    self.iconImageView.image = [UIImage imageNamed:@"qh_ic_tips"];
    [self addSubview:self.iconImageView];
    
    self.newsScrollRichTextView = [[ScrollRichTextView alloc] initWithFrame:CGRectMake(self.iconImageView.right + self.iconImageView.left, 0, ScreenWidth - (self.iconImageView.left*3.0 + self.iconImageView.width), self.height) views:[self.viewsArray copy]];
    self.newsScrollRichTextView.delegate = self;
    [self addSubview:self.newsScrollRichTextView];
}

-(void)clickNewsItem:(id)bulletin index:(NSInteger)index
{
  if(self.delegate && [self.delegate respondsToSelector:@selector(clickNewsItem:index:)])
  {
      [self.delegate clickNewsItem:bulletin index:index];
  }
}

-(void)reloadScrollRighTextViewsArray:(NSArray *)viewArray
{
  [self.newsScrollRichTextView reloadScrolltableViewsArray:viewArray];
}

-(void)setIsBlur:(BOOL)blur
{
    [self.newsScrollRichTextView setIsBlur:blur];
}

-(void)setIsBlur:(BOOL)blur hideAnimationType:(ScrollRichTextViewBlurType)hideAnimationType
{
    [self.newsScrollRichTextView setIsBlur:blur hideAnimationType:hideAnimationType];
}

@end
