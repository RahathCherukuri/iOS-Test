//
//  AnimationExtendedViewController.m
//  IOSProgrammerTest
//
//  Created by Rahath cherukuri on 3/31/15.
//  Copyright (c) 2015 AppPartner. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AnimationExtendedViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AnimationExtendedViewController ()

@end

@implementation AnimationExtendedViewController
@synthesize animationLabel;

@synthesize animationImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_animation@2x.png"]];
    self.animationLabel.textColor = UIColorFromRGB(000000);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}
- (IBAction)shakeAction:(id)sender
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    shake.fromValue = [NSNumber numberWithFloat:-0.3];
    shake.toValue = [NSNumber numberWithFloat:+0.3];
    shake.duration = 0.1;
    shake.autoreverses = YES;
    shake.repeatCount = 4;
    [self.animationImage.layer addAnimation:shake forKey:@"animationImage"];
    self.animationImage.alpha = 1.0;
    [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
}

- (IBAction)slideAction:(id)sender
{
    [self.animationImage stopAnimating];
    //CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //int width = screenBounds.size.width;
    //NSLog(@"%d", width);
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @30;
    animation.toValue = @300;
    animation.duration = 1;
    [self.animationImage.layer addAnimation:animation forKey:@"animationImage"];
}

- (IBAction)orbitAction:(id)sender
{
    CGPoint center = self.animationImage.center;
    //NSLog(@"%f, %f", center.x, center.y);
    
    CGRect boundingRect = CGRectMake (-center.x+(center.x/2),-center.x+(center.x/2),center.x,center.x);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 1;
    orbit.additive = YES;
    orbit.repeatCount = 1;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    [self.animationImage.layer addAnimation:orbit forKey:@"orbit"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
