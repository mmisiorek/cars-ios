//
//  LoginViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 28.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "LoginResponseModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id) initWithApiManager:(APIManager *)apiManager andAppDelegate:(AppDelegate *)appDelegate {
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
    
    [self.usernameField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.passwordField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.submitButton addTarget:self action:@selector(onLoginClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onLoginClicked {
    NSError *error = nil;
    
    [self.apiManager loginWithUsername:self.usernameField.text andPassword:self.passwordField.text withError:&error andSuccess:^(LoginResponseModel *response) {
        MainTabBarViewController *tabBarViewController = (MainTabBarViewController*)self.parentViewController;
        [tabBarViewController setSelectedIndex:0];
        
        NSLog(@"user %@", response.user);
        
        [self.appDelegate setUser:response.user];
    } andFailure:^(LoginResponseModel *response, NSArray *arr) {
        NSLog(@"failure %@", arr);
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
