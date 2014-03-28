//
//  MapViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/25/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "HPAppDelegate.h"
#import "Person.h"
#import "MyAnnotation.h"

#define ARC4RANDOM_MAX 0x100000000

@interface MapViewController ()


@end

@implementation MapViewController

@synthesize mapView;
@synthesize annotations;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.annotations = [NSMutableArray array];
        self.title = @"Find My Friends";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    NSMutableDictionary *dict = [(HPAppDelegate *)[[UIApplication sharedApplication] delegate] persons1];
    NSArray *locatedPersons = [dict allValues];
    if ([locatedPersons count] != 0) {
        [self refreshView:locatedPersons];
    }
    
}

- (void)refreshView:(NSArray *)locatedPersons {
    self.annotations = [NSMutableArray array];
    for (int i = 0; i < [locatedPersons count]; i++) {
        Person *cur = (Person *)locatedPersons[i];
        if (cur.location != nil) {
            
            /* If more than one user has the same coordinates, the pins will stack on top of each other and only one will be selectable. Adjust this? */
            //NSLog(@"%f, %f",cur.location.coordinate.latitude, cur.location.coordinate.longitude);
            double val1 = ((double)arc4random() / ARC4RANDOM_MAX) * (0.05 + 0.05) + -0.05;
            double val2 = ((double)arc4random() / ARC4RANDOM_MAX) * (0.05 + 0.05) + -0.05;
            CLLocationDegrees lat = cur.location.coordinate.latitude + val1;
            CLLocationDegrees lon = cur.location.coordinate.longitude + val2;
            
            CLLocationCoordinate2D newcoord = CLLocationCoordinate2DMake(lat, lon);
            MyAnnotation *p = [[MyAnnotation alloc] initWithCoordinate:newcoord title:cur.user subtitle:[NSString stringWithFormat:@"%d tweets",[cur.tweets count]]];
            [self.annotations addObject:p];
        }
    }
    [self.mapView addAnnotations:self.annotations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
    static NSString *identifier = @"MyAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    } else {
        annotationView.annotation = annotation;
    }
    Person *p = [[(HPAppDelegate *)[[UIApplication sharedApplication] delegate] persons1] objectForKey:[(MyAnnotation *)annotation title]];
    
    UIImageView *leftIconView = [[UIImageView alloc] initWithImage:p.photo];
    annotationView.leftCalloutAccessoryView = leftIconView;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // here we illustrate how to detect which annotation type was clicked on for its callout
    MyAnnotation *annotation = [view annotation];
    Person *p = [[(HPAppDelegate *)[[UIApplication sharedApplication] delegate] persons1] objectForKey:annotation.title];
    TweetTableViewController *selectedPerson = [[TweetTableViewController alloc] initWithStyle:UITableViewStylePlain tweets:p.tweets title:p.fullName];
    [self.navigationController pushViewController:selectedPerson animated:YES];
}

@end
