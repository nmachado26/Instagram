//
//  PhotoMapViewController.m
//  Instagram
//
//  Created by Nicolas Machado on 7/13/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "PhotoMapViewController.h"
#import <MapKit/MapKit.h>
#import "LocationsViewController.h"
#import "ComposeViewController.h"

@interface PhotoMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *chooseLocationButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    self.mapView.delegate = self;
    
    //UI
    self.chooseLocationButton.layer.cornerRadius = 15;
    self.chooseLocationButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.chooseLocationButton.clipsToBounds = YES;
    self.doneButton.layer.cornerRadius = 15;
    self.doneButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.doneButton.clipsToBounds = YES;
}

- (IBAction)mainButtonPressed:(id)sender {
     [self performSegueWithIdentifier:@"tagSegue" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"returnMapSegue"]){
        ComposeViewController *composeViewController = [segue destinationViewController];
        composeViewController.address = self.address;
    }
    else{
        LocationsViewController *locationViewController = [segue destinationViewController];
        locationViewController.locationsViewControllerdelegate = self;
    }
}

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude address:(NSString *)address {
    [self.navigationController popToViewController:self animated:YES];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    self.address = address; //save address to send to cell
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = coordinate;
    annotation.title = @"Picture!";
    [self.mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    }
    return annotationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
