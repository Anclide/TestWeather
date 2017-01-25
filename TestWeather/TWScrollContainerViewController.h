//
//  TWScrollContainerViewController.h
//  TestWeather
//
//  Created by Victor Bogatyrev on 23.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityWeater;

@interface TWScrollContainerViewController : UIViewController

@property (nonatomic, strong) CityWeater *detailedInfo;

@end
