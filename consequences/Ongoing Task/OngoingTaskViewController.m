
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
{
@private CGFloat imageAngle;
@private OneFingerRotationGestureRecognizer *gestureRecognizer;
}

- (void) updateTimer;
- (void) setupGestureRecognizer;

@end

@implementation OngoingTaskViewController


# pragma mark - View Setup

-(void)viewDidLoad
{
    [super viewDidLoad];
    imageAngle = 0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [taskNameL setText:[[DataController sharedManager] getName]];
    
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
        [self initializeTimer];
        [self setTimer];
        
        [self setupGestureRecognizer];
        [self updateTimer];
    }
}


#pragma mark - Map stuff

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


#pragma mark - Button actions

-(IBAction)completedTask:(id)sender
{
    [self success];
}
-(IBAction)failedTask:(id)sender
{
    [self failure];
}

#pragma mark - Timer

-(void)success
{
    [countDownTimer invalidate];
    countDownTimer = nil;
    
    [topView setHidden:YES];
    [timerView setHidden:YES];
}
-(void)failure
{
    [countDownTimer invalidate];
    countDownTimer = nil;
    
    [topView setHidden:YES];
    [timerView setHidden:YES];
    [failImage setHidden:NO];
}
-(void)initializeTimer
{
    goalDate = [[DataController sharedManager] getDate];
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(setTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    [countDownTimer fire];
}

#pragma mark - Timer Rotation

-(void)setTimer
{
    NSTimeInterval timeInterval = 10;//[goalDate timeIntervalSinceNow]-1;
    if (timeInterval < 0) [self failure];

    int min = timeInterval/60;
    double sec = timeInterval - min*60;
    if (min > 0)    [timeLabel setText:[NSString stringWithFormat:@"%dm %.0fs", min, sec]];
    else            [timeLabel setText:[NSString stringWithFormat:@"%.0fs", sec]];
}

// Updates the text field with the current rotation angle.
- (void) updateTimer
{
    timeLabel.text = [NSString stringWithFormat: @"\u03b1 = %.2f", imageAngle];
}

// Addes gesture recognizer to the view (or any other parent view of image. Calculates midPoint
// and radius, based on the image position and dimension.
- (void) setupGestureRecognizer
{
    // calculate center and radius of the control
    CGPoint midPoint = CGPointMake(timerSlice.frame.origin.x + timerSlice.frame.size.width / 2,
                                   timerSlice.frame.origin.y + timerSlice.frame.size.height / 2);
    CGFloat outRadius = timerSlice.frame.size.width / 2;
    
    // outRadius / 3 is arbitrary, just choose something >> 0 to avoid strange
    // effects when touching the control near of it's center
    gestureRecognizer = [[OneFingerRotationGestureRecognizer alloc] initWithMidPoint: midPoint
                                                                         innerRadius: outRadius / 3
                                                                         outerRadius: outRadius
                                                                              target: self];
    [self.view addGestureRecognizer:gestureRecognizer];
}

#pragma mark - CircularGestureRecognizerDelegate protocol

- (void) rotation: (CGFloat) angle
{
    // calculate rotation angle
    imageAngle += angle;
    if (imageAngle > 360)       imageAngle -= 90;
    else if (imageAngle < -360) imageAngle += 90;
    
    // rotate image and update text field
    timerSlice.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
    [self updateTimer];
}

- (void) finalAngle: (CGFloat) angle
{
    // circular gesture ended, update text field
    [self updateTimer];
}


@end
