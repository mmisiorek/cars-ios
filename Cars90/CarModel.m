//
//  CarModel.m
//  Cars90
//
//  Created by Marcin Misiorek on 28.02.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarModel.h"
#import "CarsAssembly.h"

@implementation CarModel

static NSDateFormatter *dateFormatter = nil;

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"myId": @"id",
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at",
             @"brand": @"brand",
             @"model": @"model",
             @"manufacturedDate": @"manufactured_date",
             @"registrationNumber": @"registration_number",
             @"photo": @"photo",
             @"photoBase64": @"photo_base64",
             @"isAvailable": @"is_available",
             @"user": @"user"
             };
}

+(NSValueTransformer*) createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self defaultDateFormatter] dateFromString:value];
        
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self defaultDateFormatter] stringFromDate:value];
    }];
}

+(NSValueTransformer*) updatedAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self defaultDateFormatter] dateFromString:value];
        
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self defaultDateFormatter] stringFromDate:value];
    }];
}

+(NSValueTransformer*) manufacturedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self defaultDateFormatter] dateFromString:value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self defaultDateFormatter] stringFromDate:value];
    }];
}

+(NSValueTransformer*) photoJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:DocumentModel.class];
}

+(NSValueTransformer*) photoBase64JSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if(value == nil) {
            return nil;
        }
        
        NSValueTransformer *transformer = [MTLJSONAdapter dictionaryTransformerWithModelClass:DocumentBase64Model.class];
        
        return [transformer transformedValue:value];
        
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if(value == nil) {
            return nil;
        }
        
        NSValueTransformer *transformer = [MTLJSONAdapter dictionaryTransformerWithModelClass:DocumentBase64Model.class];
        return [transformer reverseTransformedValue:value];
    }];
}

+(NSValueTransformer*) userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:UserModel.class];
}

+(NSDateFormatter*) defaultDateFormatter {
    if(dateFormatter == nil) {
        CarsAssembly *assembly = [[CarsAssembly new] activate];
        dateFormatter = [assembly defaultDateFormatter];
    }
    
    return dateFormatter; 
}

@end
