//
//  FractionLabel.m
//  MatBorderCalculator 16.7
//
//  Created by Paul on 6/9/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "FractionLabel.h"

@implementation FractionLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // 1. Load the .xib file
        [[NSBundle mainBundle] loadNibNamed:@"FractionLabel" owner:self options:nil];
        
        // 2. Set the bounds
        if(CGRectIsEmpty(frame)) {
            self.bounds = self.view.bounds;
        }
        
        // 3. Add to subview
        [self addSubview:self.view];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        
        // 1. Load the .xib file
        
        [[NSBundle mainBundle] loadNibNamed:@"FractionLabel" owner:self options:nil];
        
        // 2. Add our subview
        
        [self addSubview:self.view];
    }
    return self;
}



@end
