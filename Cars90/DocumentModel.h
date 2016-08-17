//
//  DocumentModel.h
//  Cars90
//
//  Created by Marcin Misiorek on 09.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "Mantle/Mantle.h"

@interface DocumentModel : MTLModel <MTLJSONSerializing>

@property(assign, nonatomic) NSInteger networkId;
@property(strong, nonatomic) NSString *token;
@property(strong, nonatomic) NSString *originalFilename; 

@end
