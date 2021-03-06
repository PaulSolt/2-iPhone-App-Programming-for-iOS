//
//  UnitSliderView.m
//  MatBorderCalculator 15.1
//
//  Created by Paul on 4/21/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "UnitSliderView.h"
#import "FractionHelper.h"
#import "Fraction.h"

@interface UnitSliderView() {
    // private variables
    double _backingWholeNumber;
    double _backingNumerator;
    
    double _translationScale;
}

@end


@implementation UnitSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // 1. Load the .xib
        [[NSBundle mainBundle] loadNibNamed:@"UnitSliderView" owner:self options:nil];
        
        // 2. Set the bounds
        if(CGRectIsEmpty(frame)) {
            self.bounds = self.view.bounds;
        }
        // 3. Add to subview
        [self addSubview:self.view];
       
        [self setup];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        
        // 1. Load the .xib
        
        [[NSBundle mainBundle] loadNibNamed:@"UnitSliderView" owner:self options:nil];
        
        // 2. Setup subview
        
        [self addSubview:self.view];
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    NSLog(@"setup the UnitSliderView");
    
//    self.backgroundColor = [UIColor blueColor];
    // Add Gestures here
    
    UIPanGestureRecognizer *wholeNumberPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleWholeNumberPanGesture:)];
    [self.wholeNumberLabel addGestureRecognizer:wholeNumberPanGesture];
    self.wholeNumberLabel.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *fractionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleFractionPanGesture:)];
    [self addGestureRecognizer:fractionPanGesture];
    
    // Set default values
    _translationScale = .1;
    
    _numerator = 0;
    _denominator = 8;
    _preferredDenominator = 8;
    
    [self refreshUI];
}

- (double)distanceWithPanGesture:(UIPanGestureRecognizer *)gesture {
    double result = 0;
    
    CGPoint translation = [gesture translationInView:gesture.view];
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
//    NSLog(@"Translation: %f", translation.y * _translationScale);
    //    fabs() - absolute value
    if(fabs(translation.x) > fabs(translation.y)) {
        result = translation.x * _translationScale;
    } else {
        result = -translation.y * _translationScale;
    }

    return result;
}

- (void)handleWholeNumberPanGesture:(UIPanGestureRecognizer *)gesture {
    
//    NSLog(@"whole number pan");
    
    _backingWholeNumber += [self distanceWithPanGesture:gesture];
    _backingWholeNumber = MAX(0, _backingWholeNumber);

    // Set properties
    _wholeNumber = floor(_backingWholeNumber);
    
    _value = _wholeNumber + _numerator / _denominator;
    
    [self refreshWholeNumberUI];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)handleFractionPanGesture:(UIPanGestureRecognizer *)gesture {
//    NSLog(@"fraction pan");
    
    _backingNumerator += [self distanceWithPanGesture:gesture];
    _backingNumerator = MAX(0, _backingNumerator);
    _backingNumerator = MIN(_preferredDenominator - 1, _backingNumerator);
    
//    NSLog(@"%f : floor(%f) : %.10f", _backingFraction, floor(_backingFraction), _backingFraction);
    
    _numerator = floor(_backingNumerator);

    _value = _wholeNumber + _numerator / _denominator;
    
    [self refreshFractionUI];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

// Update UI

- (void)refreshWholeNumberUI {
    self.wholeNumberLabel.text = [@(self.wholeNumber) stringValue];
}

- (void)refreshFractionUI {
    self.fractionLabel.text = [NSString stringWithFormat:@"%.0f/%.0f", self.numerator, self.denominator];
}

- (void)refreshUI {
    [self refreshWholeNumberUI];
    [self refreshFractionUI];
}

// Override Property Setters

- (void)setWholeNumber:(double)wholeNumber {
    _wholeNumber = wholeNumber;
    
    _backingWholeNumber = _wholeNumber;
    
    [self refreshWholeNumberUI];
}

- (void)setNumerator:(double)numerator {
    _numerator = numerator;
    
    _backingNumerator = numerator;
    
    [self refreshFractionUI];
}

- (void)setDenominator:(double)denominator {
    _denominator = denominator;
    
    [self refreshFractionUI];
}

- (void)setValue:(double)value {
    _value = value;
    
    double intPart;
    double fractionalPart = modf(_value, &intPart);
    NSLog(@"int: %f fract: %f", intPart, fractionalPart);
    
    _wholeNumber = intPart;
    
    // Numerator is a whole number, fraction is not!
    
    // 0.625 -> 5/8
    
    Fraction *fraction = [FractionHelper convertNumberToFraction:fractionalPart];
    fraction = [FractionHelper expandFraction:fraction toDenominator:_preferredDenominator];
    
    _numerator = fraction.numerator;
    
    if(fraction.denominator != 1) {
        _denominator = fraction.denominator;
    } else {
        _denominator = _preferredDenominator;
    }
    
    // Set backing values
    _backingNumerator = _numerator;
    _backingWholeNumber = _wholeNumber;
    
    
    [self refreshUI];
}


@end
