//
//  HPAppDelegate.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/21/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "HPAppDelegate.h"
#import "PersonTableViewController.h"
#import "TweetTableViewController.h"
#import "MyTabBarController.h"
#import "Person.h"
#import "Tweet.h"
#import "PersonListViewController.h"
#import "TweetListViewController.h"
#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@implementation HPAppDelegate

@synthesize tabBarController;
@synthesize navController1;
@synthesize navController2;
@synthesize navController3;
@synthesize personTableController;
@synthesize recentList;
//@synthesize colorChooser;
@synthesize bgColor;

@synthesize account;
@synthesize accountStore;
@synthesize persons;
@synthesize tweets;

@synthesize persons1;
@synthesize tweets1;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Authenticate to Twitter
    if (self.account == nil)
    {
        if (self.accountStore == nil)
        {
            self.accountStore = [[ACAccountStore alloc] init];
        }
        ACAccountType *accountTypeTwitter =
        [self.accountStore
         accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        [self.accountStore requestAccessToAccountsWithType:accountTypeTwitter
                                                   options:nil
                                                completion:^(BOOL granted, NSError *error)
        {
            if(granted) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.account = [self.accountStore
                                    accountsWithAccountType:accountTypeTwitter][0];
                    [self updateTimeline];
                });
            }
        }
         ];
    }
    
    
    // Initialize and allocate space for our controllers
    self.tabBarController = [[MyTabBarController alloc] init];
    self.navController1 = [[UINavigationController alloc] init];
    self.navController2 = [[UINavigationController alloc] init];
    self.navController3 = [[UINavigationController alloc] init];
    
    [self.navController1 viewWillAppear:NO];
    [self.navController1 viewDidAppear:NO];
    
    self.tweets  = [NSMutableArray array];
    self.persons = [NSMutableArray array];
    
    self.persons1 = [[NSMutableDictionary alloc] init];
    self.tweets1 = [[NSMutableDictionary alloc] init];
    
//    PersonTableViewController *pTableController = [[PersonTableViewController alloc] initWithStyle:UITableViewStylePlain persons:self.persons];
//    
//    TweetTableViewController *rList = [[TweetTableViewController alloc] initWithStyle:UITableViewStylePlain tweets:self.tweets title:@"Recent Tweets"];
    
    PersonTableViewController *pTableController = [[PersonTableViewController alloc] initWithStyle:UITableViewStylePlain persons:@[]];
    
    TweetTableViewController *rList = [[TweetTableViewController alloc] initWithStyle:UITableViewStylePlain tweets:@[] title:@"Recent Tweets"];
    
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:[NSBundle mainBundle]];
    
    ColorPickerController *colorChooser = [[ColorPickerController alloc] initWithNibName:@"ColorPickerController"  bundle:[NSBundle mainBundle]];

    //self.colorChooser = [[ColorPickerController alloc] initWithNibName:@"ColorPickerController"  bundle:[NSBundle mainBundle]];


    
    
    
    // Add the navigation controllers to the tab bar
    NSArray *myViews = @[self.navController1, self.navController2, self.navController3, colorChooser];
    self.tabBarController.viewControllers = myViews;
    
    
    // Make the tab bar the main view controller
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
    // Add appropriate tab bar items for each controller
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    navController1.tabBarItem = item1;
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemRecents tag:1];
    navController2.tabBarItem = item2;
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:2];
    navController3.tabBarItem = item3;
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:3];
    colorChooser.tabBarItem = item4;
    
    
    // Push the view controllers to each nav controller
    [navController1 pushViewController:pTableController animated:NO];
    [navController2 pushViewController:rList animated:NO];
    [navController3 pushViewController:mapViewController animated:NO];
    pTableController.title = @"People";
    
    return YES;
}

- (void)refresh:(id)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    [self.tabBarController.view addSubview:spinner];
    
    //switch to background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        //back to the main thread for the UI call
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner startAnimating];
        });
        
        [self updateTimeline];
        
        //back to the main thread for the UI call
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
        });
    });
    
}

- (void)updateTimeline {
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"50" forKey:@"count"];
    SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodGET
                                                          URL:url
                                                   parameters:params];
    [postRequest setAccount:account];
    [postRequest performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse,
                                             NSError *error) {
        NSInteger resp = [urlResponse statusCode];
        if (resp == 200)
        {
            NSError *jsonError = nil;
            id jsonResult = [NSJSONSerialization JSONObjectWithData:responseData
                                                            options:0
                                                              error:&jsonError];
            if (jsonResult != nil)
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self parseJSONResult:jsonResult];
                });
            }
            else
            {
                NSString *message = [NSString
                                     stringWithFormat:@"Could not parse your timeline: %@",
                                     [jsonError localizedDescription]];
                [[[UIAlertView alloc] initWithTitle:@"Error"
                                            message:message
                                           delegate:nil
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:nil]
                 show];
            }
        }
    }];
}

