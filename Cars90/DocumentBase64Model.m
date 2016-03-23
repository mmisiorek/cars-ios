//
//  DocumentBase64Model.m
//  Cars90
//
//  Created by Marcin Misiorek on 23.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "DocumentBase64Model.h"

@implementation DocumentBase64Model

+ (NSDictionary*) JSONKeyPathsByPropertyKey {
    return @{
             @"image": @"data",
             @"original_filename": @"original_filename"
             
             };
}

+ (NSValueTransformer*) imageDataTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        return nil; 
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSData *data = UIImageJPEGRepresentation(value, 1.0);
        
        return [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }]; 
}

@end
