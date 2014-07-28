//
//  ViewController.m
//  MatBorderCalculator
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "MatBorder.h"

@interface ViewController () <UITextFieldDelegate> {
    MatBorder *_matBorder;
}

@property (weak, nonatomic) IBOutlet UITextField *frameWidthTextField;
@property (weak, nonatomic) IBOutlet UITextField *frameHeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageWidthTextField;
@property (weak, nonatomic) IBOutlet UITextField *imageHeightTextField;

@property (weak, nonatomic) IBOutlet UILabel *topBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomBorderLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightBorderlabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frameWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frameHeightConstraint;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.frameWidthTextField.delegate = self;
    self.frameHeightTextField.delegate = self;
    self.imageWidthTextField.delegate = self;
    self.imageHeightTextField.delegate = self;
    
    _matBorder = [[MatBorder alloc] init];
}

- (void)dealloc {    
    self.frameWidthTextField.delegate = nil;
    self.frameHeightTextField.delegate = nil;
    self.imageWidthTextField.delegate = nil;
    self.imageHeightTextField.delegate = nil;
    
}

- (IBAction)calculateButtonPressed:(UIButton *)sender {
    NSLog(@"Calculate!");
    
    [self calculate];
}

- (void)calculate {
    
    // Grab user input
    _matBorder.frameWidth = [self.frameWidthTextField.text doubleValue];
    _matBorder.frameHeight = [self.frameHeightTextField.text doubleValue];
    
    _matBorder.imageWidth = [self.imageWidthTextField.text doubleValue];
    _matBorder.imageHeight = [self.imageHeightTextField.text doubleValue];
    
    [_matBorder calculateBorders];
    
//    NSNumber *topBorderNumber = @(matBorder.topBorderWidth);
//    NSString *topBorderText = [topBorderNumber stringValue];
//    self.topBorderLabel.text = topBorderText;
    
    // Update UI
    self.topBorderLabel.text = [@(_matBorder.topBorderWidth) stringValue];
    self.leftBorderLabel.text = [@(_matBorder.leftBorderWidth) stringValue];
    self.bottomBorderLabel.text = [@(_matBorder.bottomBorderWidth) stringValue];
    self.rightBorderlabel.text = [@(_matBorder.rightBorderWidth) stringValue];
    
    [self hideKeyboard];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    NSLog(@"updateViewConstraints");
    
    // width / height = aspect ratio   4 : 3    4 / 3
    // 6 : 4   6 / 4  == 3 / 2
    
    double frameWidth = _matBorder.frameWidth;
    double frameHeight = _matBorder.frameHeight;
    
    double maxEdge = 160;
    
    double frameWidthPoints = 0;
    double frameHeightPoints = 0;
    
    // width1 / height1  = width2 / height2
    if(frameWidth > 0 && frameHeight) {
        // landscape
        if(frameWidth >= frameHeight) {
            frameWidthPoints = maxEdge;
            frameHeightPoints = frameWidthPoints * (frameHeight / frameWidth);
            
        } else { // frameHeight > frameWidth
            frameHeightPoints = maxEdge;
            frameWidthPoints = frameHeightPoints * (frameWidth / frameHeight);
        }
        
        self.frameWidthConstraint.constant = frameWidthPoints;
        self.frameHeightConstraint.constant = frameHeightPoints;
        
        // points per inch
        
        // frameWidthPoints = 160 points , frameWidth = 20 inches
        // 160 points / 20 inches = 8 points/inch
        // 10x10 inches
        // 10 inches * 8 points / 1 inch = 80 points
        
        double pointsPerInch = frameWidthPoints / frameWidth;
        
        self.imageWidthConstraint.constant = _matBorder.imageWidth * pointsPerInch;
        self.imageHeightConstraint.constant = _matBorder.imageHeight * pointsPerInch;
        
        
    }
    
    [super updateViewConstraints];
}

- (void)hideKeyboard {
//    [self.frameWidthTextField resignFirstResponder];
    
    [self.view endEditing:NO];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self calculate];
    
    return YES;
}




@end
