//
//  PostTweetViewController.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/24/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "PostTweetViewController.h"

@interface PostTweetViewController ()

@property (strong, nonatomic) IBOutlet UIButton *postButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITextField *textBox;

- (IBAction)hitCancelButton:(id)sender;
- (IBAction)hitPostButton:(id)sender;

@end

@implementation PostTweetViewController

@synthesize postButton;
@synthesize cancelButton;
@synthesize textBox;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [textBox becomeFirstResponder];
}

- (IBAction)hitCancelButton:(id)sender {
    id<PostTweetControllerDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(postTweetViewController:didPost:)]) {
        [strongDelegate postTweetViewController:self didPost:@""];
    }
}

- (IBAction)hitPostButton:(id)sender {
    id<PostTweetControllerDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(postTweetViewController:didPost:)]) {
        [strongDelegate postTweetViewController:self didPost:self.textBox.text];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
