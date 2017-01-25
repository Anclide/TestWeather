//
//  CityWeater+CoreDataProperties.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 19.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "CityWeater+CoreDataProperties.h"

@implementation CityWeater (CoreDataProperties)

+ (NSFetchRequest<CityWeater *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CityWeater"];
}

@dynamic cityId;
@dynamic cityName;
@dynamic time;
@dynamic pressure;
@dynamic temperature;
@dynamic feelingTemperature;
@dynamic windSpeed;
@dynamic sunlight;

@end
