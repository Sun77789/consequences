//
//  TimeViewViewController.h
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewViewController : UIViewController
{
    IBOutlet UIDatePicker *timePicker;
}

-(IBAction)changeTimeOption:(UISegmentedControl*)sender;
-(IBAction)next:(id)sender;
-(IBAction)timeChanged:(id)sender;

    
@end
