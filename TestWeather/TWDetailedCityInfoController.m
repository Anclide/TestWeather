//
//  TWDetailedCityInfoController.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 18.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWDetailedCityInfoController.h"
#import "CityWeater+CoreDataClass.h"
#import "TWHelpers.h"

@interface TWDetailedCityInfoController ()

@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *currentTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *pressureLabel;
@property (nonatomic, weak) IBOutlet UILabel *windSpeedLabel;
@property (nonatomic, weak) IBOutlet UILabel *feelingTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *sunlightLabel;

@end

@implementation TWDetailedCityInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)setup {
    _cityNameLabel.text = _detailedInfo.cityName;
    _currentTemperatureLabel.text = [NSString stringWithFormat:@"%@ C", [TWHelpers celsiumTemperatureWithKelvin:[NSNumber numberWithInteger:_detailedInfo.temperature]]];
    _windSpeedLabel.text = [NSString stringWithFormat:@"Скорость ветра: %lld м/с", _detailedInfo.windSpeed];
    _pressureLabel.text = [NSString stringWithFormat:@"Давление: %lld мм р/с", _detailedInfo.pressure];
    _feelingTemperatureLabel.text = [NSString stringWithFormat:@"Влажность: %lld", _detailedInfo.feelingTemperature];
    _timeLabel.text = [NSString stringWithFormat:@"Погода по состоянию на: %@", [TWHelpers dateTimeWithNumber:[NSNumber numberWithInteger:_detailedInfo.time]]];
    _sunlightLabel.text = [NSString stringWithFormat:@"%@", _detailedInfo.sunlight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
