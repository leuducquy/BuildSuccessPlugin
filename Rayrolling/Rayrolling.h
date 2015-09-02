//
//  Rayrolling.h
//  Rayrolling
//
//  Created by Derek Selander on 5/29/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

#import <AppKit/AppKit.h>

@class Rayrolling;

static Rayrolling *sharedPlugin;

@interface Rayrolling : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;
+ (BOOL)isEnabled;
@property (nonatomic, strong, readonly) NSBundle* bundle;
@end