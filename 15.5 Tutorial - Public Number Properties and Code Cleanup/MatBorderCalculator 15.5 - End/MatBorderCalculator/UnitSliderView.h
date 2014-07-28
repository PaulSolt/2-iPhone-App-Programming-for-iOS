//
//  UnitSliderView.h
//  MatBorderCalculator 15.1
//
//  Created by Paul on 4/21/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitSliderView : UIControl
@property (weak, nonatomic) IBOutlet UILabel *wholeNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *fractionLabel;
@property (strong, nonatomic) IBOutlet UIView *view;

@property (assign, nonatomic) double wholeNumber;
@property (assign, nonatomic) double numerator;
@property (assign, nonatomic) double denominator;

@property (assign, nonatomic) double value;  // wholeNumber + numerator / denominator


@end
