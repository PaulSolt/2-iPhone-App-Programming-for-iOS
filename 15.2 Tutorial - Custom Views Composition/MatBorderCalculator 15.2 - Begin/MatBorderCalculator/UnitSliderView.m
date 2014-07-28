//
//  UnitSliderView.m
//  MatBorderCalculator 15.1
//
//  Created by Paul on 4/21/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "UnitSliderView.h"

@implementation UnitSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
        
    }
    return self;
}

@end
