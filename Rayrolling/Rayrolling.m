//
//  Rayrolling.m
//  Rayrolling
//
//  Created by Derek Selander on 5/29/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

#import "Rayrolling.h"

@interface Rayrolling()
@property (nonatomic, strong) NSMutableSet *notificationSet;
@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation Rayrolling

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        self.notificationSet = [NSMutableSet new];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
    if (menuItem) {
        [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
        NSString *title = [Rayrolling isEnabled] ? @"Disable Rayrolling" : @"Enable Rayrolling";
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:title action:@selector(doMenuAction:) keyEquivalent:@""];
        [actionMenuItem setTarget:self];
        [[menuItem submenu] addItem:actionMenuItem];
    }
}

- (void)handleNotification:(NSNotification *)notification
{
    if (![self.notificationSet containsObject:notification.name]) {
        NSLog(@"%@, %@", notification.name, [notification.object class]);
        [self.notificationSet addObject:notification.name];
    }
}

- (void)doMenuAction:(NSMenuItem *)menuItem
{
    [Rayrolling setIsEnabled:![Rayrolling isEnabled]];
    menuItem.title = [Rayrolling isEnabled] ? @"Disable Quy's Plugin" : @"Enable Quy's Plugin";
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//*****************************************************************************/
#pragma mark - Toggling Rayrolling
//*****************************************************************************/

+ (BOOL)isEnabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"com.raywenderlich.Rayrolling.shouldbeEnable"];
}

+ (void)setIsEnabled:(BOOL)shouldBeEnabled
{
    [[NSUserDefaults standardUserDefaults] setBool:shouldBeEnabled forKey:@"com.raywenderlich.Rayrolling.shouldbeEnable"];
}

@end
