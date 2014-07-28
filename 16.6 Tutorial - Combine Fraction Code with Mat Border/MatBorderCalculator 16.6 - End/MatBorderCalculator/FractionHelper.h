//
//  FractionHelper.h
//  FractionTool
//
//  Created by Paul on 4/24/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Fraction;

@interface FractionHelper : NSObject

+ (Fraction *)convertNumberToFraction:(double)number;

+ (Fraction *)reduceFraction:(Fraction *)fraction;

+ (long)gcd:(long)m n:(long)n;

+ (Fraction *)expandFraction:(Fraction *)fraction toDenominator:(long)denominator;

@end
