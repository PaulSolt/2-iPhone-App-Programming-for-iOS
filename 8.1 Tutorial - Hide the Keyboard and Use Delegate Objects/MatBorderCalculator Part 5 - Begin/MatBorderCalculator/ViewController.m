//
//  ViewController.m
//  MatBorderCalculator
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "MatBorder.h"

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
    
    [self calculate];
}

- (void)calculate {
    
    MatBorder *matBorder = [[MatBorder alloc] init];
    
    // Grab user input
    matBorder.frameWidth = [self.frameWidthTextField.text doubleValue];
    matBorder.frameHeight = [self.frameHeightTextField.text doubleValue];
    
    matBorder.imageWidth = [self.imageWidthTextField.text doubleValue];
    matBorder.imageHeight = [self.imageHeightTextField.text doubleValue];
    
    [matBorder calculateBorders];
    
//    NSNumber *topBorderNumber = @(matBorder.topBorderWidth);
//    NSString *topBorderText = [topBorderNumber stringValue];
//    self.topBorderLabel.text = topBorderText;
    
    // Update UI
    self.topBorderLabel.text = [@(matBorder.topBorderWidth) stringValue];
    self.leftBorderLabel.text = [@(matBorder.leftBorderWidth) stringValue];
    self.bottomBorderLabel.text = [@(matBorder.bottomBorderWidth) stringValue];
    self.rightBorderlabel.text = [@(matBorder.rightBorderWidth) stringValue];
    
}








@end
