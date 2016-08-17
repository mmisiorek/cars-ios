//
//  MainTabViewControllerTableViewController.h
//  Cars90
//
//  Created by Marcin Misiorek on 26.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainTabBarViewController : UITabBarController <UITabBarControllerDelegate>

@property (strong, nonatomic, readonly) UIViewController *carsTableViewController;
@property (strong, nonatomic, readonly) UIViewController *carNewViewController;
@property (strong, nonatomic, readonly) UIViewController *loginViewController;
@property (strong, nonatomic, readonly) UIViewController *logoutViewController;
@property (strong, nonatomic, readonly) AppDelegate *appDelegate;

- (id) initWithCarsTableController:(UIViewController*)carsTableController andCarNewController:(UIViewController*)carNewController
                andLoginController:(UIViewController*)loginController andLogoutController:(UIViewController*)logoutController andAppDelegate:(AppDelegate*)appDelegate;
- (void) setViewControllers;

@end
