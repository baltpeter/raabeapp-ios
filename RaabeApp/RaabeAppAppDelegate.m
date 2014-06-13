//
//  RaabeAppAppDelegate.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppAppDelegate.h"
#import "RaabeAppVertretungsplanViewController.h"
// TEMP
#import "RaabeAppVertretungsplan.h"

@implementation RaabeAppAppDelegate
{
    NSMutableArray *_vertretungen;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    [tabBar setTintColor:[UIColor redColor]];
    
    UITabBarItem *homeTabBarItem = [tabBar.items objectAtIndex:0];
    UITabBarItem *vertretungsplanTabBarItem = [tabBar.items objectAtIndex:1];
    UITabBarItem *aboutTabBarItem = [tabBar.items objectAtIndex:2];
    
    [homeTabBarItem initWithTitle:@"Home" image:[UIImage imageNamed:@"home"] selectedImage:nil];
    [vertretungsplanTabBarItem initWithTitle:@"Vertretungsplan" image:[UIImage imageNamed:@"vertretungsplan"] selectedImage:nil];
    [aboutTabBarItem initWithTitle:@"Über" image:[UIImage imageNamed:@"about"] selectedImage:nil];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
