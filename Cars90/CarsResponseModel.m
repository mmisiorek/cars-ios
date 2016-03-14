//
//  CarsResponseModel.m
//  Cars90
//
//  Created by Marcin Misiorek on 28.02.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarsResponseModel.h"
#import "CarModel.h"

@implementation CarsResponseModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"cars": @"cars"
             };
}

+(NSValueTransformer*) carsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:CarModel.class]; 
}


@end
