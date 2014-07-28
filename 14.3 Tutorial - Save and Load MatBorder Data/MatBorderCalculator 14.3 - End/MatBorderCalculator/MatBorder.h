//
//  MatBorder.h
//  MatBorderCalculator Part 3
//
//  Created by Paul on 1/17/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatBorder : NSObject <NSCoding>

@property (assign, nonatomic) double frameWidth;
@property (assign, nonatomic) double frameHeight;
@property (assign, nonatomic) double imageWidth;
@property (assign, nonatomic) double imageHeight;

@property (assign, nonatomic) double topBorderWidth;
@property (assign, nonatomic) double leftBorderWidth;
@property (assign, nonatomic) double bottomBorderWidth;
@property (assign, nonatomic) double rightBorderWidth;

- (void)calculateBorders;

@end
