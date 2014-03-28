//
//  PersonTableViewController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/27/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTweetViewController.h"

@interface PersonTableViewController : UITableViewController <PostTweetControllerDelegate>

@property (strong, nonatomic) NSMutableArray *persons;


- (id)initWithStyle:(UITableViewStyle)style persons:(NSArray *)ps;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)refreshView:(NSArray *)ps;
- (void)post;

@end

