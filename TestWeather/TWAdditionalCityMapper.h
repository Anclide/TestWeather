//
//  TWAdditionalCityMapper.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 20.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWAdditionalCity.h"

@interface TWAdditionalCityMapper : NSObject

+ (TWAdditionalCity *)additionalCityWithDictionary:(NSDictionary *)dictionary;

@end
