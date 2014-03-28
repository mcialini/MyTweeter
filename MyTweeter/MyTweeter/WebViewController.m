//
//  WebViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/24/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

@synthesize webView;
@synthesize link;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil linkToFollow:(NSString *)str
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.link = str;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *back = [WebViewController imageWithImage:[UIImage imageNamed:@"Back.png"]  scaledToSize:CGSizeMake(30.0, 30.0)];
    UIImage *forward = [WebViewController imageWithImage:[UIImage imageNamed:@"Forward.png"]  scaledToSize:CGSizeMake(30.0, 30.0)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:back style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonPressed:)];
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithImage:forward style:UIBarButtonItemStyleBordered target:self action:@selector(forwardButtonPressed:)];
    self.navigationItem.rightBarButtonItems = @[forwardButton, backButton];
    
    NSURL *url = [NSURL URLWithString:self.link];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];
    
}

- (void)viewWillAppear:(BOOL)animated {
}


- (IBAction)backButtonPressed:(id)sender {
    [self.webView goBack];
}
- (IBAction)forwardButtonPressed:(id)sender {
    [self.webView goForward];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
