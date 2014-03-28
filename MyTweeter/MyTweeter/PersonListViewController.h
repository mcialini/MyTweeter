//
//  PersonListViewController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/21/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonTableViewController.h"

@interface PersonListViewController : UIViewController

@property (strong, nonatomic) PersonTableViewController *personTable;
@property (strong, nonatomic) UIColor *bgColor;
@property (strong, nonatomic) NSMutableArray *persons;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil persons:(NSMutableArray *)ps;
- (void)viewWillAppear:(BOOL)animated;

@end
