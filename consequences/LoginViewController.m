//
//  LoginViewController.m
//  Crushes
//
//  Created by Malika Aubakirova on 3/26/14.
//  Copyright (c) 2014 Malika Aubakirova. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) {
        // If not logged in, we will show a PFLogInViewController
        customizedLoginViewController *logInViewController = [[customizedLoginViewController alloc] init];
        [logInViewController setDelegate:self];
        // Customize the Log In View Controller
        logInViewController.delegate = self;
        logInViewController.facebookPermissions = @[@"status_update", @"publish_actions"];
        logInViewController.fields = PFLogInFieldsFacebook;
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    else {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    
}


#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return NO;
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Error: %@", error.description);
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
