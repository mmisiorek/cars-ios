//
//  CarsAssembly.h
//  Cars90
//
//  Created by Marcin Misiorek on 07.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <Typhoon/Typhoon.h>
#import "APIManager.h"
#import "ImageManager.h"
#import "AppDelegate.h"
#import "CarFlowController.h"
#import "UserFlowController.h"
#import "CarModel.h"

@class CarFlowController; 

@interface CarsAssembly : TyphoonAssembly

- (AppDelegate*) appDelegate; 
- (APIManager*) apiManager;
- (ImageManager*) imageManager;
- (NSDateFormatter*) defaultDateFormatter;

// view controllers

- (UIViewController*) mainTabViewController; 

- (UINavigationController*) carsTableViewControllerWithNavigation;
- (UINavigationController*) carNewViewControllerWithNavigation;

- (UIViewController*) loginViewController;
- (UIViewController*) logoutViewController;
- (UIViewController*) carNewViewController; 
- (UIViewController*) carEditViewControllerForCarModel:(CarModel*)car;
- (UIViewController*) carDetailsViewControllerForCarModel:(CarModel*)car;
- (UIViewController*) carsTableViewController;

- (CarFlowController*)carFlowController;

// settings

- (NSString*) serverLocation;

@end
