//
//  MatBorder.m
//  MatBorderCalculator Part 3
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "MatBorder.h"

@implementation MatBorder

- (void)dealloc {
    NSLog(@"Dealloc: MatBorder");
}
- (void)calculateBorders {

    double horizontalBorder = (self.frameWidth - self.imageWidth) / 2.0;
    double verticalBorder = (self.frameHeight - self.imageHeight) / 2.0;
    
    self.leftBorderWidth = horizontalBorder;
    self.rightBorderWidth = horizontalBorder;
    
    self.topBorderWidth = verticalBorder;
    self.bottomBorderWidth = verticalBorder;
}

- (NSString *)description {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:4];
    
    return [NSString stringWithFormat:@"Frame: %@x%@ Image: %@x%@",
            [numberFormatter stringFromNumber:@(self.frameWidth)],
            [numberFormatter stringFromNumber:@(self.frameHeight)],
            [numberFormatter stringFromNumber:@(self.imageWidth)],
            [numberFormatter stringFromNumber:@(self.imageHeight)]];
}

@end
