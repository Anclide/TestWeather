//
//  TWDetailedCityInfoMapper.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 20.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWDetailedCityInfo.h"

@interface TWDetailedCityInfoMapper : NSObject

+ (TWDetailedCityInfo *)detailedCityWithDictionary:(NSDictionary *)dictionary;

@end
