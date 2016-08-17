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
#import "ObjectCreator.h"
#import "CarFlowController.h"
#import "UserFlowController.h"

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
- (UIViewController*) carEditViewControllerForParameters:(NSDictionary*)params;
- (UIViewController*) carDetailsViewControllerForParameters:(NSDictionary*)params;
- (UIViewController*) carsTableViewController;

- (CarFlowController*)carFlowController;

- (ObjectCreator*)carEditViewControllerCreator;
- (ObjectCreator*)carDetailsViewControllerCreator;

// settings

- (NSString*) serverLocation;

@end
