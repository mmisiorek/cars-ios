//
//  CarsResponseModel.h
//  Cars90
//
//  Created by Marcin Misiorek on 28.02.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTLModel.h"
#import "Mantle.h"

@interface CarsResponseModel : MTLModel<MTLJSONSerializing>

@property(strong, nonatomic) NSArray *cars;

@end
