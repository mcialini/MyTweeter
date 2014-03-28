//
//  TweetTableViewController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/3/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTweetViewController.h"

@interface TweetTableViewController : UITableViewController <PostTweetControllerDelegate>

@property (strong, nonatomic) NSMutableArray *tweets;

- (id)initWithStyle:(UITableViewStyle)style tweets:(NSArray *)ts title:(NSString *)t;
- (void)refreshView:(NSArray *)tweets;
- (void)post;

@end
