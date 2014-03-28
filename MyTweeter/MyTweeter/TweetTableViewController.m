//
//  TweetTableViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/3/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "TweetTableViewController.h"
#import "Tweet.h"
#import "WebViewController.h"
#import "HPAppDelegate.h"
#import "PostTweetViewController.h"



@implementation TweetTableViewController

- (id)initWithStyle:(UITableViewStyle)style tweets:(NSArray *)ts title:(NSString *)t
{
    self = [super initWithStyle:style];
    if (self) {
        self.tweets = [ts mutableCopy];
        self.title = t;
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
    MyTabBarController *tabBar = (MyTabBarController *)self.tabBarController;
    [self.tableView setBackgroundColor:tabBar.bgColor];
    [self.tableView reloadData];
}

- (void)refreshView:(NSArray *)ts {
    self.tweets = [NSMutableArray arrayWithArray:ts];
    [self.tableView reloadData];
}

/* POSTTWEETVIEW DELEGATE METHODS */

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
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TweetTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
        Tweet *cur = self.tweets[indexPath.row];
        UIImageView *img = (UIImageView *)[cell viewWithTag:0];
        UILabel *label = (UILabel *)[cell viewWithTag:1];
        img.image = cur.user.photo;
        [label setNumberOfLines:5];
        [label sizeToFit];
        label.text = cur.text;
        MyTabBarController *tabBar = (MyTabBarController *)self.tabBarController;
        [cell setBackgroundColor:tabBar.bgColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 55.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get the row and the object it represents
    NSUInteger row = indexPath.row;
    Tweet *tweet = self.tweets[row];
    NSRange r;
    NSString *regEx = @"http://\\S*";
    r = [tweet.text rangeOfString:regEx options:NSRegularExpressionSearch];
    if (r.location != NSNotFound) {
        // URL was found
        NSString *url = [tweet.text substringWithRange:r];
        WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle] linkToFollow:url];
        
        [self.navigationController pushViewController:webView animated:NO];
    } else {
        // no URL was found
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
