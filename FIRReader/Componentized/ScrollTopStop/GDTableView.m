//
//  GDTableView.m
//  GraspDoll
//
//  Created by Paul on 2018/1/19.
//  Copyright © 2018年 QingHu. All rights reserved.
//

#import "GDTableView.h"

@implementation GDTableView

// 这个方法是支持多手势，当滑动子控制器中的scrollView时，MyTableView也能接收滑动事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end
