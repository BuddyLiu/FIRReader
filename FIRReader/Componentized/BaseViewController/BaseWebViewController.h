//
//  BaseWebViewController.h
//  CreditCardHousekeeper
//
//  Created by Paul on 2017/11/20.
//  Copyright © 2017年 QingHu. All rights reserved.
//

/**
 * 基础网页控制器
 * 用于处理一般的网页功能，统一常用功能
 **/

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseWebViewController : UIViewController

-(id)initWithUrl:(NSString *)url;

-(id)initWithUrl:(NSString *)url title:(NSString *)title;

-(id)initWithUrl:(NSString *)url title:(NSString *)title customNavView:(UIView *)customNavView;

-(void)setCanGoBack;

@end
