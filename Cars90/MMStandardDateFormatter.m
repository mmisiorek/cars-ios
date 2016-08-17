//
//  MMStandardDateFormatter.m
//  Cars90
//
//  Created by Marcin Misiorek on 06.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "MMStandardDateFormatter.h"

@implementation MMStandardDateFormatter

static MMStandardDateFormatter* formatter = nil;

- (id)init {
    self = [super init];
    
    if(self) {
        NSLocale *usPosixLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        [self setLocale:usPosixLocale];
        [self setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    }
    
    return self;
}

+ (MMStandardDateFormatter*) sharedFormatter {
    if(formatter == nil) {
        formatter = [[MMStandardDateFormatter alloc] init];
    }
    
    return formatter; 
}

@end
