//
//  TWHelpers.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 23.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWHelpers : NSObject

+ (NSString *)celsiumTemperatureWithKelvin:(NSNumber *)celvin;

+ (NSString *)dateTimeWithNumber:(NSNumber *)number;

@end
