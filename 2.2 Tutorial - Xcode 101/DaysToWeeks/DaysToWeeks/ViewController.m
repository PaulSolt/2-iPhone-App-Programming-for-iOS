//
//  ViewController.m
//  DaysToWeeks
//
//  Created by Paul on 1/16/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)convertButtonPressed:(UIButton *)sender {
    
    NSLog(@"Convert Days to Weeks");
    
    float days = [self.daysTextField.text floatValue];  // Two steps in one line of code
    
//    NSString *daysString = self.daysTextField.text;
//    days = [daysString floatValue];
    
    float weeks = days / 7.0;
    self.weeksTextField.text = [@(weeks) stringValue];
    
}
@end
