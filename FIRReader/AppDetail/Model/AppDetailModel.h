//
//  AppDetailModel.h
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AppDetailModel : JSONModel

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *shortStr;
@property (nonatomic, copy) NSString *is_opened;
@property (nonatomic, copy) NSString *bundle_id;
@property (nonatomic, copy) NSString *is_show_plaza;
@property (nonatomic, copy) NSString *passwd;
@property (nonatomic, copy) NSString *max_release_count;
@property (nonatomic, copy) NSString *is_store_auto_sync;
@property (nonatomic, copy) NSString *store_link_visible;
@property (nonatomic, copy) NSString *genre_id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *has_combo;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *is_owner;

@end
