//
//  UserModel.h
//  Cars90
//
//  Created by Marcin Misiorek on 28.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "Mantle/Mantle.h"

@interface UserModel : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSInteger networkId;

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSDate *createdAt;
@property (copy, nonatomic) NSDate *updatedAt; 

@end
