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
#import <RestKit/RestKit.h>


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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/cars.json", [self getServerLocation]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.carsConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSDictionary *car = self.cars[indexPath.row];
        
        NSString *header = @"Car #";
        NSString *brand = [car objectForKey:@"brand"];
        NSString *model = [car objectForKey:@"model"];
        
        cell.textLabel.text = [header stringByAppendingFormat:@"%d %@ %@", ((int) indexPath.row)+1, brand, model];
        
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
    
    if(!error || data.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OK" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
    
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


- (NSString*)getServerLocation {
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *serverLocation = [app getSettingForKey:@"serverLocation"];
    
    NSError *error = NULL;
    NSRegularExpression *expr = [NSRegularExpression regularExpressionWithPattern:@"^(http|https)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    if([expr numberOfMatchesInString:serverLocation options:0 range:NSMakeRange(0, [serverLocation length])] == 0) {
        serverLocation = [NSString stringWithFormat:@"http://%@", serverLocation];
    }
    
    return serverLocation;
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
