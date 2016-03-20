//
//  AppDelegate.m
//  Cars
//
//  Created by Marcin Misiorek on 09.08.2015.
//  Copyright (c) 2015 Marcin Misiorek. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CarsTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    CarsTableViewController *carController = [[CarsTableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:carController];
    
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString*)getSettingForKey:(NSString*)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* result = [defaults objectForKey:key];
    
    if(!result) {
        [self registerDefaultsFromSettingBundle];
        
        result = [defaults objectForKey:key];
    }
    
    return result;
}

- (void)registerDefaultsFromSettingBundle {
    NSString *settingBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingBundle stringByAppendingString:@"Root.plist"]];
    
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for (NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    NSLog(@"%@", defaultsToRegister);
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}

- (APIManager*) apiManagerWithForceUpdate:(BOOL) forceUpdate {
     if(!self->_apiManager || forceUpdate) {
          NSString *localization = [self getSettingForKey:@"serverLocation"];
          
          self->_apiManager = [[APIManager alloc] initWithURL: localization];
     }
     
     return self->_apiManager;
}

- (ImageManager*) imageManager {
     if(!self->_imageManager) {
          self->_imageManager = [[ImageManager alloc] init];
     }
     
     return self->_imageManager;
}

@end
