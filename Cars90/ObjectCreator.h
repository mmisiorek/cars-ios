//
//  ObjectCreator.h
//  Cars90
//
//  Created by Marcin Misiorek on 15.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarsAssembly.h"

@interface ObjectCreator : NSObject {
    SEL assemblySelector; 
}

@property (strong, nonatomic, readonly) id assembly;
@property (strong, nonatomic, readonly) NSDictionary* parameters;

- (id)initWithAssembly:(id)assembly;
- (void)setParameters:(NSDictionary*)parameters;
- (id)createWithError:(NSError**)error;

@end
