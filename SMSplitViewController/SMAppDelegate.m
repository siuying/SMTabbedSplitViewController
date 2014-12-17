//
//  SMAppDelegate.m
//  SMSplitViewController
//
//  Created by Sergey Marchukov on 15.02.14.
//  Copyright (c) 2014 Sergey Marchukov. All rights reserved.
//

#import "SMAppDelegate.h"
#import "SMMainViewController.h"
#import "SMTabBarItemCell.h"

@implementation SMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[SMTabBarItemCell appearance] setWidth:40.0];
    [[SMTabBarItemCell appearance] setHeight:44.0];
    [[SMTabBarItemCell appearance] setTitleHeight:0];

    SMMainViewController *mainVC = [[SMMainViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mainVC];
    nc.navigationBarHidden = YES;
    
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
