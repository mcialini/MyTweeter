//
//  MyAnnotation.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/25/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)t subtitle:(NSString *)s
{
    self.coordinate = coord;
    self.title = t;
    self.subtitle = s;
    return self;
}

@end
