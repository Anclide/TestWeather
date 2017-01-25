//
//  TWNetManager.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 18.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TWSuccessBlock)(id);
typedef void(^TWFailureBlock)(NSError *);

@interface TWNetManager : NSObject

+ (id)sharedInstance;

- (void)getCitiesListWithPrefix:(NSString *)prefix
                        Success:(TWSuccessBlock)success
                     andFailure:(TWFailureBlock)failure;

- (void)getDetailedInfo:(NSString *)cityName
                success:(TWSuccessBlock)success
                failure:(TWFailureBlock)failure;

@end
