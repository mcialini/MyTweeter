//
//  PostTweetViewController.h
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/24/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostTweetControllerDelegate;

@interface PostTweetViewController : UIViewController

@property (weak, nonatomic) id<PostTweetControllerDelegate> delegate;

@end

@protocol PostTweetControllerDelegate <NSObject>

-(void)postTweetViewController:(PostTweetViewController *)postView didPost:(NSString *)text;

@end
