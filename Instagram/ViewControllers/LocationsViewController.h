//
//  LocationsViewController.h
//  Instagram
//
//  Created by Nicolas Machado on 7/13/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationsViewController;

@protocol LocationsViewControllerDelegate

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

@end

@interface LocationsViewController : UIViewController

@property (weak, nonatomic) id<LocationsViewControllerDelegate> locationsViewControllerdelegate;

@end
