//
//  MMStandardDateFormatter.h
//  Cars90
//
//  Created by Marcin Misiorek on 06.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMStandardDateFormatter : NSDateFormatter

- (id) init;

+ (MMStandardDateFormatter*) sharedFormatter; 

@end
