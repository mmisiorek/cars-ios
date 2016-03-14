//
//  CarDetailsViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 13.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//

#import "CarDetailsViewController.h"
#import "AppDelegate.h"

@interface CarDetailsViewController ()

@end

@implementation CarDetailsViewController

- (id)initWithCarData:(CarModel*) carModel {
    self = [super init];
    
    self.carModel = carModel;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateScrollView];
    
    NSString *brand = self.carModel.brand;
    NSString *model = self.carModel.model;
    
    [self.modelLabel setText:model];
    [self.brandLabel setText:brand];
    [self.manufacturedDateLabel setText: [[self dateFormatter] stringFromDate:self.carModel.manufacturedDate]];
    
    self.carPhoto.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.title = [NSString stringWithFormat:@"Details of %@ %@", brand, model];
    
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    if(self.carModel.photo) {
        NSLog(@"my love %@", self.carModel.manufacturedDate);
        
        [[appDelegate apiManagerWithForceUpdate:NO] fetchImageForCar:self.carModel withSuccess:^(UIImage *image) {
            
            CGRect rect = CGRectMake(0,0,image.size.width, image.size.height);
            
            [self.carPhoto setFrame:rect];
            [self.carPhoto setImage:image];
            [self.carPhoto setNeedsUpdateConstraints];
            [self.carPhoto updateConstraints];
            
        } andFailure:^(NSError *error) {
            NSLog(@"We have an error");
        }];
    }
}

- (void) updateScrollView {
    [self.scrollView addSubview:self.contentView];
    [self.scrollView setContentSize:CGSizeMake(self.contentView.bounds.size.width, self.contentView.bounds.size.height+200)];
    
    NSLog(@"The size is: %f", self.contentView.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDateFormatter*) dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    return formatter;
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
