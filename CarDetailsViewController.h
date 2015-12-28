//
//  CarDetailsViewController.h
//  Cars90
//
//  Created by Marcin Misiorek on 13.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailsViewController : UIViewController

@property (strong, nonatomic) NSDictionary *carData;

@property (weak) IBOutlet UILabel *brandLabel;
@property (weak) IBOutlet UILabel *modelLabel;

- (id)initWithCarData:(NSDictionary*)carData;

@end
