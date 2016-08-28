//
//  CarFlowController.h
//  Cars90
//
//  Created by Marcin Misiorek on 15.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarsAssembly.h"
#import "CarModel.h"

@class CarsAssembly; 

@interface CarFlowController : NSObject

@property (strong, nonatomic, readonly) CarsAssembly *assembly;

- (id) initWithAssembly:(CarsAssembly*)assembly;

- (void)moveToDetailsWithNavigationController:(UINavigationController*)navigationController andModel:(CarModel*)car;
- (void)moveToEditWithNavigatorController:(UINavigationController*)navigationController andModel:(CarModel*)car;

@end
