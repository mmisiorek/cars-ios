//
//  CarFlowController.m
//  Cars90
//
//  Created by Marcin Misiorek on 15.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarFlowController.h"


@implementation CarFlowController

- (id) initWithAssembly:(CarsAssembly*)assembly {
    self = [super init];
    
    NSLog(@"flow controller");
    if(self) {
        self->_assembly = assembly;
    }
    
    return self;
}

- (void)moveToDetailsWithNavigationController:(UINavigationController *)navigationController andModel:(CarModel *)car {
    UIViewController *detailsController = [self.assembly carDetailsViewControllerForCarModel:car];
    
    [navigationController pushViewController:detailsController animated:YES];
}

- (void)moveToEditWithNavigatorController:(UINavigationController *)navigationController andModel:(CarModel *)car {
    UIViewController *editController = [self.assembly carEditViewControllerForCarModel:car]; 
    
    [navigationController pushViewController:editController animated:YES];
}

@end
