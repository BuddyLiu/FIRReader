//
//  GeneralHeader.m
//  IntegralWall
//
//  Created by Paul on 2018/7/3.
//  Copyright © 2018 QingHu. All rights reserved.
//

#import "GeneralHeader.h"

@implementation GeneralHeader

+(MJRefreshNormalHeader *)generalHeaderTarget:(id)target selector:(SEL)selector
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:selector];
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    return header;
}

@end
