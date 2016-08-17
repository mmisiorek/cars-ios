//
//  CarDetailsViewControllerCreator.m
//  Cars90
//
//  Created by Marcin Misiorek on 16.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarDetailsViewControllerCreator.h"

@implementation CarDetailsViewControllerCreator

- (id)initWithAssembly:(CarsAssembly *)assembly {
    self = [super initWithAssembly:assembly];
    
    if(self) {
        self->assemblySelector = @selector(carDetailsViewControllerForParameters:);
    }
    
    return self; 
}

@end
