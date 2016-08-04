//
//  UserModel.m
//  Cars90
//
//  Created by Marcin Misiorek on 28.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (NSDateFormatter*) dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *usPosixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:usPosixLocale];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    
    return formatter;
}

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

@end
