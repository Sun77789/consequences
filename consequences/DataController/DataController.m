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
    if (self) {}
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

-(void)createTaskWithCategory:(NSString*)category andName:(NSString*)name
{
    PFObject *task = [PFObject objectWithClassName:@"Task"];
    task[@"category"] = category;
    task[@"name"] = name;
    [task saveInBackground];
}

@end
