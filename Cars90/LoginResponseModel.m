//
//  LoginResponseModel.m
//  Cars90
//
//  Created by Marcin Misiorek on 01.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "LoginResponseModel.h"

@implementation LoginResponseModel

+(NSDictionary*) JSONKeyPathsByPropertyKey {
    return @{
             @"isSuccess": @"success",
             @"user": @"user"
             };
}

+(NSValueTransformer*) userJSONTransformer {
    return [MTLJSONAdapter transformerForModelPropertiesOfClass:UserModel.class];
}

@end
