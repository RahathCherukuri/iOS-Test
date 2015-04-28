//
//  APISectionViewController.m
//  IOSProgrammerTest
//
//  Created by Rahath cherukuri on 3/31/15.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "LoginSectionViewController.h"
#import "MainMenuViewController.h"
#import "Network.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginSectionViewController ()

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginSectionViewController

@synthesize loginLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.usernameTextField setDelegate:self];
    [self.passwordTextField setDelegate:self];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_login.png"]];
    self.loginLabel.textColor = UIColorFromRGB(0xffffff);
//    self.loginLabel.textColor = [self colorWithHexString:@"#ffffff"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Display the MainViewController
- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

// Checks if the username and password valid.
// If valid then send it to the network.
- (IBAction)loginAction:(id)sender
{
    
    NSString * username = self.usernameTextField.text;
    NSString * password = self.passwordTextField.text;
    
    
    [self.passwordTextField resignFirstResponder];
    
    
    if([username  isEqual:@""] || [password  isEqual:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username/Password cannot be blank"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        Network * network = [[Network alloc]init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedDataNotification:)
                                                 name:@"ReceivedData"
                                               object:nil];
        [network postValues:username withPassword:password];
    }
    
}

// Receive the Notification as and when we get the response asynchronously.
// Display the message in an AlertView.
-(void) receivedDataNotification:(NSNotification *)notification
{
    NSLog(@"%@", notification.name);
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    double time = [defaults doubleForKey:@"timeDifference"];
    
    NSDictionary * userinfo = notification.userInfo;
    
    NSString * title = [userinfo objectForKey:@"code"];
    NSString * message = [userinfo objectForKey:@"message"];
    
    NSString * completeMessage = [NSString stringWithFormat:@"%@ \n Time: %f seconds", message, time];
//    message =
    
    if([title isEqualToString:@"Success"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:completeMessage
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        self.usernameTextField.text = @"";
        self.passwordTextField.text = @"";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:completeMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ReceivedData" object:nil];
}

// Handles the ButtonClick on the AlertView.
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0)
    {
        MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
        [self.navigationController pushViewController:mainMenuViewController animated:YES];
    }
}

// Handles the "return" press on the keyboard.
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
}

@end
