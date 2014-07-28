//
//  ViewController.h
//  DaysToWeeks
//
//  Created by Paul on 1/16/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *daysTextField;
@property (weak, nonatomic) IBOutlet UITextField *weeksTextField;
- (IBAction)convertButtonPressed:(UIButton *)sender;

@end
