//
//  TWAdditionalCitiesViewController.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 19.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWAdditionalCitiesViewController.h"
#import "TWNetManager.h"
#import "TWAdditionalCity.h"
#import "AppDelegate.h"
//#import "CityWeater+CoreDataClass.h"

@interface TWAdditionalCitiesViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    NSArray *additionalCities;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation TWAdditionalCitiesViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return additionalCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell" forIndexPath:indexPath];
    TWAdditionalCity *city = [additionalCities objectAtIndex:indexPath.row];
    cell.textLabel.text = city.cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TWAdditionalCity *additionalCity = [additionalCities objectAtIndex:indexPath.row];
    if (![self isCityAtList:additionalCity.cityName]) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *writeContext = [app.persistentContainer newBackgroundContext];
        CityWeater *city = [NSEntityDescription insertNewObjectForEntityForName:@"CityWeater" inManagedObjectContext:writeContext];
        
        city.cityName = additionalCity.cityName;
        NSError *error;
        if (![writeContext save:&error]) {
            NSLog(@"%@", error.localizedDescription);
        }
        
        if (delegate && [delegate respondsToSelector:@selector(addObject)]) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [delegate addObject];
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Данный город уже есть в списке" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        [self showViewController:alert sender:self];
    }
}

- (BOOL)isCityAtList:(NSString *)cityName {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cityName = %@", cityName];
    [self.cont.fetchRequest setPredicate:predicate];
    NSError *error;
    [self.cont performFetch:&error];
    NSUInteger count = [self.cont.fetchedObjects count];
    if (count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [[TWNetManager sharedInstance] getCitiesListWithPrefix:searchText Success:^(id response) {
        additionalCities = response;
        [self.tableView reloadData];
    } andFailure:^(NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ошибка" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        [self showViewController:alert sender:self];
    }];
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
