//
//  TWAdditionalCityMapper.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 20.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWAdditionalCityMapper.h"

@implementation TWAdditionalCityMapper

+ (TWAdditionalCity *)additionalCityWithDictionary:(NSDictionary *)dictionary {
    TWAdditionalCity *city = [TWAdditionalCity new];
    city.cityName = dictionary[@"structured_formatting"][@"main_text"];
    
    return city;
}
@end
