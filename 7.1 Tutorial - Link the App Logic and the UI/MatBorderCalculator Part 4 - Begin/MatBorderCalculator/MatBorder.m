//
//  MatBorder.m
//  MatBorderCalculator Part 3
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "MatBorder.h"

@implementation MatBorder

- (void)calculateBorders {

    double horizontalBorder = (self.frameWidth - self.imageWidth) / 2.0;
    double verticalBorder = (self.frameHeight - self.imageHeight) / 2.0;
    
    self.leftBorderWidth = horizontalBorder;
    self.rightBorderWidth = horizontalBorder;
    
    self.topBorderWidth = verticalBorder;
    self.bottomBorderWidth = verticalBorder;
}

@end
