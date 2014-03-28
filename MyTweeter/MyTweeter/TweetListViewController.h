//
//  TweetListViewController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/24/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;


@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;

@property (strong,nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *listOfTweets;

@property (strong, nonatomic) UIColor *bgColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil name:(NSString *)title tweets:(NSArray *)listOfTweets;

- (void)viewWillAppear:(BOOL)animated;

- (IBAction)firstLink:(id)sender;
- (IBAction)secondLink:(id)sender;
- (IBAction)thirdLink:(id)sender;
- (IBAction)fourthLink:(id)sender;

- (void)refreshTweets:(id)sender;
@end
