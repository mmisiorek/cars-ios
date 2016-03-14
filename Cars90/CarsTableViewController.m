//
//  CarsTableViewController.m
//  Cars
//
//  Created by Marcin Misiorek on 09.08.2015.
//  Copyright (c) 2015 Marcin Misiorek. All rights reserved.
//

#import "CarsTableViewController.h"
#import "AppDelegate.h"
#import "CarDetailsViewController.h"
#import "APIManager.h"
#import "CarModel.h"

@interface CarsTableViewController ()

@end

@implementation CarsTableViewController

@synthesize managedObjectContext; 

- (void)loadView {
  
    UITableView* tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"My Title";
    
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [[appDelegate apiManagerWithForceUpdate:NO] fetchAllCarsWithSuccess:^(CarsResponseModel *responseModel) {
        self.cars = responseModel.cars;
        
        UITableView* tableView = (UITableView*) self.view;
        [tableView reloadData];
        
    } andFailure:^(NSError *error) {
        NSMutableString *str = [[NSMutableString alloc] initWithString:@"There was an error with a connection: "];
        [str appendString:error.localizedDescription];
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Connecion problem" message:[NSString stringWithString:str] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [view show];
    }];
    
    UIBarButtonItem *buttomItem = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleDone target:self action:@selector(onUpdateClicked:)];
    [self.navigationItem setRightBarButtonItem:buttomItem];
//    NSString *serverLocation = [self getServerLocation];
//    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cars.json", serverLocation]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        
//    self.carsConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onUpdateClicked:(id) sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Updating" message:@"The cars are updating" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [[appDelegate apiManagerWithForceUpdate:YES] fetchAllCarsWithSuccess:^(CarsResponseModel *responseModel) {
        self.cars = responseModel.cars;
        
        UITableView *tableView = (UITableView*) self.view;
        [tableView reloadData];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    } andFailure:^(NSError *error) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        UIAlertView *alertFailure = [[UIAlertView alloc] initWithTitle:@"Problem with update" message:@"There was a problem with updating cars" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertFailure show];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.cars) {
        return [self.cars count];
    } else {
        return 0;
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (self.cars) {
        CarModel *car = self.cars[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", car.brand, car.model];
//        
//        NSString *header = @"Car #";
//        NSString *brand = [car objectForKey:@"brand"];
//        NSString *model = [car objectForKey:@"model"];
//        
//        cell.textLabel.text = [header stringByAppendingFormat:@"%d %@ %@", ((int) indexPath.row)+1, brand, model];
        
    } else {
        cell.textLabel.text = @"No data loaded...";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {    
    NSDictionary *car = self.cars[indexPath.row];
    
    CarDetailsViewController *carDetailController = [[CarDetailsViewController alloc] initWithCarData:car];
    
    
    [self.navigationController pushViewController:carDetailController animated:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSMutableData *responseData = [[NSMutableData alloc] init];
    [responseData appendData:data];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    NSLog(@"%@", responseString);
    
    self.cars = json;
    
    UITableView* tableView = (UITableView*) self.view;
    [tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"%@\nReason: '%@'", @"There was a problem with a connection to the server", [error localizedDescription]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection problem" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
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
