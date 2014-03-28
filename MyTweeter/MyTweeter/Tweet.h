//
//  Tweet.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/27/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) Person *user;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *date;

-(id)initWithID:(NSString *)i user:(Person *)u text:(NSString *)t date:(NSString *)d;
-(NSString *)description;

@end
