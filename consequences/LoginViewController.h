//
//  LoginViewController.h
//  Crushes
//
//  Created by Malika Aubakirova on 3/26/14.
//  Copyright (c) 2014 Malika Aubakirova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data Controller.h"
#import "customizedLoginViewController.h"

@interface LoginViewController : UIViewController <PFLogInViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) NSString *chosenUni;

@end
