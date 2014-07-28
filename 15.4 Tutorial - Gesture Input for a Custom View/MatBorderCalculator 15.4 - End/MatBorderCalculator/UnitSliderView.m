//
//  UnitSliderView.m
//  MatBorderCalculator 15.1
//
//  Created by Paul on 4/21/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "UnitSliderView.h"

@interface UnitSliderView() {
    // private variables
    double _backingWholeNumber;
    double _backingFraction;
    
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
    self.wholeNumberLabel.text = [@(floor(_backingWholeNumber)) stringValue];
    
}

- (void)handleFractionPanGesture:(UIPanGestureRecognizer *)gesture {
//    NSLog(@"fraction pan");
    
    _backingFraction += [self distanceWithPanGesture:gesture];
    _backingFraction = MAX(0, _backingFraction);
//    NSLog(@"%f : floor(%f) : %.10f", _backingFraction, floor(_backingFraction), _backingFraction);
    self.fractionLabel.text = [NSString stringWithFormat:@"%.0f/%.0f", floor(_backingFraction), 0.0];
}







@end
