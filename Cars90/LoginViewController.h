//
//  LoginViewController.h
//  Cars90
//
//  Created by Marcin Misiorek on 28.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "AppDelegate.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic, readonly) APIManager *apiManager;
@property (strong, nonatomic, readonly) AppDelegate *appDelegate;

@property (weak) IBOutlet UITextField *usernameField;
@property (weak) IBOutlet UITextField *passwordField;
@property (weak) IBOutlet UIButton *submitButton;

- (id) initWithApiManager:(APIManager*)apiManager andAppDelegate:(AppDelegate*)appDelegate; 

@end
