//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()

@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@end

@implementation ChatCell

- (void)awakeFromNib
{
    // Initialization code
}

// Loads the UI with the Labels
- (void)loadWithData:(ChatData *)chatData
{
    self.usernameLabel.text = chatData.username;
    self.messageLabel.text = chatData.message;
    NSString * avatar_url = chatData.avatar_url;
    NSURL * imageURL = [NSURL URLWithString:avatar_url];
    [self presentImage:imageURL];
}

// Loads the UI with the Image
-(void)presentImage:(NSURL*)imageURL
{
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData scale:2.0];
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = 25;
    [self.userImageView setImage:image];
}

@end
