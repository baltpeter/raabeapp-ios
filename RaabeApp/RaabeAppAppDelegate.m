//
//  RaabeAppAppDelegate.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppAppDelegate.h"
#import "RaabeAppVertretungsplanViewController.h"

@implementation RaabeAppAppDelegate
{
    NSMutableArray *_vertretungen;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Configure tab bar
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    [tabBar setTintColor:[UIColor redColor]];
    
    UITabBarItem *homeTabBarItem = [tabBar.items objectAtIndex:0];
    UITabBarItem *vertretungsplanTabBarItem = [tabBar.items objectAtIndex:1];
    UITabBarItem *aboutTabBarItem = [tabBar.items objectAtIndex:2];
    
    [homeTabBarItem initWithTitle:NSLocalizedString(@"Home", nil) image:[UIImage imageNamed:@"home"] selectedImage:nil];
    [vertretungsplanTabBarItem initWithTitle:NSLocalizedString(@"Vertretungsplan", nil) image:[UIImage imageNamed:@"vertretungsplan"] selectedImage:nil];
    [aboutTabBarItem initWithTitle:NSLocalizedString(@"About", nil) image:[UIImage imageNamed:@"about"] selectedImage:nil];
    
    // Access notification API to check for (and optionally display) notifications
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_read_notifications"] == nil) {
        NSMutableArray *read_notifications = [[NSMutableArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setValue:read_notifications forKey:@"raabeapp_read_notifications"];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSString *urlString = [NSString stringWithFormat:@"%s%@", "http://oneloveforlife.de/rs/notification.php?client=ios&version=", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        NSURL *url = [NSURL URLWithString:urlString];
        NSError *downloadError;
        NSData *notificationData = [[NSData alloc] initWithContentsOfURL:url options:NSDataReadingUncached error:&downloadError];
        NSError *jsonParsingError = nil;
        NSDictionary *notification = [NSJSONSerialization JSONObjectWithData:notificationData options:0 error:&jsonParsingError];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(notification != nil) {
                NSMutableArray *read_notifications = [[[NSUserDefaults standardUserDefaults] valueForKey:@"raabeapp_read_notifications"] mutableCopy];
                NSNumber *notification_id = (NSNumber *)[notification valueForKey:@"id"];

                if([[notification valueForKey:@"permanent"] boolValue] == YES || ![read_notifications containsObject:notification_id]) {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:[notification valueForKey:@"title"]
                                          message:[notification valueForKey:@"message"]
                                          delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil, nil];
                    [alert show];
                    
                    if([[notification valueForKey:@"permanent"] boolValue] == NO) {
                        [read_notifications addObject:notification_id];
                        [[NSUserDefaults standardUserDefaults] setObject:read_notifications forKey:@"raabeapp_read_notifications"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }
            }
        });
    });
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
