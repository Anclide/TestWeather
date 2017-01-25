//
//  TWDetailedCityInfoMapper.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 20.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWDetailedCityInfoMapper.h"

@implementation TWDetailedCityInfoMapper

+ (TWDetailedCityInfo *)detailedCityWithDictionary:(NSDictionary *)dictionary {
    TWDetailedCityInfo *info = [TWDetailedCityInfo new];
    info.cityName = dictionary[@"name"];
    info.time = dictionary[@"dt"];
    info.cityId = dictionary[@"id"];
    info.pressure = dictionary[@"main"][@"pressure"];
    info.sunlight = [dictionary[@"weather"] objectAtIndex:0][@"description"];
    info.temperature = dictionary[@"main"][@"temp"];
    info.windSpeed = dictionary[@"wind"][@"speed"];
    info.feelingTemperature = dictionary[@"main"][@"humidity"];
    
    return info;
    
}

@end
