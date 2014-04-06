//
//  locationViewViewController.h
//  consequences
//
//  Created by Malika Aubakirova on 4/5/14.
//  Copyright (c) 2014 Geoffroy Lesage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface locationViewViewController : UIViewController
{
    IBOutlet MKMapView *mapView;
    IBOutlet UITextField *addressField;
}

-(IBAction)setAddress:(id)sender;

@end
