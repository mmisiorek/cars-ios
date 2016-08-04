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
                                    <UIImagePickerControllerDelegate>

@property (strong, nonatomic) CarModel *carModel;
@property (strong, nonatomic) UIImage *selectedCarPhoto;

@property (weak) IBOutlet UIScrollView *scrollView;
@property (weak) IBOutlet UIView *contentView;
@property (weak) IBOutlet UITextField *brandField;
@property (weak) IBOutlet UITextField *modelField;
@property (weak) IBOutlet UIDatePicker *dateOfManufacturePicker;
@property (weak) IBOutlet UITextField *registrationNumberField;
@property (weak) IBOutlet UISwitch *isAvailableSwitch;
@property (weak) IBOutlet UIButton *chooseCarPhotoButton;
@property (weak) IBOutlet UIImageView *carPhotoPreview;

- (CarEditViewController*) initWithCarModel:(CarModel*)carModel;

@end
