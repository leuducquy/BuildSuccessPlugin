//
//  NSObject+Rayrolling_DVTBezelAlertPanel.m
//  Rayrolling
//
//  Created by Derek Selander on 5/29/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

#import "NSObject+Rayrolling_DVTBezelAlertPanel.h"
#import "NSObject+MethodSwizzler.h"
#import <Cocoa/Cocoa.h>
#import "Rayrolling.h"

@interface NSObject ()

- (id)initWithIcon:(id)arg1 message:(id)arg2 parentWindow:(id)arg3 duration:(double)arg4;

@end

@implementation NSObject (Rayrolling_DVTBezelAlertPanel)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSClassFromString(@"DVTBezelAlertPanel") swizzleWithOriginalSelector:@selector(initWithIcon: message: parentWindow: duration:) swizzledSelector:@selector(Rayrolling_initWithIcon: message: parentWindow: duration:) isClassMethod:NO];
    });
}

- (id)Rayrolling_initWithIcon:(id)arg1 message:(id)arg2 parentWindow:(id)arg3 duration:(double)arg4
{
    if ([Rayrolling isEnabled] && arg1) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.raywenderlich.Rayrolling"];
        NSImage *newImage = [bundle imageForResource:@"quyImages.jpg "];
        return [self Rayrolling_initWithIcon:newImage message:arg2 parentWindow:arg3 duration:arg4];
    }
    return [self Rayrolling_initWithIcon:arg1 message:arg2 parentWindow:arg3 duration:arg4];
}

@end