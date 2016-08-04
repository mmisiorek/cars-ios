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
#import "DocumentBase64Model.h"
#import "UserModel.h"

@interface CarModel : MTLModel <MTLJSONSerializing>

@property(nonatomic) NSInteger myId;

@property(copy, nonatomic) NSDate *createdAt;
@property(copy, nonatomic) NSDate *updatedAt;
@property(copy, nonatomic) NSString *brand;
@property(copy, nonatomic) NSString *model;
@property(copy, nonatomic) NSDate *manufacturedDate;
@property(copy, nonatomic) NSString *registrationNumber;
@property(copy, nonatomic) DocumentModel *photo;
@property(copy, nonatomic) DocumentBase64Model *photoBase64;
@property(copy, nonatomic) UserModel *user;
@property(nonatomic) BOOL isAvailable;


@end
