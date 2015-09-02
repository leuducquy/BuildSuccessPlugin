//
//  NSObject+Rayrolling_IDEDocWebViewContentViewController.m
//  Rayrolling
//
//  Created by Derek Selander on 5/1/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

#import "NSObject+Rayrolling_IDEDocWebViewContentViewController.h"
#import "NSObject+MethodSwizzler.h"
#import "Rayrolling.h"
#import <WebKit/WebKit.h>

@implementation NSObject (Rayrolling_IDEDocWebViewContentViewController)

+ (void)load // 5
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ // 6
        [NSClassFromString(@"IDEDocWebViewContentViewController") swizzleWithOriginalSelector:@selector(webView:decidePolicyForNavigationAction:request:frame:decisionListener:) swizzledSelector:@selector(Rayrolling_webView:decidePolicyForNavigationAction:request:frame:decisionListener:) isClassMethod:NO]; // 7
    });
}

- (void)Rayrolling_webView:(WebView *)webView
decidePolicyForNavigationAction:(NSDictionary *)actionInformation
                   request:(NSURLRequest *)request
                     frame:(WebFrame *)frame
          decisionListener:(id<WebPolicyDecisionListener>)listener
{
    if ([Rayrolling isEnabled]) {
        [listener use];
    } else {
        [self Rayrolling_webView:webView decidePolicyForNavigationAction:actionInformation request:request frame:frame decisionListener:listener];
    }
}

@end