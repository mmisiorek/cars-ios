//
//  DocumentModel.m
//  Cars90
//
//  Created by Marcin Misiorek on 09.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "DocumentModel.h"

@implementation DocumentModel

+ (NSDictionary*) JSONKeyPathsByPropertyKey {
    return @{
             @"networkId": @"id",
             @"token": @"token",
             @"originalFilename": @"originalFilename"
             };
}

@end
