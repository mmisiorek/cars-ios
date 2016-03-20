//
//  CarEditViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 19.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarEditViewController.h"
#import "AppDelegate.h"

@interface CarEditViewController ()

@end

@implementation CarEditViewController

- (CarEditViewController*)initWithCarModel:(CarModel*)carModel {
    self = [super init];
    
    self.carModel = carModel;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateScrollView];
    
    [self.brandField setText:self.carModel.brand];
    [self.modelField setText:self.carModel.model];
    [self.registrationNumberField setText:self.carModel.registrationNumber];
    [self.isAvailableSwitch setSelected:self.carModel.isAvailable];
    //[self.dateOfManufacturePicker setDate:self.carModel.manufacturedDate];
    
    NSLog(@"my log %@", self.carModel.registrationNumber);
    
    self.navigationItem.title = [NSString stringWithFormat:@"Edit of %@ %@", self.carModel.brand, self.carModel.model];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveCar)];
    // Do any additional setup after loading the view from its nib.
}

- (void)updateScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect newRect = CGRectMake(0,0, screenRect.size.width, self.contentView.bounds.size.height+100);
    
    [self.scrollView addSubview:self.contentView];
    [self.scrollView setContentSize:CGSizeMake(newRect.size.width, newRect.size.height)];
    [self.scrollView setFrame:CGRectMake(0,0,screenRect.size.width, screenRect.size.height)];
    [self.contentView setFrame:newRect];
    
    NSLog(@"screen %f and content %f and scroll %f", screenRect.size.width, self.contentView.bounds.size.width, self.scrollView.bounds.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveCar {
    CarModel *newCarModel;
    
    if(self.carModel != nil) {
        newCarModel = [self.carModel copy];
    } else {
        newCarModel = [[CarModel alloc] init]; 
    }
    
    newCarModel.brand = self.brandField.text;
    newCarModel.model = self.modelField.text;
    newCarModel.registrationNumber = self.registrationNumberField.text;
    newCarModel.isAvailable = self.isAvailableSwitch.selected;
    
    NSError *error;
    
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    [[appDelegate apiManagerWithForceUpdate:NO] saveCar:newCarModel withError:error andSuccess:^(CarModel *carModel) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Send" message:@"The car has been successufully saved" preferredStyle: UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES]; 
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } andFailure:^(CarModel *carModel, NSArray *errors) {
        
        for(int i = 0; i < [errors count]; i++) {
            NSError *error = [errors objectAtIndex:i];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        
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
