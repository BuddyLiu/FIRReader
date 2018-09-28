//
//  Home_NewsView.h
//  GH_ToolBarFrame
//
//  Created by Paul on 2017/6/26.
//  Copyright © 2017年 Paul. All rights reserved.
//

/**
 * 跑马灯视图，内部样式自定义
 **/

#import <UIKit/UIKit.h>
#import "GDTableView.h"
#import "ScrollRichTextView.h"

@protocol PScrollNewsViewDelegate <NSObject>

-(void)clickNewsItem:(id)bulletin index:(NSInteger)index;

@end

@interface PScrollNewsView : UIView

@property (nonatomic, strong) id<PScrollNewsViewDelegate> delegate;

-(instancetype)initWithRichFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor viewsArray:(NSArray *)viewsArray;
-(instancetype)initWithRichFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor viewsArray:(NSArray *)viewsArray icon:(UIImage *)image;

-(void)reloadScrollRighTextViewsArray:(NSArray *)viewArray;

-(void)setIsBlur:(BOOL)blur; // 默认NO，不加毛玻璃效果
-(void)setIsBlur:(BOOL)blur hideAnimationType:(ScrollRichTextViewBlurType)hideAnimationType;

@end
