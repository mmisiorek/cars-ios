//
//  CarsAssembly.m
//  Cars90
//
//  Created by Marcin Misiorek on 07.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarsAssembly.h"
#import "LoginViewController.h"
#import "LogoutViewController.h"
#import "CarEditViewController.h"
#import "CarDetailsViewController.h"
#import "CarEditViewControllerCreator.h"
#import "CarDetailsViewControllerCreator.h"
#import "CarsTableViewController.h"
#import "MainTabBarViewController.h"

@implementation CarsAssembly

- (AppDelegate*) appDelegate {
    
    return [TyphoonDefinition withFactory:[self sharedApplication] selector:@selector(delegate) parameters:nil configuration:^(TyphoonFactoryDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (APIManager*) apiManager {
    return [TyphoonDefinition withClass:[APIManager class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithURL:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self serverLocation]];
        }];
    }];
}

- (ImageManager*) imageManager {
    return [TyphoonDefinition withClass:[ImageManager class]];
}

- (NSDateFormatter*) defaultDateFormatter {
    return [TyphoonDefinition withClass:[NSDateFormatter class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dateFormat) with:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        [definition injectProperty:@selector(locale) with:[self usPosixLocale]]; 
    }];
}

// view controllers

- (UIViewController*) mainTabViewController {
    return [TyphoonDefinition withClass:[MainTabBarViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithCarsTableController:andCarNewController:andLoginController:andLogoutController:andAppDelegate:) parameters:^(TyphoonMethod *initializer) {
            
             [initializer injectParameterWith:[self carsTableViewControllerWithNavigation]];
             [initializer injectParameterWith:[self carNewViewControllerWithNavigation]];
             [initializer injectParameterWith:[self loginViewController]];
             [initializer injectParameterWith:[self logoutViewController]];
             [initializer injectParameterWith:[self appDelegate]]; 
        }];
    }];
}

- (UINavigationController*) carsTableViewControllerWithNavigation {
    return [TyphoonDefinition withClass:[UINavigationController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(init)];
        [definition injectMethod:@selector(setViewControllers:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[NSArray arrayWithObject:[self carsTableViewController]]];
        }];
    }];
}

- (UINavigationController*) carNewViewControllerWithNavigation {
    return [TyphoonDefinition withClass:[UINavigationController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(init)];
        [definition injectMethod:@selector(setViewControllers:) parameters:^(TyphoonMethod *method) {
            [method injectParameterWith:[NSArray arrayWithObject:[self carNewViewController]]];
        }];
    }];
}

- (UIViewController*) loginViewController {
    return [TyphoonDefinition withClass:[LoginViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithApiManager:andAppDelegate:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self apiManager]];
            [initializer injectParameterWith:[self appDelegate]];
        }];
        [definition injectProperty:@selector(title) with:@"Login"];
    }];
}

- (UIViewController*) logoutViewController {
    return [TyphoonDefinition withClass:[LogoutViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithApiManager:andAppDelegate:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self apiManager]];
            [initializer injectParameterWith:[self appDelegate]]; 
        }];
        [definition injectProperty:@selector(title) with:@"Logout"]; 
    }];
}

- (UIViewController*) carNewViewController {
    return [TyphoonDefinition withClass:[CarEditViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(init)]; 
    }];
}

- (UIViewController*) carEditViewControllerForParameters:(NSDictionary*)params {
    return [TyphoonDefinition withClass:[CarEditViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithAPIManager:andCarModel:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self apiManager]];
            [initializer injectParameterWith:[TyphoonDefinition withFactory:params selector:@selector(objectForKey:) parameters:^(TyphoonMethod *factoryMethod) {
                [factoryMethod injectParameterWith:@"car"];
            }]];
        }];
    }];
}

- (UIViewController*) carDetailsViewControllerForParameters:(NSDictionary*)params {
    return [TyphoonDefinition withClass:[CarDetailsViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithAPIManager:andCarModel:andCarFlowController:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self apiManager]];
            [initializer injectParameterWith:[TyphoonDefinition withFactory:params selector:@selector(objectForKey:) parameters:^(TyphoonMethod *factoryMethod) {
                [factoryMethod injectParameterWith:@"car"];
            }]];
            [initializer injectParameterWith:[self carFlowController]]; 
        }];
    }];
}

- (UIViewController*) carsTableViewController {
    return [TyphoonDefinition withClass:[CarsTableViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithApiManager:andCarFlowController:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self apiManager]];
            [initializer injectParameterWith:[self carFlowController]]; 
        }];
    }];
}

- (CarFlowController*)carFlowController {
    return [TyphoonDefinition withClass:[CarFlowController class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithEditControllerCreator:andDetailsControllerCreator:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:[self carEditViewControllerCreator]];
            [initializer injectParameterWith:[self carDetailsViewControllerCreator]]; 
        }];
    }];
}

- (ObjectCreator*) carEditViewControllerCreator {
    return [TyphoonDefinition withClass:[CarEditViewControllerCreator class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithAssembly:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:self];
        }];
    }];
}

- (ObjectCreator*) carDetailsViewControllerCreator {
    return [TyphoonDefinition withClass:[CarDetailsViewControllerCreator class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithAssembly:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:self];
        }];
    }];
}

// settings

- (NSString*) serverLocation {
    
    return [TyphoonDefinition withFactory:[self appDelegate] selector:@selector(getSettingForKey:) parameters:^(TyphoonMethod *initializer) {
        [initializer injectParameterWith:@"serverLocation"]; 
        
    } configuration:^(TyphoonFactoryDefinition *definition) {
        definition.scope = TyphoonScopeSingleton;
    }];
}

// not published in header

- (UIApplication*) sharedApplication {
    return [TyphoonDefinition withClass:[UIApplication class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(sharedApplication)];
    }];
}

- (NSLocale*) usPosixLocale {
    return [TyphoonDefinition withClass:[NSLocale class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithLocaleIdentifier:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@"en_US_POSIX"];
        }];
    }];
}

@end
