//
//  MatBorder.m
//  MatBorderCalculator Part 3
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "MatBorder.h"

static NSString *const kFrameWidth = @"frameWidth";
static NSString *const kFrameHeight = @"frameHeight";
static NSString *const kImageWidth = @"imageWidth";
static NSString *const kImageHeight = @"imageHeight";

@implementation MatBorder

- (id)initWithFrameWidth:(double)frameWidth
             frameHeight:(double)frameHeight
              imageWidth:(double)imageWidth
             imageHeight:(double)imageHeight {
    self = [super init];
    if(self) {
        _frameWidth = frameWidth;
        _frameHeight = frameHeight;
        _imageWidth = imageWidth;
        _imageHeight = imageHeight;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        _frameWidth = [aDecoder decodeDoubleForKey:kFrameWidth];
        _frameHeight = [aDecoder decodeDoubleForKey:kFrameHeight];
        _imageWidth = [aDecoder decodeDoubleForKey:kImageWidth];
        _imageHeight = [aDecoder decodeDoubleForKey:kImageHeight];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeDouble:_frameWidth forKey:kFrameWidth];
    [aCoder encodeDouble:_frameHeight forKey:kFrameHeight];
    [aCoder encodeDouble:_imageWidth forKey:kImageWidth];
    [aCoder encodeDouble:_imageHeight forKey:kImageHeight];
    
}


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
