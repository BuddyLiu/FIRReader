//
//  GeneralFooter.h
//  IntegralWall
//
//  Created by Paul on 2018/7/3.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 通用列表脚视图加载样式
 **/

#import <MJRefresh/MJRefresh.h>

@interface GeneralFooter : MJRefreshBackNormalFooter

+(MJRefreshBackNormalFooter *)generalFooterTarget:(id)target selector:(SEL)selector;

@end
