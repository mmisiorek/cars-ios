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
        CarsResponseModel* responseModel = [MTLJSONAdapter modelOfClass:CarsResponseModel.class fromJSONDictionary:response error:&error];
        
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

- (NSURLSessionTask*) saveCar:(CarModel*)car withError:(NSError**)error andSuccess:(void (^)(CarModel*))success andFailure:(void (^)(CarModel*, NSArray *))failure {
    NSArray *carArray = [MTLJSONAdapter JSONArrayFromModels:@[car] error:error];
    
    if(error != nil) {
        return nil;
    }
    
    if(car.myId != 0) {
        NSDictionary *carDictionary = @{ @"car": [carArray objectAtIndex:0] };
        NSString *url = [NSString stringWithFormat:@"/cars/%d.json", (int)car.myId];
        
        return [self PUT:url parameters:carDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *response = (NSDictionary*)responseObject;
            
            if([response objectForKey:@"success"]) {
                success(car);
            } else {
                failure(car, [self errorArrayToArray:[response objectForKey:@"errors"]]);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(car, @[error]);
        }];
        
    } else {
        NSMutableDictionary *singleCarDictionary = [NSMutableDictionary dictionaryWithDictionary:[carArray objectAtIndex:0]];
        [singleCarDictionary removeObjectForKey:@"id"];
        NSDictionary *carDictionary = @{ @"car": [NSDictionary dictionaryWithDictionary:singleCarDictionary] };
        
        return [self POST:@"/cars.json" parameters:carDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *response = (NSDictionary*)responseObject;
            
            if([response objectForKey:@"success"]) {
                success(car);
                
            } else {
                failure(car, [self errorArrayToArray:[response objectForKey:@"errors"]]);
            }
            
            NSLog(@"Save new object %@", response);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSArray *arr = @[error];
            
            failure(car, arr);
            
        }];
        
    }
}

- (NSArray*) errorArrayToArray:(NSArray*)arr {
    NSMutableArray *result = [NSMutableArray array];
    
    for(int i = 0; i < [arr count]; i++) {
        NSDictionary *dic = @{ NSLocalizedDescriptionKey: [arr objectAtIndex:i]};
        
        [result addObject:[[NSError alloc] initWithDomain:@"API" code:0 userInfo:dic]];
    }
    
    return [NSArray arrayWithArray:result];
}


@end
