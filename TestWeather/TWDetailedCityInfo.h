//
//  TWDetailedCityInfo.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 20.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWDetailedCityInfo : NSObject

@property (nonatomic, strong) NSNumber * cityId;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSNumber * time;
@property (nonatomic, strong) NSNumber * pressure;
@property (nonatomic, strong) NSNumber * temperature;
@property (nonatomic, strong) NSNumber * feelingTemperature;
@property (nonatomic, strong) NSNumber * windSpeed;
@property (nonatomic, strong) NSString * sunlight;

@end
