//
//  customizedLoginViewController.m
//  Crushes
//
//  Created by Malika Aubakirova on 3/28/14.
//  Copyright (c) 2014 Malika Aubakirova. All rights reserved.
//

#import "customizedLoginViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface customizedLoginViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end


@implementation customizedLoginViewController
@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]]];
    //[self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2x.jpg"]]];
    
    [self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
    //[self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"FacebookDown.png"] forState:UIControlStateHighlighted];
    //[self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"Facebook" forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateHighlighted];
    
    // Add login field background
    
    // Remove text shadow
    
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0f;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0f;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    [self.logInView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
    [self.logInView.facebookButton setFrame:CGRectMake(35.0f, 180.0f, 240.0f, 40.0f)];
    //[self.fieldsBackground setFrame:CGRectMake(35.0f, 145.0f, 500.0f, 200.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
