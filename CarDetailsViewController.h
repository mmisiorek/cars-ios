//
//  CarDetailsViewController.h
//  Cars90
//
//  Created by Marcin Misiorek on 13.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@interface CarDetailsViewController : UIViewController

@property (strong, nonatomic) CarModel *carModel;

@property (weak) IBOutlet UILabel *brandLabel;
@property (weak) IBOutlet UILabel *modelLabel;
@property (weak) IBOutlet UILabel *manufacturedDateLabel;
@property (weak) IBOutlet UILabel *isAvailableLabel;
@property (weak) IBOutlet UILabel *registrationNumberLabel;

@property (weak) IBOutlet UIImageView *carPhoto;
@property (weak) IBOutlet UIScrollView *scrollView;
@property (weak) IBOutlet UIView *contentView;

- (id)initWithCarData:(NSDictionary*)carModel;
- (NSDateFormatter*) dateFormatter;

@end
