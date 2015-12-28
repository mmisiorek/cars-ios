//
//  Car+CoreDataProperties.h
//  Cars90
//
//  Created by Marcin Misiorek on 20.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *brand;
@property (nullable, nonatomic, retain) NSString *model;

@end

NS_ASSUME_NONNULL_END
