//
//  ViewController.m
//  MatBorderCalculator
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "MatBorder.h"
#import "LayoutTableViewController.h"

@interface ViewController () <UITextFieldDelegate, LayoutTableViewControllerDelegate> {
    MatBorder *_matBorder;
    NSMutableArray *_matBorderLayoutArray;
    NSInteger _selectedRow;
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
    
    // Load data on start, or create starting values
    [self loadData];
    
    _selectedRow = 0;
    [self updateDisplayForSelectedRow];
    [self calculate];
}

- (NSString *)documentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (void)loadData {
    NSLog(@"Loading MatBorder Data");
    NSString *filename = @"MatBorder.plist";
    NSString *filepath = [[self documentsDirectory] stringByAppendingPathComponent:filename];
    
    // 1. Load the app data

    _matBorderLayoutArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    
    
    // 2. If no app data, create new app data

    if(!_matBorderLayoutArray) {
        _matBorderLayoutArray = [[NSMutableArray alloc] init];
        
        // load test data or real data
        [self addTestData];
    }
    
}

- (void)saveData {
    NSLog(@"Saving MatBorder Data");
    
    NSString *filename = @"MatBorder.plist";
    NSString *filepath = [[self documentsDirectory] stringByAppendingPathComponent:filename];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:_matBorderLayoutArray toFile:filepath];
    
    NSLog(@"Saved data success: %d", success);
}

- (void)addTestData {
    
    for(int i = 0; i < 5; i++) {
        MatBorder *matBorder = [[MatBorder alloc] init];
        
        matBorder.frameWidth = 10 + arc4random_uniform(10);
        matBorder.frameHeight = 8 + arc4random_uniform(8);
        matBorder.imageWidth = 7 + arc4random_uniform(7);
        matBorder.imageHeight = 5 + arc4random_uniform(5);
        
        [_matBorderLayoutArray addObject:matBorder];
    }
    
}

- (void)dealloc {    
    self.frameWidthTextField.delegate = nil;
    self.frameHeightTextField.delegate = nil;
    self.imageWidthTextField.delegate = nil;
    self.imageHeightTextField.delegate = nil;
    
}
- (IBAction)layoutsButtonPressed:(id)sender {
    
    [self calculate];
    
    // Create the UI
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LayoutTableViewController *layoutTableViewController = [storyboard instantiateViewControllerWithIdentifier:@"LayoutTableViewController"];
    layoutTableViewController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:layoutTableViewController];
    
    // Pass the data
    layoutTableViewController.matBorderLayoutArray = _matBorderLayoutArray;
    layoutTableViewController.selectedRow = _selectedRow;
    
    // Transition to the view controller
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

- (IBAction)calculateButtonPressed:(id)sender {
    NSLog(@"Calculate!");
    
    [self calculate];
}

- (void)captureUserInterfaceData {
    
    // Grab user input
    _matBorder.frameWidth = [self.frameWidthTextField.text doubleValue];
    _matBorder.frameHeight = [self.frameHeightTextField.text doubleValue];
    
    _matBorder.imageWidth = [self.imageWidthTextField.text doubleValue];
    _matBorder.imageHeight = [self.imageHeightTextField.text doubleValue];

    // update the data array
    if(_selectedRow < [_matBorderLayoutArray count]) {
        MatBorder *selectedMatBorder = _matBorderLayoutArray[_selectedRow];
        
        selectedMatBorder.frameWidth = _matBorder.frameWidth;
        selectedMatBorder.frameHeight = _matBorder.frameHeight;
        selectedMatBorder.imageWidth = _matBorder.imageWidth;
        selectedMatBorder.imageHeight = _matBorder.imageHeight;
        
    }
    
}

- (void)calculate {
    
    // Grab user input
    [self captureUserInterfaceData];
    
    [_matBorder calculateBorders];
    
    // Update UI
    self.topBorderLabel.text = [@(_matBorder.topBorderWidth) stringValue];
    self.leftBorderLabel.text = [@(_matBorder.leftBorderWidth) stringValue];
    self.bottomBorderLabel.text = [@(_matBorder.bottomBorderWidth) stringValue];
    self.rightBorderlabel.text = [@(_matBorder.rightBorderWidth) stringValue];
    
    [self hideKeyboard];
    [self.view setNeedsUpdateConstraints];
    
    // Save the app data
    
    [self saveData];
}

- (void)updateViewConstraints {
    
    double frameWidth = _matBorder.frameWidth;
    double frameHeight = _matBorder.frameHeight;
    
    double maxEdge = 160;
    
    double frameWidthPoints = 0;
    double frameHeightPoints = 0;
    
    // width1 / height1  = width2 / height2
    if(frameWidth > 0 && frameHeight > 0) {
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
    [self.view endEditing:NO];    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self calculate];
    
    return YES;
}

- (void)updateDisplayForSelectedRow {
    if(_selectedRow < [_matBorderLayoutArray count]) {
        MatBorder *matBorder = _matBorderLayoutArray[_selectedRow];
        
        // Update the UI for new setting
        
        _frameWidthTextField.text = [@(matBorder.frameWidth) stringValue];
        _frameHeightTextField.text = [@(matBorder.frameHeight) stringValue];
        
        _imageWidthTextField.text = [@(matBorder.imageWidth) stringValue];
        _imageHeightTextField.text = [@(matBorder.imageHeight) stringValue];
    }
    
}


#pragma mark - LayoutTableViewControllerDelegate Methods

- (void)layoutTableViewControllerDidFinish:(LayoutTableViewController *)layoutTableViewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)layoutTableViewController:(LayoutTableViewController *)layoutTableViewController didSelectIndexPath:(NSIndexPath *)indexPath {
    
    _selectedRow = indexPath.row;
    
    [self updateDisplayForSelectedRow];
    
    [self calculate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
