//
//  OpenShowView.h
//  DaddyLoan
//
//  Created by Paul on 2018/6/1.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 自定义弹出框承载视图，使用单例模式创建，全局使用，回调处理事件
 **/

#import <UIKit/UIKit.h>

@protocol OpenShowViewDelegate <NSObject>

@optional

-(void)didHideOpenShowView;

@end

@interface OpenShowView : UIView

@property (nonatomic, strong) id <OpenShowViewDelegate>delegate;
@property (nonatomic, assign) BOOL isShowCloseBtn;
@property (nonatomic, assign) BOOL isAnima;

+(OpenShowView *)shareInstance;

- (instancetype)initOpenShowView;

-(void)showDeledate:(id <OpenShowViewDelegate>)delegate showView:(UIView *)showView;

-(void)hide;

@end
