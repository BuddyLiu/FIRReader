//
//  NSObject+ALExtension.h
//  Pods
//
//  Created by square on 15/9/14.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (ALExtension)

// check to see if super class method are overridden by subclass
- (BOOL)checkOverridesSelector:(SEL)selector;

@end
