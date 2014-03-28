//
//  PersonListViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/21/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "PersonListViewController.h"
#import "TweetListViewController.h"
#import "MyTabBarController.h"
#import "PersonTableViewController.h"


@implementation PersonListViewController

@synthesize bgColor;
@synthesize personTable;
@synthesize persons;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil persons:(NSMutableArray *)ps
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.persons = ps;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.personTable = [[PersonTableViewController alloc] initWithStyle:UITableViewStylePlain persons:self.persons];
    [self.view addSubview:self.personTable.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    MyTabBarController *tabBar = (MyTabBarController *)self.navigationController.tabBarController;
    [self.personTable.tableView setBackgroundColor:tabBar.bgColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
