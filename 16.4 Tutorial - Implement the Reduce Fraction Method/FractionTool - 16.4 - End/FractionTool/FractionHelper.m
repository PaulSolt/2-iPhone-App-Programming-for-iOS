//
//  FractionHelper.m
//  FractionTool
//
//  Created by Paul on 4/24/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "FractionHelper.h"
#import "Fraction.h"

@implementation FractionHelper

+ (Fraction *)convertNumberToFraction:(double)number {
    return nil;
}

+ (Fraction *)reduceFraction:(Fraction *)fraction {
    Fraction *result = [[Fraction alloc] init];
    
    long gcd = [FractionHelper gcd:fraction.numerator n:fraction.denominator];
    
    result.numerator = fraction.numerator / gcd;
    result.denominator = fraction.denominator / gcd;

    return result;
}


+ (long)gcd:(long)m n:(long)n {
    // Euclidean Algorithm to get greatest common denominator
    long remainder;
    
    // 1000 % 625   ->    625 % 375    -> 375 % 250  -> 250 % 125  -> 0
    while(n != 0) {
        remainder = m % n;
        m = n;
        n = remainder;
    }
    
    return m;
}






@end
