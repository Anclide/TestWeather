//
//  TWNetManager.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 18.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWNetManager.h"
#import <AFNetworking.h>
#import "TWAdditionalCityMapper.h"
#import "TWDetailedCityInfoMapper.h"

static NSString * const baseUrl = @"http://api.openweathermap.org/";
static NSString * const APIKey = @"e5c4b538db0502d9b36d4bec9decc076";
static NSString * const currentWeatherEndpoint = @"data/2.5/weather";

static NSString * const googlePlacesBaseUrl = @"https://maps.googleapis.com/maps/api/place/autocomplete/json";
static NSString * const googleAPIKey = @"AIzaSyD62YqKyigy3WBG_6A8O8cEJdGRetEOubI";

@interface TWNetManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation TWNetManager

+ (id)sharedInstance {
    static TWNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.sessionManager = [manager configureSessionManager];
    });
    return manager;
}

- (AFHTTPSessionManager *)configureSessionManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    
    [serializer setReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer = serializer;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/plain",@"text/html",@"application/json"]];
    
    return manager;
}

- (void)getCitiesListWithPrefix:(NSString *)prefix
                        Success:(TWSuccessBlock)success
                     andFailure:(TWFailureBlock)failure {
    
    NSString *url = googlePlacesBaseUrl;
    
    NSDictionary *params = @{
                             @"key":googleAPIKey,
                             @"input":prefix,
                             @"types":@"(cities)"
                             };
    
    
    [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *citiesModels = [NSMutableArray new];
        if ([responseObject[@"status"] isEqualToString:@"OK"]) {
            NSArray *response = responseObject[@"predictions"];
            for (NSDictionary *dict in response) {
                [citiesModels addObject:[TWAdditionalCityMapper additionalCityWithDictionary:dict]];
            }
        }
        success([citiesModels copy]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

- (void)getDetailedInfo:(NSString *)cityName
                success:(TWSuccessBlock)success
                failure:(TWFailureBlock)failure {
    
    NSString *url = [baseUrl stringByAppendingString:currentWeatherEndpoint];
    
    NSDictionary *params = @{
                             @"q":cityName,
                             @"appid":APIKey
                             };
    
    [self.sessionManager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success([TWDetailedCityInfoMapper detailedCityWithDictionary:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
