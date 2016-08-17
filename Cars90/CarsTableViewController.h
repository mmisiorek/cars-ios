//
//  CarsTableViewController.h
//  Cars
//
//  Created by Marcin Misiorek on 09.08.2015.
//  Copyright (c) 2015 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "CarFlowController.h"

@interface CarsTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate>

@property (strong, nonatomic, readonly) APIManager *apiManager;
@property (strong, nonatomic, readonly) CarFlowController *carFlowController; 

@property (strong, nonatomic) NSArray *cars;
@property (strong, nonatomic) UITabBarItem* item;
@property (strong, nonatomic) NSConnection *carsConnection;

- (id)initWithApiManager:(APIManager*)apiManager andCarFlowController:(CarFlowController*)carFlowController;

@end
