//
//  CarEditViewControllerCreator.h
//  Cars90
//
//  Created by Marcin Misiorek on 16.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"

@interface CarEditViewControllerCreator : ObjectCreator

- (id)initWithAssembly:(CarsAssembly *)assembly;

// parameters { @"car": (CarModel*}car }

@end
