//
//  DataController.h
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>



@interface DataController : NSObject

+ (id)sharedManager;

-(void)createTaskWithCategory:(NSString*)category andName:(NSString*)name;

@end
