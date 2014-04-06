//
//  DataController.m
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "DataController.h"


@implementation DataController

static DataController * _sharedManager = nil;
static dispatch_once_t onceToken;


#pragma mark - Initialization

+ (id)sharedManager
{
    @synchronized([DataController class]) {
        dispatch_once(&onceToken, ^{
            _sharedManager = [[self alloc] init];
        });
    }
    
    return _sharedManager;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        currentTask = [[PFObject alloc] initWithClassName:@"Task"];
    }
    return self;
}


#pragma mark - Consequences Data

-(NSArray*)getCategories
{
    return @[@"Attend Class",
             @"Fitness",
             @"Homework",
             @"Chores",
             @"Custom"];
}


-(void)initTaskWithCategory:(NSString*)category andName:(NSString*)name
{
    currentTask[@"category"] = category;
    currentTask[@"name"] = name;
}

-(void)saveTask
{
    [currentTask saveInBackground];
}

- (void) addTimeToCurrentTask:(NSDate *)time
{
    currentTask[@"date"] = time;
}

-(NSString *) getCategory
{
    return currentTask[@"category"];
}

@end
