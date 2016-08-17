//
//  CarEditViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 19.03.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import "CarEditViewController.h"
#import "AppDelegate.h"
#import "DocumentBase64Model.h"

@interface CarEditViewController ()

@end

@implementation CarEditViewController

- (id) initWithAPIManager:(APIManager *)apiManager andCarModel:(CarModel *)carModel {
    self = [super init];
    
    if(self) {
        self->_carModel = carModel;
        self->_apiManager = apiManager;
        
        self.navigationController.navigationBar.translucent = NO;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateScrollView];
    
    if(self.carModel) {
        [self.brandField setText:self.carModel.brand];
        [self.modelField setText:self.carModel.model];
        [self.registrationNumberField setText:self.carModel.registrationNumber];
        [self.isAvailableSwitch setSelected:self.carModel.isAvailable];
        //[self.dateOfManufacturePicker setDate:self.carModel.manufacturedDate];
        
        NSLog(@"my log %@", self.carModel.registrationNumber);
        
        self.navigationItem.title = [NSString stringWithFormat:@"Edit of %@ %@", self.carModel.brand, self.carModel.model];
    } else {
        self.navigationItem.title = @"Add a new car";
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveCar)];
    
    [self.chooseCarPhotoButton addTarget:self action:@selector(chooseCarPhotoButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

- (void)chooseCarPhotoButtonTouched {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    self.selectedCarPhoto = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.carPhotoPreview setImage:self.selectedCarPhoto];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearForm {
    [self.brandField setText:@""];
    [self.modelField setText:@""];
    [self.dateOfManufacturePicker setDate:[NSDate date]];
    [self.registrationNumberField setText:@""];
    [self.isAvailableSwitch setOn:NO];
    [self setSelectedCarPhoto:nil];
}

- (void)updateScrollView {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect newRect = CGRectMake(0,0, screenRect.size.width, self.contentView.bounds.size.height+100);
    
    [self.scrollView addSubview:self.contentView];
    [self.scrollView setContentSize:CGSizeMake(newRect.size.width, newRect.size.height)];
    [self.scrollView setFrame:CGRectMake(0,0,screenRect.size.width, screenRect.size.height)];
    [self.contentView setFrame:newRect];
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
    
    if(self.selectedCarPhoto) {
        newCarModel.photoBase64 = [[DocumentBase64Model alloc] init];
        newCarModel.photoBase64.image = self.selectedCarPhoto;
        newCarModel.photoBase64.originalFilename = @"iOS_photo.jpg";
    }
    
    [self clearForm]; 
    
    NSError *error;
    
    [self.apiManager saveCar:newCarModel withError:error andSuccess:^(CarModel *carModel) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Send" message:@"The car has been successufully saved" preferredStyle: UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if(self.carModel) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
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
