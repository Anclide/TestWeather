//
//  TWCityListViewController.m
//  TestWeather
//
//  Created by Victor Bogatyrev on 18.01.17.
//  Copyright © 2017 Victor Bogatyrev. All rights reserved.
//

#import "TWCityListViewController.h"
#import "TWNetManager.h"
//#import <CoreData/CoreData.h>
#import "CityWeater+CoreDataProperties.h"
#import "AppDelegate.h"
#import "TWAdditionalCitiesViewController.h"
#import "TWDetailedCityInfo.h"
#import "TWScrollContainerViewController.h"
#import "TWHelpers.h"

@interface TWCityListViewController () <NSFetchedResultsControllerDelegate, TWListDelegate> {
    NSArray *cities;
    NSArray *cityIds;
    NSUInteger selectedRow;
}

@property (nonatomic, strong) NSFetchedResultsController *fetchController;
@property (nonatomic, strong) NSMutableArray *loadedCities;
//@property (nonatomic, strong) NSManagedObjectContext *backgroundContext;

@end

@implementation TWCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFetchedController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CityWeater"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"cityName" ascending:YES];
    
    [request setSortDescriptors:@[descriptor]];
    
    AppDelegate *deleg = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *readContext = deleg.persistentContainer.viewContext;
    
    [self setFetchController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:readContext sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchController] setDelegate:self];
    
    //_backgroundContext = deleg.persistentContainer.newBackgroundContext;
    
}

- (void)setup {
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl.superview sendSubviewToBack:self.refreshControl];
    [self setupFetchedController];
    
}

- (void)reloadData {
    [self.fetchController.fetchRequest setPredicate:nil];
    NSError *error;
    [self.fetchController performFetch:&error];
    cities = [self.fetchController fetchedObjects];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    [self backgroundLoad];
}

- (void)addObject {
    [self reloadData];
}

- (void)backgroundLoad {
    _loadedCities = [NSMutableArray array];
    for (CityWeater *info in cities) {
        [[TWNetManager sharedInstance] getDetailedInfo:info.cityName success:^(id response) {
            TWDetailedCityInfo *info = response;
            [self addNewInfo:info];
        } failure:^(NSError *error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    }
    NSLog(@"kek%@", _loadedCities);
}

- (void)addNewInfo:(TWDetailedCityInfo *)info {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cityName = %@", info.cityName];
    [_fetchController.fetchRequest setPredicate:predicate];
    NSError *error;
    [_fetchController performFetch:&error];
    CityWeater *city = [[_fetchController fetchedObjects] objectAtIndex:0];
    city.temperature = [info.temperature intValue];
    city.cityId = [info.cityId intValue];
    city.pressure = [info.pressure intValue];
    city.sunlight = info.sunlight;
    city.time = [info.time intValue];
    city.windSpeed = [info.windSpeed intValue];
    city.feelingTemperature = [info.feelingTemperature intValue];
    [_fetchController.managedObjectContext save:&error];
    [self.tableView reloadData];
    //[_loadedCities addObject:newInfo];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    
    return cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (_loadedCities.count > 0) {
        TWDetailedCityInfo *info = [_loadedCities objectAtIndex:indexPath.row];
        
        cell.textLabel.text = info.cityName;
        cell.detailTextLabel.text = [TWHelpers celsiumTemperatureWithKelvin:info.temperature];
    } else {
        CityWeater *object = [cities objectAtIndex:indexPath.row];
        
        cell.textLabel.text = object.cityName;
        cell.detailTextLabel.text = [TWHelpers celsiumTemperatureWithKelvin:[NSNumber numberWithInteger:object.temperature]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"ToScrollSegue" sender:self];
}

- (IBAction)addButtonTapped:(id)sender {
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddCitySegue"]) {
        TWAdditionalCitiesViewController *toVC = [segue destinationViewController];
        [toVC setCont:self.fetchController];
        toVC.delegate = self;
    } else {
        [_fetchController.fetchRequest setPredicate:nil];
        [_fetchController performFetch:nil];
        cities = [_fetchController fetchedObjects];
        TWScrollContainerViewController *toVC = [segue destinationViewController];
        [toVC setDetailedInfo:[cities objectAtIndex:selectedRow]];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
