//
//  HPAppDelegate.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/21/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/SLRequest.h>
#import "PersonTableViewController.h"
#import "TweetTableViewController.h"
#import "ColorPickerController.h"
#import "MyTabBarController.h"
#import "PersonListViewController.h"
#import "TweetListViewController.h"

@interface HPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyTabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navController1;
@property (strong, nonatomic) UINavigationController *navController2;
@property (strong, nonatomic) UINavigationController *navController3;
@property (strong, nonatomic) PersonTableViewController *personTableController;
@property (strong, nonatomic) TweetTableViewController *recentList;
//@property (strong, nonatomic) ColorPickerController *colorChooser;
@property (strong, nonatomic) UIColor *bgColor;
@property (strong, nonatomic) PersonListViewController *personListController;
@property (strong, nonatomic) TweetListViewController *tweetListController;

@property (strong, nonatomic) ACAccount *account;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) NSMutableArray *persons;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) NSMutableDictionary *persons1;
@property (strong, nonatomic) NSMutableDictionary *tweets1;
@property (weak, nonatomic) id<UIApplicationDelegate> delegate;

- (void)refresh:(id)sender; // help function to use as button press selector
- (void)updateTimeline; // function to access the twitter ui timeline and build an array of tweets and persons
- (void)post:(id)sender; // help function to use as button press selector
- (void)postTweet:(NSString *)text; // function to post a tweet 


@end
