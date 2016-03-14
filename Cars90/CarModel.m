//
//  CarModel.m
//  Cars90
//
//  Created by Marcin Misiorek on 28.02.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel

+ (NSDateFormatter*) dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usPosixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:usPosixLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    return formatter;
}

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             //@"networkId": @"id",
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at",
             @"brand": @"brand",
             @"model": @"model",
             @"manufacturedDate": @"manufactured_date",
             @"registrationNumber": @"registration_number",
             @"photo": @"photo"
             };
}

+(NSValueTransformer*) createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:value];
        
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] stringFromDate:value];
    }];
}

+(NSValueTransformer*) updatedAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:value];
        
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] stringFromDate:value];
    }];
}

+(NSValueTransformer*) manufacturedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] stringFromDate:value];
    }];
}

+(NSValueTransformer*) photoJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:DocumentModel.class];
}

@end
