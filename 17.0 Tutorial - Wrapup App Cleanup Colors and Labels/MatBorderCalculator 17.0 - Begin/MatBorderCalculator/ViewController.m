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
#import "UnitSliderView.h"
#import "FractionLabel.h"

@interface ViewController () <LayoutTableViewControllerDelegate> {
    MatBorder *_matBorder;
    NSMutableArray *_matBorderLayoutArray;
    NSInteger _selectedRow;
}

@property (weak, nonatomic) IBOutlet UnitSliderView *frameWidthSlider;
@property (weak, nonatomic) IBOutlet UnitSliderView *frameHeightSlider;
@property (weak, nonatomic) IBOutlet UnitSliderView *imageWidthSlider;
@property (weak, nonatomic) IBOutlet UnitSliderView *imageHeightSlider;


@property (weak, nonatomic) IBOutlet FractionLabel *leftBorderFractionLabel;
@property (weak, nonatomic) IBOutlet FractionLabel *bottomBorderFractionLabel;
@property (weak, nonatomic) IBOutlet FractionLabel *rightBorderFractionLabel;
@property (weak, nonatomic) IBOutlet FractionLabel *topBorderFractionLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frameWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frameHeightConstraint;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.frameWidthSlider addTarget:self action:@selector(unitSliderDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.frameHeightSlider addTarget:self action:@selector(unitSliderDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.imageWidthSlider addTarget:self action:@selector(unitSliderDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.imageHeightSlider addTarget:self action:@selector(unitSliderDidChangeValue:) forControlEvents:UIControlEventValueChanged];

    
    
    _matBorder = [[MatBorder alloc] init];
    
    // Load data on start, or create starting values
    [self loadData];
    
    _selectedRow = 0;
    [self updateDisplayForSelectedRow];
    [self calculate];
    
    // Add a test UnitSliderView
    
//    UnitSliderView *unitSlider = [[UnitSliderView alloc] init];
//    unitSlider.center = CGPointMake(-160, 200);
//    [self.view addSubview:unitSlider];
//    
//    unitSlider.alpha = 0;
//    [UIView animateWithDuration:2 animations:^ {
//        unitSlider.alpha = 1;
//        unitSlider.center = CGPointMake(160 / 2, 200);
//
//    }];
    

//    self.frameWidthSlider.wholeNumber = 100;
//    self.frameWidthSlider.numerator = 4;
//    self.frameWidthSlider.denominator = 8;
    
}

- (void)unitSliderDidChangeValue:(UnitSliderView *)unitSlider {
    NSLog(@"slider: %f %f/%f", unitSlider.wholeNumber, unitSlider.numerator, unitSlider.denominator);
    NSLog(@"value: %f", unitSlider.value);
    
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
    @try {
        _matBorderLayoutArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        // 2. If no app data, create new app data
        
        if(!_matBorderLayoutArray) {
            _matBorderLayoutArray = [[NSMutableArray alloc] init];
            
            // load real data
            [self addStarterData];
        }
    }
    
    
}

- (void)saveData {
    NSLog(@"Saving MatBorder Data");
    
    NSString *filename = @"MatBorder.plist";
    NSString *filepath = [[self documentsDirectory] stringByAppendingPathComponent:filename];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:_matBorderLayoutArray toFile:filepath];
    
    NSLog(@"Saved data success: %d", success);
}

- (void)addStarterData {
    
    // 20x16, 14x11
    // 10x8, 7x5
    // 8x10, 5x7
    // 20x30, 16x20
    
    MatBorder *matBorder1 = [[MatBorder alloc] initWithFrameWidth:20 frameHeight:16 imageWidth:14 imageHeight:11];
    MatBorder *matBorder2 = [[MatBorder alloc] initWithFrameWidth:10 frameHeight:8 imageWidth:7 imageHeight:5];
    MatBorder *matBorder3 = [[MatBorder alloc] initWithFrameWidth:8 frameHeight:10 imageWidth:5 imageHeight:7];
    MatBorder *matBorder4 = [[MatBorder alloc] initWithFrameWidth:20 frameHeight:30 imageWidth:16 imageHeight:20];
    
    [_matBorderLayoutArray addObjectsFromArray:@[matBorder1, matBorder2, matBorder3, matBorder4]];
    
    
}

- (void)dealloc {    
    
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
    _matBorder.frameWidth = self.frameWidthSlider.value;
    _matBorder.frameHeight = self.frameHeightSlider.value;
    _matBorder.imageWidth = self.imageWidthSlider.value;
    _matBorder.imageHeight = self.imageHeightSlider.value;
    
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

    self.leftBorderFractionLabel.value = _matBorder.leftBorderWidth;
    self.topBorderFractionLabel.value = _matBorder.topBorderWidth;
    self.rightBorderFractionLabel.value = _matBorder.rightBorderWidth;
    self.bottomBorderFractionLabel.value = _matBorder.bottomBorderWidth;
    
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
        
        // TODO: fix setters
//        _frameWidthTextField.text = [@(matBorder.frameWidth) stringValue];
//        _frameHeightTextField.text = [@(matBorder.frameHeight) stringValue];
//        
//        _imageWidthTextField.text = [@(matBorder.imageWidth) stringValue];
//        _imageHeightTextField.text = [@(matBorder.imageHeight) stringValue];
        
        self.frameWidthSlider.value = matBorder.frameWidth;
        self.frameHeightSlider.value = matBorder.frameHeight;
        
        self.imageWidthSlider.value = matBorder.imageWidth;
        self.imageHeightSlider.value = matBorder.imageHeight;
        
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
