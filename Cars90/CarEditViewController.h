//
//  CarEditViewController.h
//  Cars90
//
//  Created by Marcin Misiorek on 19.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"

@interface CarEditViewController : UIViewController

@property (strong, nonatomic) CarModel *carModel;

@property (weak) IBOutlet UIScrollView *scrollView;
@property (weak) IBOutlet UIView *contentView;
@property (weak) IBOutlet UITextField *brandField;
@property (weak) IBOutlet UITextField *modelField;
@property (weak) IBOutlet UIDatePicker *dateOfManufacturePicker;
@property (weak) IBOutlet UITextField *registrationNumberField;
@property (weak) IBOutlet UISwitch *isAvailableSwitch;

- (CarEditViewController*) initWithCarModel:(CarModel*)carModel;

@end
