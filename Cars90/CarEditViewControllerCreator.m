//
//  CarEditViewControllerCreator.m
//  Cars90
//
//  Created by Marcin Misiorek on 16.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarEditViewControllerCreator.h"

@implementation CarEditViewControllerCreator

- (id)initWithAssembly:(CarsAssembly *)assembly {
    self = [super initWithAssembly:assembly];
    
    if(self) {
        self->assemblySelector = @selector(carEditViewControllerForParameters:);
    }
    
    return self;
}

@end
