//
//  LogoutViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 30.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "LogoutViewController.h"
#import "AppDelegate.h"
#import "MainTabBarViewController.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (id)initWithApiManager:(APIManager *)apiManager andAppDelegate:(AppDelegate *)appDelegate {
    self = [super init];
    
    if(self) {
        self->_apiManager = apiManager;
        self->_appDelegate = appDelegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logout {
    [self.apiManager logoutWithSuccess:^{
        MainTabBarViewController *tabBarController = (MainTabBarViewController*)self.parentViewController;
        [tabBarController setSelectedIndex:0];
        
        self.appDelegate.user = nil;
        
    } andFailure:^(NSError *error){
        NSLog(@"%@", error);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
