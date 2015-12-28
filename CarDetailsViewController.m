//
//  CarDetailsViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 13.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//

#import "CarDetailsViewController.h"

@interface CarDetailsViewController ()

@end

@implementation CarDetailsViewController

- (id)initWithCarData:(NSDictionary *)carData {
    self = [super init];
    
    self.carData = carData;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *brand = [self.carData objectForKey:@"brand"];
    NSString *model = [self.carData objectForKey:@"model"];

    [self.modelLabel setText:model];
    [self.brandLabel setText:brand];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Details of %@ %@", brand, model]; 
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
