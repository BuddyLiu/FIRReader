//
//  Localizable_Header.h
//  ComponentizedFramework
//
//  Created by Paul on 2018/8/23.
//  Copyright © 2018年 Paul. All rights reserved.
//

/**
 * 国际化字符串宏定义，此处访问的国际化文件为自定义的文件，因而此文件可以移植到其他项目
 **/

#ifndef Localizable_Header_h
#define Localizable_Header_h

#define Language_key @"Language_Setting_Key"
#define Chinese_Language @"Chinese-Localizable"
#define English_Language @"English-Localizable"

#define ChangeLanguage(__Language__) [[NSUserDefaults standardUserDefaults] setObject:__Language__ forKey:Language_key]
#define ChangeLanguageTo_Chinese ChangeLanguage(Chinese_Language)
#define ChangeLanguageTo_English ChangeLanguage(English_Language)
#define GetLanguageValue__ [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:Language_key]?[[NSUserDefaults standardUserDefaults] objectForKey:Language_key]:Chinese_Language]
#define IsChineseLanguage__ [GetLanguageValue__ isEqual:Chinese_Language]
#define LocalizedString__(__key__, __com__) NSLocalizedStringFromTable(__key__, GetLanguageValue__, __com__)

#endif /* Localizable_Header_h */
