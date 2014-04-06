//
//  TimeViewViewController.m
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "TimeViewViewController.h"
#import "OngoingTaskViewController.h"
#import "DataController.h"

@interface TimeViewViewController ()

@end

@implementation TimeViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (![[DataController sharedManager] isFitnessOrClass])
    {
        [self.buttonOutlet setTitle:@"Save" forState:UIControlStateNormal];
    }
    [timePicker addTarget:self action:@selector(timeChanged:)
     forControlEvents:UIControlEventValueChanged];
    [timePicker setMinimumDate:[NSDate date]];
}


#pragma mark - Options

-(IBAction)changeTimeOption:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        [timePicker setDate:[NSDate date]];
    }
}
-(IBAction)next:(id)sender
{
    [[DataController sharedManager] saveTask];
}

-(IBAction)timeChanged:(id)sender
{
    NSDate *date = [timePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss, EEE dd MMM yyyy"];
    [[DataController sharedManager] addTimeToCurrentTask:date];
    [self.timeOption setSelectedSegmentIndex:1];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"where"]) {
        NSString *category = [[DataController sharedManager] getCategory];
        
        if ([category isEqualToString:@"Fitness"] || [category isEqualToString:@"Attend Class"]) {
            return;
        }
        else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OngoingTaskViewController *taskViewController = [storyboard instantiateViewControllerWithIdentifier:@"taskViewController"];
            [self presentViewController:taskViewController animated:YES completion:nil];
        }
    }
}

@end
