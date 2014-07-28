//
//  Fraction.m
//  FractionTool
//
//  Created by Paul on 4/24/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

- (id)initWithNumerator:(long)numerator denominator:(long)denominator {
    self = [super init];
    if(self) {
        _numerator = numerator;
        _denominator = denominator;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%ld/%ld", _numerator, _denominator];
}

@end
