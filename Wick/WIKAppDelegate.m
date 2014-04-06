//
//  WIKAppDelegate.m
//  Wick
//
//  Created by Bryan Irace on 4/6/14.
//  Copyright (c) 2014 Bryan Irace. All rights reserved.
//

#import "WIKAppDelegate.h"
#import "WIKViewController.h"

@implementation WIKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [WIKViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
