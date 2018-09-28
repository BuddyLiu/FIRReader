//
//  ASGlobalCoreLocale.h
//
//  Created by apple on 13-12-9.
//  Copyright (c) 2013年 square. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Gets the current system locale chosen by the user.
 *
 * This is necessary because [NSLocale currentLocale] always returns en_US.
 */
NSLocale* ASCurrentLocale();

/**
 * Get the current system default bundle.
 */
NSBundle* ASDefaultBundle();

/**
 * @return A localized string from the Three20 bundle.
 */
NSString* ASLocalizedString(NSString* key, NSString* comment);

/**
 * @return A localized description for NSURLErrorDomain errors.
 *
 * Error codes handled:
 * - NSURLErrorTimedOut
 * - NSURLErrorNotConnectedToInternet
 * - All other NSURLErrorDomain errors fall through to "Connection Error".
 */
NSString* ASDescriptionForError(NSError* error);

/**
 * @return The given number formatted as XX,XXX,XXX.XX
 *
 */
NSString* ASFormatInteger(NSInteger num);
