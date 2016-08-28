
//
//  MainTabViewControllerTableViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 26.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "CarsTableViewController.h"
#import "CarEditViewController.h"
#import "CarsAssembly.h"
#import "LogoutViewController.h"
#import "AppDelegate.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (id) initWithCarsTableController:(UIViewController *)carsTableController andCarNewController:(UIViewController *)carNewController
                andLoginController:(UIViewController *)loginController andLogoutController:(UIViewController *)logoutController andAppDelegate:(AppDelegate*)appDelegate{
    
    self = [super init];
    
    if(self) {
        self->_carsTableViewController = carsTableController;
        self->_carNewViewController = carNewController;
        self->_loginViewController = loginController;
        self->_logoutViewController = logoutController;
        self->_appDelegate = appDelegate;
        
        [self setViewControllers];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setDelegate:self]; 
}

- (void)setViewControllers {
    CarsAssembly *assembly = [[CarsAssembly new] activate];
    
    NSMutableArray *controllers = [NSMutableArray new];
    
    UINavigationController *navController = (UINavigationController*) self.carsTableViewController;
    [navController setTitle:@"List"];
    [navController.tabBarItem setImage:[UIImage imageNamed:@"ListIcon"]];
    [controllers addObject:navController];
    
    UINavigationController *nav1Controller = (UINavigationController*) self.carNewViewController;
    [nav1Controller setTitle:@"New car"];
    [nav1Controller.tabBarItem setImage:[UIImage imageNamed:@"NewIcon"]];
    [controllers addObject:nav1Controller];
    
    if(self.appDelegate.user == nil) {
        UIViewController *loginController = self.loginViewController;
        
        [loginController.tabBarItem setImage:[UIImage imageNamed:@"LoginIcon"]];
        [controllers addObject:loginController];
    } else {
        UIViewController *logoutController = self.logoutViewController; 
        
        [logoutController.tabBarItem setImage:[UIImage imageNamed:@"LoginIcon"]];
        [controllers addObject:logoutController];
    }
    
    [self setViewControllers:controllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma UITabBarControllerDelegate
*/

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if([viewController isKindOfClass:[LogoutViewController class]]) {
        LogoutViewController *logoutController = (LogoutViewController*)viewController;
        
        [logoutController logout];
    }
}

@end
