//
//  LogoutViewController.h
//  Cars90
//
//  Created by Marcin Misiorek on 30.07.2016.
//  Copyright © 2016 Marcin Misiorek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutViewController : UIViewController

@property (weak) IBOutlet UILabel *loadingLabel;

- (void)logout;

@end
