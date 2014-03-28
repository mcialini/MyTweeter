//
//  Tweet.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/27/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize ID;
@synthesize user;
@synthesize text;
@synthesize date;



-(id)initWithID:(NSString *)i user:(Person *)u text:(NSString *)t date:(NSString *)d {
    self = [super init];
    if (self) {
        self.ID = i;
        self.user = u;
        self.text = t;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss ZZZ yyyy"];
        NSDate *oldDate  = [dateFormatter dateFromString:d];
        [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
        NSString *newDate = [dateFormatter stringFromDate:oldDate];
        self.date = [dateFormatter dateFromString:newDate];
    }
    
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@): %@", self.user, self.date, self.text];
}

@end
