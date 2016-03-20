//
//  ImageManager.h
//  Cars90
//
//  Created by Marcin Misiorek on 19.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageManager : NSObject

- (UIImage*)createImageBaseOnImage:(UIImage*)image andScale:(CGFloat)scale;

@end
