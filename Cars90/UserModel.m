//
//  UserModel.m
//  Cars90
//
//  Created by Marcin Misiorek on 28.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "UserModel.h"
#import "MMStandardDateFormatter.h"

@implementation UserModel

+(NSDictionary*) JSONKeyPathsByPropertyKey {
    return @{
             @"networkId": @"id",
             @"username": @"username",
             @"email": @"email",
             @"createdAt": @"created_at",
             @"token": @"token"
             };
}

+(NSValueTransformer*) createdAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[MMStandardDateFormatter sharedFormatter] dateFromString:value];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[MMStandardDateFormatter sharedFormatter] stringFromDate:value];
    }];
}

+(NSValueTransformer*) updatedAtJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[MMStandardDateFormatter sharedFormatter] dateFromString:value];
        
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [[MMStandardDateFormatter sharedFormatter] stringFromDate:value];
    }];
}

@end
