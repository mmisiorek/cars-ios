//
//  MainTabBarViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 03.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "CarsTableViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (id)init {
    self = [super init];
    
    NSMutableArray *elementsArr = [[NSMutableArray alloc] initWithCapacity:1];
    
    CarsTableViewController *carsTableController = [[CarsTableViewController alloc] init];
    carsTableController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"List of cars" image:nil tag:1];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:carsTableController];
    [elementsArr addObject:navController];
    
    [self setViewControllers:[elementsArr copy] animated:NO];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
