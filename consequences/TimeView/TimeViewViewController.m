//
//  TimeViewViewController.m
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "TimeViewViewController.h"

#import "DataController.h"

@interface TimeViewViewController ()

@end

@implementation TimeViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(IBAction)testTask:(id)sender
{
    [[DataController sharedManager] createTaskWithCategory:@"Fitness" andName:@"My gym thing"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
