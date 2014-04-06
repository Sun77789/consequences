//
//  OngoingTaskViewController.h
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "OneFingerRotationGestureRecognizer.h"

@interface OngoingTaskViewController : UIViewController <OneFingerRotationGestureRecognizerDelegate>
{
    IBOutlet MKMapView *mapView;
    IBOutlet UIView *timerView;
    IBOutlet UILabel *timeLabel;
    IBOutlet UIImageView *failImage;
    IBOutlet UIImageView *timerSlice;
    IBOutlet UILabel *taskNameL;
    
    IBOutlet UIView *topView;
    
    IBOutlet UIRotationGestureRecognizer *timerRotationRecognizer;
    
    NSTimer *countDownTimer;
    NSDate *goalDate;
}

-(IBAction)timeChanged:(id)sender;
-(IBAction)completedTask:(id)sender;
-(IBAction)failedTask:(id)sender;

@end
