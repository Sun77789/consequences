//
//  Data Controller.m
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "Data Controller.h"

#import <Parse/Parse.h>

@implementation Data_Controller

-(NSArray*)getCategories
{
    return @[@"Fitness",
             @"Homework",
             @"Chores",
             @"Custom"];
}

@end
