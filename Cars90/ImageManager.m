//
//  ImageManager.m
//  Cars90
//
//  Created by Marcin Misiorek on 19.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager

- (UIImage*)createImageBaseOnImage:(UIImage *)image andScale:(CGFloat)scale {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width*scale, image.size.height*scale), NO, scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width*scale, image.size.height*scale)];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

@end
