//
//  APIManager.m
//  Cars90
//
//  Created by Marcin Misiorek on 28.02.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "APIManager.h"
#import "CarsResponseModel.h"
#import "CarModel.h"

static NSString *const listPath = @"/cars.json";
static NSString *const carImagePath = @"";

@implementation APIManager

- (id) initWithURL:(NSString*) url {
    self = [super initWithBaseURL:[NSURL URLWithString:url]];
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return self;
}

- (NSURLSessionTask*) fetchAllCarsWithSuccess: (void (^)(CarsResponseModel *responseModel)) success
                                andFailure:(void (^)(NSError *error)) failure{
    
    return [self GET:listPath parameters:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError* error = nil;
        
        NSDictionary* response = (NSDictionary*) responseObject;
        NSLog(@"response: %@", response);
        CarsResponseModel* responseModel = [MTLJSONAdapter modelOfClass:CarsResponseModel.class fromJSONDictionary:response error:&error];
        NSLog(@"model: %@ ", responseModel.cars);
        NSLog(@"error: %@", error.localizedFailureReason);
        
        success(responseModel);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (NSURLSessionTask*) fetchImageForCar:(CarModel*)car andWidth: (NSInteger)width andHeight: (NSInteger)height withSuccess:(void (^)(UIImage *image))success
                            andFailure:(void (^)(NSError *error))failure {
    
    NSString *url = [NSString stringWithFormat:@"/document/%i/%@/%d/%d", (int)car.photo.networkId, car.photo.token, (int)width, (int)height];
    
    NSLog(@"url: %@", url);
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
    
    AFImageResponseSerializer *serializer = [AFImageResponseSerializer serializer];
    serializer.imageScale = 1;
    sessionManager.responseSerializer = serializer;
    
    return [sessionManager GET:url parameters:NULL progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UIImage *img = (UIImage*) responseObject;
        
        success(img);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