- (void)post:(id)sender {
    [self postTweet:[(UITextField *)sender text]];
}

- (void)postTweet:(NSString *)text {
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
    SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                requestMethod:SLRequestMethodPOST
                                                          URL:url
                                                   parameters:@{@"status":text}];
    [postRequest setAccount:account];
    [postRequest performRequestWithHandler:^(NSData *responseData,
                                             NSHTTPURLResponse *urlResponse,
                                             NSError *error) {
        NSInteger resp = [urlResponse statusCode];
        if (resp == 200){}
    }];
}



- (void)parseJSONResult:(id)jsonResult {
    for (NSDictionary *obj in jsonResult) { // for each tweet on the timeline
        NSString *ID = [obj valueForKey:@"id_str"];
        if ([self.tweets1 valueForKey:@"id_str"] == nil) {
            
            // Check if the user has already been created
            NSDictionary *curUser = (NSDictionary *)[obj valueForKey:@"user"];
            Person *p = [self.persons1 valueForKey:[curUser valueForKey:@"screen_name"]];
            
            if (p == nil) { // They haven't, so we should initialize them
                p = [[Person alloc] initWithUser:[curUser valueForKey:@"screen_name"] name:[curUser valueForKey:@"name"] photo:[curUser valueForKey:@"profile_image_url"] location:nil];
                CLGeocoder *geo = [[CLGeocoder alloc] init];
                [geo geocodeAddressString:[curUser valueForKey:@"location"] completionHandler:^(NSArray *placemarks, NSError *error) {
                    if (error) {
                        //NSLog(@"%@", error);
                    } else {
                        CLPlacemark *cur = (CLPlacemark *)placemarks[0];
                        MKPlacemark *loc = [[MKPlacemark alloc] initWithPlacemark:cur];
                        //NSLog(@"%@: %@ (%f, %f)", p.user, [curUser valueForKey:@"location"], loc.coordinate.latitude, loc.coordinate.longitude);
                        p.location = loc;
                    }
                }];
                [self.persons1 setObject:p forKey:[curUser valueForKey:@"screen_name"]];
            }
            
            Tweet *tweet = [[Tweet alloc] initWithID:ID user:p text:[obj valueForKey:@"text"] date:[obj valueForKey:@"created_at"]];
            
            // Add tweet to person only if it's not already there
            BOOL exists = NO;
            for (int i = 0; i < [p.tweets count]; i++) {
                if ([[(Tweet *)p.tweets[i] ID] isEqual:tweet.ID]) {
                    exists = YES;
                    break;
                }
            }
            if (!exists) {
                [p.tweets addObject:tweet];
            }
            
            [self.tweets1 setObject:tweet forKey:ID];

        }
    }
    
    
    // Next sort tweets by date in descending order
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                 ascending:NO];
    NSArray *temp = [NSArray arrayWithArray:[self.tweets1 allValues]];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedTweets = [temp sortedArrayUsingDescriptors:sortDescriptors];
    
    // Next sort persons in alphabetical order
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"user"
                                                 ascending:YES
                                                  selector:@selector(caseInsensitiveCompare:)];
    temp = [NSArray arrayWithArray:[self.persons1 allValues]];
    sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedPersons = [temp sortedArrayUsingDescriptors:sortDescriptors];
    
    NSArray *childs = self.navController1.childViewControllers;
    NSArray *childs2 = self.navController2.childViewControllers;
    NSArray *childs3 = self.navController3.childViewControllers;
    if ([childs count] == 2) {
        TweetTableViewController *curTweets = (TweetTableViewController *)childs[1];
        [curTweets refreshView:(NSMutableArray *)[self.tweets filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"user.fullName like %@", curTweets.title]]];
    }
    PersonTableViewController *people =(PersonTableViewController *)childs[0];
    TweetTableViewController *curTweets = (TweetTableViewController *)childs2[0];
    MapViewController *map = (MapViewController *)childs3[0];
    [people refreshView:sortedPersons];
    [curTweets refreshView:sortedTweets];
    NSArray *pts = [self.persons1 allValues];
    NSArray *locatedPersons = [pts filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(location != %@)",[NSNull null]]];
    if ([locatedPersons count] != 0) {
        [map refreshView:pts];
    }
}




