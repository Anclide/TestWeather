//
//  TWHelpers.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 23.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWHelpers.h"

@implementation TWHelpers

+ (NSString *)celsiumTemperatureWithKelvin:(NSNumber *)celvin {
    return [NSString stringWithFormat:@"%d", ([celvin intValue] - 275)];
}

+ (NSString *)dateTimeWithNumber:(NSNumber *)number {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[number doubleValue]];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"RU"];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
    return [formatter stringFromDate:date];
}

@end
