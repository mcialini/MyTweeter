//
//  MyTabBarControllerViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/26/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController
@synthesize bgColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.bgColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    };
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
