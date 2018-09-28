//
//  ScrollRichTextView.h
//  DaddyLoan
//
//  Created by Paul on 2018/6/1.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 自定义跑马灯内部样式视图，可选择添加毛玻璃效果
 **/

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    //收起
    ScrollRichTextViewBlurTypeCollapseDefault,
    ScrollRichTextViewBlurTypeCollapseToTop,
    ScrollRichTextViewBlurTypeCollapseToLeft,
    ScrollRichTextViewBlurTypeCollapseToRight,
    ScrollRichTextViewBlurTypeCollapseToBottom,
    ScrollRichTextViewBlurTypeCollapseToCenter,
    
    //渐变
    ScrollRichTextViewBlurTypeGradient,
    
} ScrollRichTextViewBlurType;


@protocol ScrollRichTextViewDelegate <NSObject>

-(void)clickNewsItem:(UIView *)view index:(NSInteger)index;

@end
@interface ScrollRichTextView : UIView

@property (nonatomic, strong) id<ScrollRichTextViewDelegate> delegate;

//初始化视图
-(instancetype) initWithFrame:(CGRect)frame views:(NSArray *)ViewsArray;

-(void)reloadScrolltableViewsArray:(NSArray *)viewsArray;

-(void)setIsBlur:(BOOL)blur; // 默认NO，不加毛玻璃效果
-(void)setIsBlur:(BOOL)blur hideAnimationType:(ScrollRichTextViewBlurType)hideAnimationType;

@end
