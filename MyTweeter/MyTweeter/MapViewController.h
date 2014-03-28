//
//  MapViewController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/25/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *annotations;

- (void)refreshView:(NSArray *)points;

@end
