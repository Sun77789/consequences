//
//  AppDelegate.m
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <Facebook.h>
#import "LoginViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"LbaUp2gNy8CR6J1TnJXRion89lou595s1yIxyNg8"
                  clientKey:@"ReHPYz8EDx0Cbqe6pwSyINB8RHxa2e3NNCDm2Jpz"];
    [PFFacebookUtils initializeFacebook];
    
    //UIColor *navColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    //UIColor *navColor = [UIColor colorWithRed:0.0/255.0 green:130.0/255.0 blue:0.0/255.0 alpha:1.0];
    //[[UINavigationBar appearance] setBarTintColor:navColor];
    //NSShadow *shadow = [[NSShadow alloc] init];
    //shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    //shadow.shadowOffset = CGSizeMake(0, 1);
    //UIColor *textColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
    //UIColor *textColor = [UIColor whiteColor];
    //[[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           //textColor, NSForegroundColorAttributeName,
                                                           //shadow, NSShadowAttributeName,
                                                           //[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self chooseFirstViewControllerBasedOnLogIn];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // Stop updating locations while in the background.
    [self chooseFirstViewControllerBasedOnLogIn];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];

    [self chooseFirstViewControllerBasedOnLogIn];
}

// ****************************************************************************
// App switching methods to support Facebook Single Sign-On.
// ****************************************************************************
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [[PFFacebookUtils session] close];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self chooseFirstViewControllerBasedOnLogIn];
}

- (void) chooseFirstViewControllerBasedOnLogIn
{
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
    {
        [[PFUser currentUser] setObject:[FBSession activeSession].accessTokenData.accessToken
                                 forKey:@"accessToken"];
        [[PFUser currentUser] saveInBackground];
        
        [self.window.rootViewController performSegueWithIdentifier:@"firstViewSegue" sender:self];
    } else {
        [self.window.rootViewController performSegueWithIdentifier:@"loginViewSegue" sender:self];
    }
}

@end
