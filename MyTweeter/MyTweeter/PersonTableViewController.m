//
//  PersonTableViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/27/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "PersonTableViewController.h"
#import "Person.h"
#import "Tweet.h"
#import "MyTabBarController.h"
#import "TweetTableViewController.h"
#import "HPAppDelegate.h"
#import "PostTweetViewController.h"

@interface PersonTableViewController ()

@end

@implementation PersonTableViewController

@synthesize persons;

- (id)initWithStyle:(UITableViewStyle)style persons:(NSArray *)ps
{
    self = [super initWithStyle:style];
    if (self) {
        self.persons = [ps mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:@selector(refresh:)];
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(post)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItems = @[tweetButton, refreshButton];
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
    MyTabBarController *tabBar = (MyTabBarController *)self.navigationController.tabBarController;
    [self.tableView setBackgroundColor:tabBar.bgColor];
    [self.tableView reloadData];
}

- (void)refreshView:(NSArray *)ps {
    self.persons = [NSMutableArray arrayWithArray:ps];
    [self.tableView reloadData];
}

- (void)post {
    PostTweetViewController *postView = [[PostTweetViewController alloc] initWithNibName:@"PostTweetViewController" bundle:[NSBundle mainBundle]];
    postView.delegate = self;
    
    [self presentViewController:postView animated:NO completion:nil];
}

- (void)postTweetViewController:(PostTweetViewController *)postView didPost:(NSString *)text {
    
    if (![text isEqualToString:@""]) {
        HPAppDelegate *aD = (HPAppDelegate *)[[UIApplication sharedApplication] delegate];
        [aD postTweet:text];
    }

    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.persons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Person *temp = [self.persons objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"@%@",temp.user];
        cell.imageView.image = temp.photo;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d tweets",temp.tweets.count];
        MyTabBarController *tabBar = (MyTabBarController *)self.tabBarController;
        [cell setBackgroundColor:tabBar.bgColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the row and the object it represents
    NSUInteger row = indexPath.row;
    Person *selectedPerson = [self.persons objectAtIndex:row];
    
    /* Create a new TweetTableViewController with the appropriate tweets loaded in */
    TweetTableViewController *myTweets = [[TweetTableViewController alloc] initWithStyle:UITableViewStylePlain tweets:selectedPerson.tweets title:selectedPerson.fullName];
    [self.navigationController pushViewController:myTweets animated:NO];

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
