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
#import "LoginViewController.h"
#import "LogoutViewController.h"
#import "AppDelegate.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (id) init {
    self = [super init];
    
    [self setViewControllers];
    
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
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray *controllers = [NSMutableArray new];
    NSMutableArray *tabBarItems = [NSMutableArray new];
    
    UIViewController *tableController = [[CarsTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] init];
    [navController setViewControllers:[NSArray arrayWithObject:tableController]];
    
    [navController setTitle:@"List"];
    [navController.tabBarItem setImage:[UIImage imageNamed:@"ListIcon"]];
    [controllers addObject:navController];
    
    UIViewController *newController = [[CarEditViewController alloc] init];
    UINavigationController *nav1Controller = [[UINavigationController alloc] init];
    [nav1Controller setViewControllers:[NSArray arrayWithObject:newController]];
    
    [nav1Controller setTitle:@"New car"];
    [nav1Controller.tabBarItem setImage:[UIImage imageNamed:@"NewIcon"]];
    [controllers addObject:nav1Controller];
    
    if(appDelegate.user == nil) {
        UIViewController *loginController = [[LoginViewController alloc] init];
        
        [loginController setTitle:@"Login"];
        [loginController.tabBarItem setImage:[UIImage imageNamed:@"LoginIcon"]];
        [controllers addObject:loginController];
    } else {
        UIViewController *logoutController = [LogoutViewController new];
        
        [logoutController setTitle:@"Logout"];
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
