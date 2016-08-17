//
//  LogoutViewController.h
//  Cars90
//
//  Created by Marcin Misiorek on 30.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h" 
#import "AppDelegate.h"

@interface LogoutViewController : UIViewController

@property (strong, nonatomic, readonly) APIManager *apiManager;
@property (strong, nonatomic, readonly) AppDelegate *appDelegate;

@property (weak) IBOutlet UILabel *loadingLabel;

- (id) initWithApiManager:(APIManager*)apiManager andAppDelegate:(AppDelegate*)appDelegate;
- (void)logout;

@end
