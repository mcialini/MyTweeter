//
//  TweetListViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/24/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "TweetListViewController.h"
#import "WebViewController.h"
#import "MyTabBarController.h"

@interface TweetListViewController ()

@end

@implementation TweetListViewController

@synthesize label1;
@synthesize label2;
@synthesize label3;
@synthesize label4;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize listOfTweets;
@synthesize name;
@synthesize bgColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)title tweets:(NSArray *)list
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.listOfTweets = list;
        self.name = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = name;
    self.label1.text = listOfTweets[0];
    self.label2.text = listOfTweets[1];
    self.label3.text = listOfTweets[2];
    self.label4.text = listOfTweets[3];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTweets:)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = rightButton;
}


- (void)viewWillAppear:(BOOL)animated {
    MyTabBarController *tabBar = (MyTabBarController *)self.navigationController.tabBarController;
    [self.view setBackgroundColor:tabBar.bgColor];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstLink:(id)sender {
    WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle] linkToFollow:self.label1.text];
    [self.navigationController pushViewController:webView animated:YES];
}
- (IBAction)secondLink:(id)sender {
    WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle] linkToFollow:self.label2.text];
    [self.navigationController pushViewController:webView animated:YES];
}
- (IBAction)thirdLink:(id)sender {
    WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle] linkToFollow:self.label3.text];
    [self.navigationController pushViewController:webView animated:YES];
}
- (IBAction)fourthLink:(id)sender {
    WebViewController *webView = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:[NSBundle mainBundle] linkToFollow:self.label4.text];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)refreshTweets:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Refresh functionality coming soon!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    UITextView *someTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 35, 250, 100)];
    someTextView.backgroundColor = [UIColor clearColor];
    someTextView.textColor = [UIColor whiteColor];
    someTextView.editable = NO;
    someTextView.font = [UIFont systemFontOfSize:15];
    [alert addSubview:someTextView];
    [alert show];
}

@end
