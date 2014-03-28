//
//  Person.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/27/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "Person.h"
#import <CoreLocation/CoreLocation.h>
#import "HPAppDelegate.h"

@implementation Person

@synthesize user;
@synthesize fullName;
@synthesize photo;
@synthesize location;
@synthesize tweets;



- (id)initWithUser:(NSString *)u name:(NSString *)n photo:(NSString *)url location:(MKPlacemark *)loc {
    self = [super init];
    if (self) {
        self.user = u;
        self.fullName = n;
        self.location = loc;
        
        NSError *error = nil;
        NSURLResponse *response = nil;
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:url]];
        NSData *data = [NSURLConnection
                        sendSynchronousRequest:request
                        returningResponse:&response error:&error];
        self.photo = [UIImage imageWithData:data];
        
        self.tweets = [NSMutableArray array];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Username: %@", self.user];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
