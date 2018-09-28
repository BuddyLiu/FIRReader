//
//  GeneralHeader.h
//  IntegralWall
//
//  Created by Paul on 2018/7/3.
//  Copyright © 2018 QingHu. All rights reserved.
//

/**
 * 通用列表头视图刷新样式
 **/

#import <MJRefresh/MJRefresh.h>

@interface GeneralHeader : MJRefreshNormalHeader

+(MJRefreshNormalHeader *)generalHeaderTarget:(id)target selector:(SEL)selector;

@end
