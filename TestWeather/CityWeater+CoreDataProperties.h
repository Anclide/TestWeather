//
//  CityWeater+CoreDataProperties.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 19.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "CityWeater+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CityWeater (CoreDataProperties)

+ (NSFetchRequest<CityWeater *> *)fetchRequest;

@property (nonatomic) int64_t cityId;
@property (nullable, nonatomic, copy) NSString *cityName;
@property (nonatomic) int64_t time;
@property (nonatomic) int64_t pressure;
@property (nonatomic) int64_t temperature;
@property (nonatomic) int64_t feelingTemperature;
@property (nonatomic) int64_t windSpeed;
@property (nullable, nonatomic, copy) NSString *sunlight;

@end

NS_ASSUME_NONNULL_END
