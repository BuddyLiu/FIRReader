//
//  AppListModel.h
//  FIRReader
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Liu Bo. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AppListModel_Master_Release : JSONModel

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *build;
@property (nonatomic, copy) NSString *release_type;
@property (nonatomic, copy) NSString *distribution_name;
@property (nonatomic, copy) NSString *supported_platform;
@property (nonatomic, copy) NSString *created_at;

@end

@protocol AppListModel_Items<NSObject>@end
@interface AppListModel_Items :JSONModel

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *shortStr;
@property (nonatomic, copy) NSString *bundle_id;
@property (nonatomic, copy) NSString *genre_id;
@property (nonatomic, copy) NSString *is_opened;
@property (nonatomic, copy) NSString *web_template;
@property (nonatomic, copy) NSString *has_combo;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *icon_url;

@property (nonatomic, strong) AppListModel_Master_Release *master_release;

@end

@interface AppListModel : JSONModel

@property (nonatomic, copy) NSString *apps_count;
@property (nonatomic, copy) NSString *page_size;
@property (nonatomic, strong) NSArray<AppListModel_Items> *items;

@end
