//
//  LoginResponseModel.h
//  Cars90
//
//  Created by Marcin Misiorek on 01.08.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "UserModel.h"
#import "Mantle/Mantle.h"

@interface LoginResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSInteger isSuccess;
@property (copy, nonatomic) UserModel *user;

@end
