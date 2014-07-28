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
    return [NSString stringWithFormat:@"Frame: %0.0fx%0.0f Image: %0.0fx%0.0f", self.frameWidth, self.frameHeight, self.imageWidth, self.imageHeight];
}

@end
