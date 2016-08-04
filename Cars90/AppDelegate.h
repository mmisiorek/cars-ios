//
//  AppDelegate.h
//  Cars
//
//  Created by Marcin Misiorek on 09.08.2015.
//  Copyright (c) 2015 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"
#import "ImageManager.h"
#import "UserModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    APIManager *_apiManager;
    ImageManager *_imageManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *defaults;
@property (weak, nonatomic) UserModel *user;

-(void) setUser:(UserModel*)user;
-(NSString*) getSettingForKey:(NSString*)key;
-(void) registerDefaultsFromSettingBundle;
-(APIManager*) apiManagerWithForceUpdate: (BOOL) forceUpdate;
-(ImageManager*) imageManager; 

@end

