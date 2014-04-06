//
//  CategoriesViewViewController.h
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesViewViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *categoriesTable;
    IBOutlet UITextField *taskNameF;
    NSArray *categories;
    
    int categoryIndex;
}

-(IBAction)dropKeyboard:(id)sender;

@end
