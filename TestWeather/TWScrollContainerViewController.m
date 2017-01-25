//
//  TWScrollContainerViewController.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 23.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWScrollContainerViewController.h"
#import "TWDetailedCityInfoController.h"

@interface TWScrollContainerViewController ()

@end

@implementation TWScrollContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailedSegue"]) {
        TWDetailedCityInfoController *toVC = [segue destinationViewController];
        [toVC setDetailedInfo:_detailedInfo];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
