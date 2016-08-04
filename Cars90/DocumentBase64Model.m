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
             @"originalFilename": @"original_filename"
             
             };
}

+ (NSValueTransformer*) imageJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        return nil; 
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSData *data = UIImageJPEGRepresentation(value, 1.0);
        
        NSString *dataString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        
        return [NSString stringWithFormat:@"data:image/jpeg;base64,%@", dataString, nil]; 
    }]; 
}

@end
