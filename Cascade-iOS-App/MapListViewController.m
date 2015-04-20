//
//  MapListViewController.m
//  Cascade-iOS-App
//
//  Created by iGuest on 4/19/15.
//  Copyright (c) 2015 Cascade. All rights reserved.
//

#import "MapListViewController.h"
#import "DataManager.h"
#import "Rides.h"


@interface MapListViewController ()

@property (assign,nonatomic) CLLocationCoordinate2D coordinate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) DataManager *dm;
@property (strong, nonatomic) NSMutableArray *rides;

@end

@implementation MapListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.coordinate = CLLocationCoordinate2DMake(47.6204, -122.0000);
    self.dm = [[DataManager alloc] init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = TRUE;
    [self.mapView setCenterCoordinate:self.coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.coordinate, 70000, 60000);
    [self.mapView setRegion:region animated:YES];
    
    self.rides = [self.dm fetchRequest];
    
    
    for (NSInteger index = 0; index < self.rides.count; index ++) {
        Rides *ride = [self.rides objectAtIndex:index];
        double latitude = [[ride valueForKey:@"latitude"] doubleValue];
        double longitude = [[ride valueForKey:@"longitude"] doubleValue];
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
        //CLLocationCoordinate2D *loc =
        RideAnnotation *annotation = [[RideAnnotation alloc] initWithVariable:[ride valueForKey:@"title"] :location];
        MKAnnotationView *aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"rideAnnotation"];
        [self.mapView addAnnotation:annotation];
    }
    
    
    
    
    /*[self.locationManager startUpdatingLocation];
    
    [self.mapView setShowsUserLocation:YES];
    
    self.coordinate = CLLocationCoordinate2DMake(47.6097, 122.3331);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    [self.mapView addAnnotation:annotation];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
{
    NSLog(@"%@",locations);
    
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(47.6097, -122.3331);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000);
    [self.mapView setRegion:region animated:YES];
}

/*- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    //CLLocationCoordinate2D loc = self.locationManager.location.coordinate;
    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 1000, 1000);
    //[self.mapView setRegion:region animated:YES];
}*/

/*- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[RideAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView
                                                                 dequeueReusableAnnotationViewWithIdentifier:@"rideAnnotation"];
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"rideAnnotation"];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
        }
        else
            pinView.annotation = annotation;
        
        return pinView;
    }
    
    return nil;
}*/

@end
