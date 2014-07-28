//
//  Fraction.h
//  FractionTool
//
//  Created by Paul on 4/24/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

@property (nonatomic, assign) double numerator;
@property (nonatomic, assign) double denominator;

- (id)initWithNumerator:(double)numerator denominator:(double)denominator;

@end
