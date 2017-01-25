//
//  TWAdditionalCitiesViewController.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 19.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityWeater+CoreDataClass.h"

@protocol TWListDelegate <NSObject>

@required

- (void)addObject;

@end

@interface TWAdditionalCitiesViewController : UIViewController

@property (nonatomic, strong) id <TWListDelegate> delegate;

@property (strong, nonatomic) NSFetchedResultsController *cont;

@end
