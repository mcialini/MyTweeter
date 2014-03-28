//
//  WebViewController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 2/24/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UIButton *forward;
@property (weak,nonatomic) NSString *link;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil linkToFollow:(NSString *)link;

- (void)viewWillAppear:(BOOL)animated;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end
