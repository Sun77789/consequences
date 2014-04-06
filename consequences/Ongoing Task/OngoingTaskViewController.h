//
//  OngoingTaskViewController.h
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface OngoingTaskViewController : UIViewController
{
    IBOutlet MKMapView *mapView;
    IBOutlet UIView *timerView;
    IBOutlet UILabel *timeLabel;
    NSTimer *timer;
    NSDate *goalDate;
}

@end
