//
//  Car.h
//  Cars90
//
//  Created by Marcin Misiorek on 20.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (NSArray*) allCars;

@end

NS_ASSUME_NONNULL_END

#import "Car+CoreDataProperties.h"
