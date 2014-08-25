//
//  BNRReminderViewController.m
//  BNR-iOS-HypnoNerd
//
//  Created by Kelvin Lee on 6/16/14.
//  Copyright (c) 2014 Kelvin. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property (nonatomic, weak)IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

// override UIViewController's designated initializer, to get and set tab bar item
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // get the tab bar item
        UITabBarItem *tbi = self.tabBarItem;
        
        // give it a label
        tbi.title = @"Reminder";
        
        // give it an image
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        tbi.image = i;
    }
    return self;
}

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    
    NSLog(@"Setting a reminder for %@", date);
    
    // add local notification
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRReminderViewController loaded its view");
}

- (void)viewWillAppear:(BOOL)animated
{
    // always call the super
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

@end
