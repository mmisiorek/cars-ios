//
//  CarModel.h
//  Cars90
//
//  Created by Marcin Misiorek on 28.02.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mantle.h"
#import "MTLModel.h"
#import "DocumentModel.h"

@interface CarModel : MTLModel <MTLJSONSerializing>

//@property(nonatomic) NSInteger *networkId;

@property(copy, nonatomic) NSDate *createdAt;
@property(copy, nonatomic) NSDate *updatedAt;
@property(copy, nonatomic) NSString *brand;
@property(copy, nonatomic) NSString *model;
@property(copy, nonatomic) NSDate *manufacturedDate;
@property(copy, nonatomic) NSString *registrationNumber;
@property(copy, nonatomic) DocumentModel *photo;
//@property(nonatomic) BOOL isAvailable;

@end
