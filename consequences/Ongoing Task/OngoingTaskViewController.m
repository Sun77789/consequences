
//
//  OngoingTaskViewController.m
//  consequences
//
//  Created by Geoffroy Lesage on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "OngoingTaskViewController.h"
#import "DataController.h"

@interface OngoingTaskViewController ()

@end

@implementation OngoingTaskViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[DataController sharedManager] isFitnessOrClass])
    {
        [mapView setHidden:NO];
        [timerView setHidden:YES];
    }
    else
    {
        [mapView setHidden:YES];
        [timerView setHidden:NO];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[DataController sharedManager] isFitnessOrClass])
    {
        [self setMapToAddress];
    }
    else
    {
        [self setTimer];
    }
    goalDate = [[DataController sharedManager] getDate];
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(setTimer)
                                   userInfo:nil
                                    repeats:YES];
}

-(void)setMapToAddress
{
    NSString *location = [[DataController sharedManager] getAddress];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateRegion region = mapView.region;
                         region.center = placemark.region.center;
                         region.span.longitudeDelta /= 4000.0;
                         region.span.latitudeDelta /= 4000.0;
                         
                         [mapView setRegion:region animated:YES];
                         [mapView addAnnotation:placemark];
                     }
                 }
     ];
}

-(void)setTimer
{
    NSTimeInterval timeInterval = [goalDate timeIntervalSinceNow];
    if (timeInterval == 0) {
        [timer invalidate];
        timer = nil;
    }
    int min = timeInterval/60;
    double sec = timeInterval - min*60;
    [timeLabel setText:[NSString stringWithFormat:@"%d: %.0f", min, sec]];
}


@end
