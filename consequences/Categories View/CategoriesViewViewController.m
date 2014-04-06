//
//  CategoriesViewViewController.m
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "CategoriesViewViewController.h"

#import "DataController.h"
#import "TimeViewViewController.h"

@interface CategoriesViewViewController ()

@end

@implementation CategoriesViewViewController


- (void)alertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"Oh my bad..."
                                          otherButtonTitles:nil];
    
    [alert show];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    categories = [[DataController sharedManager] getCategories];
}


#pragma mark - Navigation

-(IBAction)dropKeyboard:(id)sender
{
    [taskNameF resignFirstResponder];
}


#pragma mark - Table View

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *categoryIdentifier = @"CategoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryIdentifier];
    }
    
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return categories.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dropKeyboard:nil];
    
    if (taskNameF.text.length < 1)
    {
        [self alertWithTitle:@"Can you accomplish nothing!?"
                  andMessage:@"(facepalm)"];
        return;
    }
    
    [[DataController sharedManager] initTaskWithCategory:categories[indexPath.row]
                                                         andName:taskNameF.text];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"showTime" sender:self];
}


@end