//- (void)parseJSONResult:(id)jsonResult {
//    for (NSDictionary *obj in jsonResult) { // for each tweet on the timeline
//        Tweet *tweet;
//        NSString *i = 0;
//        NSString *d = @"";
//        NSString *t = @"";
//        __block Person *p = nil;
//        for (id key in obj) { // go through each tweet's fields and extract the important ones
//            if ([key isEqual:@"id_str"]) {
//                id val = [obj objectForKey:key];
//                i = [NSString stringWithString:val];
//            }
//            else if ([key isEqual:@"created_at"]) {
//                id val = [obj objectForKey:key];
//                d = [NSString stringWithString:val];
//            }
//            else if ([key isEqual:@"text"]) {
//                id val = [obj objectForKey:key];
//                t = [NSString stringWithString:val];
//            }
//            else if ([key isEqual:@"user"]) {
//                id val = [obj objectForKey:key];
//                NSString *u = @"";
//                NSString *n = @"";
//                NSString *picUrl = @"";
//                NSString *l = @"";
//                __block MKPlacemark *loc = [MKPlacemark alloc];
//                for (id k in val) {
//                    if ([k isEqual:@"screen_name"]) {
//                        id v = [val objectForKey:k];
//                        u = [NSString stringWithString:v];
//                    }
//                    if ([k isEqual:@"name"]) {
//                        id v = [val objectForKey:k];
//                        n = [NSString stringWithString:v];
//                    }
//                    if ([k isEqual:@"profile_image_url"]) {
//                        id v = [val objectForKey:k];
//                        picUrl = [NSString stringWithString:v];
//                    }
//                    if ([k isEqual:@"location"]) {
//                        id v = [val objectForKey:k];
//                        l = [NSString stringWithString:v];
//                        
//                    }
//                }
//                // create the person object if they haven't already been added
//                
//                CLGeocoder *geo = [[CLGeocoder alloc] init];
//                [geo geocodeAddressString:l completionHandler:^(NSArray *placemarks, NSError *error) {
//                    if (error) {
//                         //NSLog(@"%@", error);
//                    } else {
//                        CLPlacemark *cur = (CLPlacemark *)placemarks[0];
//                        loc = [[MKPlacemark alloc] initWithPlacemark:cur];
//                        NSLog(@"%@: placemark added", p.user);
//                        Person *p = [[Person alloc] initWithUser:u name:n photo:picUrl location:loc];
//                        if (![self inPersons:p]) {
//                            [self.persons addObject:p];
//                        }
//                        
//                    }
//                }];
//            }
//        }
//        
//        //create the tweet object if it hasn't already been added
//        tweet = [[Tweet alloc] initWithID:i user:p text:t date:d];
//        if (![self inTweets:tweet]) {
//            [self.tweets addObject:tweet];
//            // Person should already be in persons array
//            // need to find them, and add tweet to their tweets property
//            for (Person *cur in self.persons) {
//                if ([cur.user isEqual:p.user]) {
//                    [cur.tweets addObject:tweet];
//                    break;
//                }
//            }
//            NSLog(@"");
//        }
//    }
//    
//    
//    // Next sort tweets by date in descending order
//    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
//                                                 ascending:NO];
//    NSArray *temp = [NSArray arrayWithArray:self.tweets];
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//    NSArray *sortedArray = [temp sortedArrayUsingDescriptors:sortDescriptors];
//    self.tweets = [sortedArray mutableCopy];
//    
//    // Next sort persons in alphabetical order
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"user"
//                                                 ascending:YES
//                                                 selector:@selector(caseInsensitiveCompare:)];
//    temp = [NSArray arrayWithArray:self.persons];
//    sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//    sortedArray = [temp sortedArrayUsingDescriptors:sortDescriptors];
//    self.persons = [sortedArray mutableCopy];
//    NSArray *childs = self.navController1.childViewControllers;
//    NSArray *childs2 = self.navController2.childViewControllers;
//    NSArray *childs3 = self.navController3.childViewControllers;
//    if ([childs count] == 2) {
//        TweetTableViewController *curTweets = (TweetTableViewController *)childs[1];
//        [curTweets refreshView:(NSMutableArray *)[self.tweets filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"user.fullName like %@", curTweets.title]]];
//    }
//    PersonTableViewController *people =(PersonTableViewController *)childs[0];
//    TweetTableViewController *curTweets = (TweetTableViewController *)childs2[0];
//    MapViewController *map = (MapViewController *)childs3[0];
//    [people refreshView:self.persons];
//    [curTweets refreshView:self.tweets];
//    NSArray *pts = [self.persons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"location != nil"]];
//    [map refreshView:pts];
//}

- (BOOL)inPersons:(Person *)p {
    for (int i = 0; i < [self.persons count]; i++) {
        if ([[self.persons[i] user] isEqual:p.user]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)inTweets:(Tweet *)t {
    for (int i = 0; i < [self.tweets count]; i++) {
        if ([[self.tweets[i] ID] isEqual:t.ID]) {
            return YES;
        }
    }
    return NO;
}

-(void) getAlert: (id) sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send a Tweet" message:@"Tweet functionality coming soon!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    
    UITextView *someTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 35, 250, 100)];
    someTextView.backgroundColor = [UIColor clearColor];
    someTextView.textColor = [UIColor whiteColor];
    someTextView.editable = NO;
    someTextView.font = [UIFont systemFontOfSize:15];
    [alert addSubview:someTextView];
    [alert show];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
