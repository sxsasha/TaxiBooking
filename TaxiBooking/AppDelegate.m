//
//  AppDelegate.m
//  TaxiBooking
//
//  Created by Tony Hrabovskyi on 5/9/17.
//  Copyright © 2017 Tony Hrabovskyi. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "LoginVC.h"
@import GoogleMaps;

#define GoogleApi  @"AIzaSyDx4GFZHF_XYKDtqZEv80P8E85CofbLBLU"


@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Initializied methods

- (void)configGoogle {
    [GMSServices provideAPIKey:GoogleApi];
}


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configGoogle];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LoginVC *loginVC = [LoginVC getFromStoryboard];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    
    //check if authorizied
//    if ([[FIRServerManager sharedManager]isAuth]) {
//        initVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
//    } else {
//        initVC = [mainStoryboard instantiateInitialViewController];
//    }
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
