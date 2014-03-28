//
//  TweetTableViewCell.m
//  MyTweeter
//
//  Created by Cialini, Matthew, John on 3/3/14.
//  Copyright (c) 2014 Cialini, Matthew, John. All rights reserved.
//

#import "TweetTableViewCell.h"

@implementation TweetTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
