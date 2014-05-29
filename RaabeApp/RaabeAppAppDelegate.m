//
//  RaabeAppAppDelegate.m
//  RaabeApp
//
//  Created by Benjamin Altpeter on 03.05.14.
//  Copyright (c) 2014 Benjamin Altpeter. All rights reserved.
//

#import "RaabeAppAppDelegate.h"
#import "RaabeAppVertretung.h"
#import "RaabeAppVertretungsplanViewController.h"

@implementation RaabeAppAppDelegate
{
    NSMutableArray *_vertretungen;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // BEGIN hardcoded demo content
    _vertretungen = [NSMutableArray arrayWithCapacity:20];
    
    RaabeAppVertretung *vertretung = [[RaabeAppVertretung alloc] init];
    vertretung.datum = @"21. Dezember 2012";
    vertretung.stunde = @"1-2";
    vertretung.absenterLehrer = @"Ah";
    vertretung.vtrLehrer = @"Ah";
    vertretung.fach = @"De";
    vertretung.vtrFach = @"De";
    vertretung.raum = @"153a";
    vertretung.vtrRaum = @"---";
    vertretung.klasse = @"10G3";
    vertretung.vtrText = @"";
    vertretung.vtrArt = @"Entfall";
    [_vertretungen addObject:vertretung];
    
    vertretung = [[RaabeAppVertretung alloc] init];
    vertretung.datum = @"21. Dezember 2012";
    vertretung.stunde = @"3";
    vertretung.absenterLehrer = @"Hk";
    vertretung.vtrLehrer = @"Pz";
    vertretung.fach = @"Mu";
    vertretung.vtrFach = @"Mu";
    vertretung.raum = @"129b";
    vertretung.vtrRaum = @"131";
    vertretung.klasse = @"10G3";
    vertretung.vtrText = @"";
    vertretung.vtrArt = @"Vertretung";
    [_vertretungen addObject:vertretung];
    
    vertretung = [[RaabeAppVertretung alloc] init];
    vertretung.datum = @"21. Dezember 2012";
    vertretung.stunde = @"1-2";
    vertretung.absenterLehrer = @"Sn";
    vertretung.vtrLehrer = @"Sn";
    vertretung.fach = @"Ma";
    vertretung.vtrFach = @"Ma";
    vertretung.raum = @"159";
    vertretung.vtrRaum = @"---";
    vertretung.klasse = @"10G4";
    vertretung.vtrText = @"Eigenständiges Arbeiten";
    vertretung.vtrArt = @"Entfall";
    [_vertretungen addObject:vertretung];
    
    vertretung = [[RaabeAppVertretung alloc] init];
    vertretung.datum = @"21. Dezember 2012";
    vertretung.stunde = @"3";
    vertretung.absenterLehrer = @"Sc";
    vertretung.vtrLehrer = @"Ah";
    vertretung.fach = @"Mu";
    vertretung.vtrFach = @"Mu";
    vertretung.raum = @"129b";
    vertretung.vtrRaum = @"129b";
    vertretung.klasse = @"10G4";
    vertretung.vtrText = @"";
    vertretung.vtrArt = @"Vertretung";
    [_vertretungen addObject:vertretung];
    
    vertretung = [[RaabeAppVertretung alloc] init];
    vertretung.datum = @"21. Dezember 2012";
    vertretung.stunde = @"5-6";
    vertretung.absenterLehrer = @"Sg";
    vertretung.vtrLehrer = @"Sg";
    vertretung.fach = @"De";
    vertretung.vtrFach = @"De";
    vertretung.raum = @"159";
    vertretung.vtrRaum = @"141";
    vertretung.klasse = @"10G4";
    vertretung.vtrText = @"";
    vertretung.vtrArt = @"Raum-Vertretung";
    [_vertretungen addObject:vertretung];
    
    vertretung = [[RaabeAppVertretung alloc] init];
    vertretung.datum = @"21. Dezember 2012";
    vertretung.stunde = @"8-9";
    vertretung.absenterLehrer = @"Sa";
    vertretung.vtrLehrer = @"Wn";
    vertretung.fach = @"Inf";
    vertretung.vtrFach = @"Inf";
    vertretung.raum = @"129a";
    vertretung.vtrRaum = @"129a";
    vertretung.klasse = @"11N1";
    vertretung.vtrText = @"";
    vertretung.vtrArt = @"Vertretung";
    [_vertretungen addObject:vertretung];
    
    // END hardcoded demo content
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = [tabBarController viewControllers][1];
    RaabeAppVertretungsplanViewController *vertretungsplanViewController = [navigationController viewControllers][0];
    vertretungsplanViewController.vertretungen = _vertretungen;
   
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
