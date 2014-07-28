//
//  ViewController.m
//  MatBorderCalculator
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *frameWidthTextField;
@property (weak, nonatomic) IBOutlet UITextField *frameHeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageWidthTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageHeightTextField;

@property (weak, nonatomic) IBOutlet UILabel *topBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBorderlabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)calculateButtonPressed:(UIButton *)sender {
    NSLog(@"Calculate!");
    
    NSLog(@"Frame: %@ x %@", self.frameWidthTextField.text,
          self.frameHeightTextField.text);
    
    NSLog(@"Image: %@ x %@", self.imageWidthTextField.text,
          self.imageHeightTextField.text);
    
}

@end
