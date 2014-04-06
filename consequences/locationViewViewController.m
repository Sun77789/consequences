//
//  locationViewViewController.m
//  consequences
//
//  Created by Malika Aubakirova on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "locationViewViewController.h"
#import "DataController.h"

@interface locationViewViewController ()

@end

@implementation locationViewViewController


-(void) viewWillAppear
{
    NSString *category = [[DataController sharedManager] getCategory];
    NSLog(@"ctegort %@", category);
    if ([category isEqualToString:@"Fitness"] && [category isEqualToString:@"Attend Class"])
        return;
    else
    {
        [self performSegueWithIdentifier:@"showTask" sender:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *category = [[DataController sharedManager] getCategory];
    NSLog(@"ctegort %@", category);
    if ([category isEqualToString:@"Fitness"] && [category isEqualToString:@"Attend Class"])
        return;
    else
    {
        [self performSegueWithIdentifier:@"showTask" sender:self];
    }
}


@end
