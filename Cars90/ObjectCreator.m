//
//  ObjectCreator.m
//  Cars90
//
//  Created by Marcin Misiorek on 15.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "ObjectCreator.h"

@implementation ObjectCreator

- (id)initWithAssembly:(CarsAssembly *)assembly {
    self = [super init];
    
    if(self) {
        self->_assembly = assembly;
    }
    
    return self;
}

-(void)setParameters:(NSDictionary *)parameters {
    self->_parameters = parameters;
}

-(id)createWithError:(NSError *__autoreleasing *)error {
    if(self.parameters == nil || self->assemblySelector == nil) {
        *error = [NSError errorWithDomain:@"Something is not set" code:0 userInfo:nil];
        return nil;
    }
    
    if(![self.assembly respondsToSelector:self->assemblySelector]) {
        *error = [NSError errorWithDomain:@"The assembly do not have this selector" code:0 userInfo:nil];
        return nil;
    }
    
    return [self.assembly performSelector:self->assemblySelector withObject:self.parameters];
}

@end
