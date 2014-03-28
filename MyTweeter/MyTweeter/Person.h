//
//  Person.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/27/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) MKPlacemark *location;
@property (strong, nonatomic) NSMutableArray *tweets;

- (id)initWithUser:(NSString *)u name:(NSString *)n photo:(NSString *)url location:(MKPlacemark *)loc;
- (NSString *)description;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
