//
//  BNRHypnosisViewController.m
//  BNR-iOS-HypnoNerd
//
//  Created by Kelvin Lee on 6/16/14.
//  Copyright (c) 2014 Kelvin. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@end

@implementation BNRHypnosisViewController

// override UIViewController's designated initializer, to get and set tab bar item
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";
        
        // create a UIImage from file
        // this will use hypno@2x.png on retina
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        // put the image on the tab bar item
        self.tabBarItem.image = i;
    }
    return self;
}

- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    
    // create a view
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    // setting the border style on the text field for more visibility
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    // text placeholder
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    
    textField.delegate = self;
    
    [backgroundView addSubview:textField];
    
    // set it as THE view of this view controller
    self.view = backgroundView;
}

- (void)viewDidLoad
{
    // always call the super implementation of viewDidLoad
    [super viewDidLoad];
    NSLog(@"BNRHypnosisViewController loaded its view");
}

// after user inputs text and hits return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    NSLog(@"%@", textField.text);
    // passes the text from input text field to the drawHypnoticMessage
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    
    // hides the keyboard
    [textField resignFirstResponder];
    
    return YES;
}

// draws the message randomly on the screen
- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        // configure the label's text and color
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        // this method resizes the label, which will be relative to the text displayed
        [messageLabel sizeToFit];
        
        // get a random x value that fits within the hypnosis view's width
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        // get a random y value that fits within the hypnosis view's height
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        // update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        // add the label to the hierarchy
        [self.view addSubview:messageLabel];
        
        // motion effect
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    
    }
}

@end
