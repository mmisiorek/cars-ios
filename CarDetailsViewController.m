//
//  CarDetailsViewController.m
//  Cars90
//
//  Created by Marcin Misiorek on 13.12.2015.
//  Copyright © 2015 Marcin Misiorek. All rights reserved.
//

#import "CarDetailsViewController.h"
#import "AppDelegate.h"
#import "CarEditViewController.h"

@interface CarDetailsViewController ()

@property (strong, nonatomic) UIImage *carPhotoPortrait;
@property (strong, nonatomic) UIImage *carPhotoLandscape;

@end

@implementation CarDetailsViewController

- (id)initWithCarData:(CarModel*) carModel {
    self = [super init];
    
    self.carModel = carModel;
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
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
    [self.registrationNumberLabel setText:self.carModel.registrationNumber];
    [self.isAvailableLabel setText:(self.carModel.isAvailable ? @"Yes" : @"No")];
    
    self.carPhoto.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.title = [NSString stringWithFormat:@"Details of %@ %@", brand, model];
    
    AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    if(self.carModel.photo) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        float imgWidth = MAX(screenRect.size.width, screenRect.size.height);
        
        [[appDelegate apiManagerWithForceUpdate:NO] fetchImageForCar:self.carModel andWidth:imgWidth andHeight:imgWidth withSuccess:^(UIImage *image) {
            [self prepareCarPhotoImages:image];
            [self updateAccordingToOrientationImageView:self.carPhoto withPortraitImage:self.carPhotoPortrait AndLandscapeImage:self.carPhotoLandscape];
            
        } andFailure:^(NSError *error) {
            NSLog(@"We have an error");
        }];
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onClickCarEdit:)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
}

- (void) updateScrollView {
    CGRect mainScreenRect = [[UIScreen mainScreen] bounds];
    
    [self.scrollView addSubview:self.contentView];
    [self.scrollView setContentSize:CGSizeMake(mainScreenRect.size.width, self.contentView.bounds.size.height+200)];
    
    CGRect newContentFrame = CGRectMake(0, 0, mainScreenRect.size.width, self.contentView.bounds.size.height+200);
    
    [self.contentView setFrame:newContentFrame];
    
    NSLog(@"The size is height: %f and width: %f", mainScreenRect.size.height, mainScreenRect.size.width);
}

- (void) prepareCarPhotoImages:(UIImage*)biggerImg {
    self.carPhotoLandscape = biggerImg;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float scale = MIN(screenRect.size.width, screenRect.size.height)/MAX(screenRect.size.width, screenRect.size.height);

    self.carPhotoPortrait = [appDelegate.imageManager createImageBaseOnImage:biggerImg andScale:scale];
}

- (void) updateImageView:(UIImageView*)view withImage:(UIImage*)image {
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    [view setFrame:rect];
    [view setImage:image];
}

- (void) updateAccordingToOrientationImageView:(UIImageView*)view withPortraitImage:(UIImage*)portraitImg AndLandscapeImage:(UIImage*)landscapeImg {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if(screenRect.size.width > screenRect.size.height) {
        [self updateImageView:view withImage:landscapeImg];
        
    } else {
        [self updateImageView:view withImage:portraitImg];
    }
}

- (void) updateImageScale: (CGRect)oldScreenRect {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect imageRect = self.carPhoto.bounds;
    
    if(imageRect.size.width>imageRect.size.height) {
        float scale = screenRect.size.width/oldScreenRect.size.width;
        UIImage *oldImage, *newImage;
        oldImage = self.carPhoto.image;
        
        AppDelegate *appDelegate =  (AppDelegate*) [[UIApplication sharedApplication] delegate];
        newImage = [appDelegate.imageManager createImageBaseOnImage:oldImage andScale:scale];
        
        CGRect newImageRect = CGRectMake(0, 0, newImage.size.width, newImage.size.height);
        [self.carPhoto setFrame:newImageRect];
        [self.carPhoto setImage:newImage];
    }
    
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

- (void)orientationChanged:(NSNotification*)notification {
    [self updateScrollView];
    [self updateAccordingToOrientationImageView:self.carPhoto withPortraitImage:self.carPhotoPortrait AndLandscapeImage:self.carPhotoLandscape];
}

- (void)onClickCarEdit: (id) sender {
    NSLog(@"on click");
    CarEditViewController *carEditViewController = [[CarEditViewController alloc] initWithCarModel:self.carModel];
    
    [self.navigationController pushViewController:carEditViewController animated:YES];
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
