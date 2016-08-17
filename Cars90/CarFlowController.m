//
//  CarFlowController.m
//  Cars90
//
//  Created by Marcin Misiorek on 15.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarFlowController.h"


@implementation CarFlowController

- (id) initWithEditControllerCreator:(ObjectCreator *)editControllerCreator andDetailsControllerCreator:(ObjectCreator *)detailsControllerCreator {
    self = [super init];
    
    if(self) {
        self->_editControllerCreator = editControllerCreator;
        self->_detailsControllerCreator = detailsControllerCreator; 
    }
    
    return self;
}

- (void)moveToDetailsWithNavigationController:(UINavigationController *)navigationController andModel:(CarModel *)car {
    NSError *error = nil;
    
    [self.detailsControllerCreator setParameters:@{@"car": car}];
    UIViewController *detailsController = [self.detailsControllerCreator createWithError:&error];
    
    if(!error) {
        return;
    }
    
    [navigationController pushViewController:detailsController animated:YES];
}

- (void)moveToEditWithNavigatorController:(UINavigationController *)navigationController andModel:(CarModel *)car {
    NSError *error = nil;
    
    [self.editControllerCreator setParameters:@{@"car": car}];
    UIViewController *editController = (UIViewController*) [self.editControllerCreator createWithError:&error];
    
    if(!error) {
        return;
    }
    
    [navigationController pushViewController:editController animated:YES]; 
}

@end
