//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Rahath Cherukuri on 03/05/15.
//  Copyright (c) 2015 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"
#import "AnimationExtendedViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AnimationSectionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *animationImage;
@property (weak, nonatomic) IBOutlet UILabel *animationLabel;
@property (weak, nonatomic) IBOutlet UIButton *ExtendedButton;

@end

//Save the first touch point
CGPoint firstTouchPoint;

//xd,yd destance between imge center and my touch center
float xd;
float yd;

@implementation AnimationSectionViewController
@synthesize animationImage;
@synthesize animationLabel;
@synthesize ExtendedButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_animation@2x.png"]];
    self.animationLabel.textColor = UIColorFromRGB(000000);
    [[self animationImage]setUserInteractionEnabled:YES];
    self.ExtendedButton = [UIButton buttonWithType:UIButtonTypeSystem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Spinning of the imageview along z-axis.
- (IBAction)spinAction:(id)sender
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    [self.animationImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

//For touch events
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch* bTouch = [touches anyObject];
    if ([bTouch.view isEqual:[self animationImage]]) {
        firstTouchPoint = [bTouch locationInView:[self view]];
        xd = firstTouchPoint.x - [[bTouch view]center].x;
        yd = firstTouchPoint.y - [[bTouch view]center].y;
    }
}

//Imageview is moved it keeps a track of current point and the updated points.
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint cp;
    UITouch* mTouch = [touches anyObject];
    if (mTouch.view == [self animationImage]) {
        cp = [mTouch locationInView:[self view]];
        [[mTouch view]setCenter:CGPointMake(cp.x-xd, cp.y-yd)];
    }
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    int width = screenBounds.size.width;
    int height = screenBounds.size.height;
    
    if(self.animationImage.center.x < 0)
    {
        self.animationImage.center = CGPointMake(width, self.animationImage.center.y);
    }
    if(self.animationImage.center.x > width)
    {
        self.animationImage.center = CGPointMake(0, self.animationImage.center.y);
    }
    if(self.animationImage.center.y < 0)
    {
        self.animationImage.center = CGPointMake(self.animationImage.center.x, height);
    }
    if(self.animationImage.center.y > height)
    {
        self.animationImage.center = CGPointMake(self.animationImage.center.x, 0);
    }
}

//Displaying the MainViewController
- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

//Diplaying the AnimationExtendedViewController
- (IBAction)ExtendedAnimation:(id)sender
{
    AnimationExtendedViewController * animationExtendViewController = [[AnimationExtendedViewController alloc]init];
    [self.navigationController pushViewController:animationExtendViewController animated:YES];
    
}


@end
