//
//  DocumentBase64Model.h
//  Cars90
//
//  Created by Marcin Misiorek on 23.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <Mantle/Mantle.h>
#import <UIKit/UIKit.h>

@interface DocumentBase64Model : MTLModel

@property(copy, nonatomic) UIImage *image;
@property(copy, nonatomic) NSString *originalFilename; 

@end
