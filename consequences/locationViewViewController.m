//
//  locationViewViewController.m
//  consequences
//
//  Created by Malika Aubakirova on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import "locationViewViewController.h"
#import "DataController.h"

@interface locationViewViewController ()

@end

@implementation locationViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(IBAction)setAddress:(id)sender
{
    NSString *location = addressField.text;
    
    [[DataController sharedManager] addLocationAddress:location];
    
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


@end
