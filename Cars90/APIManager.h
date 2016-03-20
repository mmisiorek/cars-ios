//
//  APIManager.h
//  Cars90
//
//  Created by Marcin Misiorek on 28.02.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "CarsResponseModel.h"
#import "CarModel.h"

@interface APIManager : AFHTTPSessionManager

- (id) initWithURL: (NSString*) url;
- (NSURLSessionTask*) fetchAllCarsWithSuccess: (void (^)(CarsResponseModel *responseModel)) success
                                   andFailure: (void (^)(NSError *error)) failure;

- (NSURLSessionTask*) fetchImageForCar:(CarModel*) carModel andWidth:(NSInteger) width andHeight:(NSInteger) height withSuccess:(void (^)(UIImage *image)) success
                            andFailure: (void (^)(NSError *error)) failure;

- (NSURLSessionTask*) saveCar:(CarModel*)car withError:(NSError*)error andSuccess: (void (^)(CarModel*))success andFailure: (void (^)(CarModel*, NSArray*))failure;

@end
