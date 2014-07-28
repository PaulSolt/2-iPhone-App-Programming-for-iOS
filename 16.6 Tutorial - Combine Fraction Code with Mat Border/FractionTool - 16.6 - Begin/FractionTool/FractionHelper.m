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
    Fraction *result = [[Fraction alloc] init];
    
    // 0.625     625 = 0.625 * 1000 = 0.625 * 10^3
    
    // Calcuate how many decimal digits are there?
    NSString *numberString = [@(number) stringValue];
//    NSLog(@"numberString: %@", numberString);
    NSArray *numberPartArray = [numberString componentsSeparatedByString:@"."];
//    NSLog(@"numberPartArray: %@", numberPartArray);
    
    NSString *decimalString = [numberPartArray lastObject];
    
//    NSLog(@"digits: %ld", (unsigned long)[decimalString length]);
    
    double numberOfDigits = [decimalString length];
    double powerOf10 = pow(10.0, numberOfDigits);
    
    result.numerator = number * powerOf10;
    result.denominator = powerOf10;
    
    // reduce
    result = [FractionHelper reduceFraction:result];
    
    return result;
}

+ (Fraction *)reduceFraction:(Fraction *)fraction {
    Fraction *result = [[Fraction alloc] init];
    
    long gcd = [FractionHelper gcd:fraction.numerator n:fraction.denominator];
    
    result.numerator = fraction.numerator;
    result.denominator = fraction.denominator;
    
    if(gcd != 0) {
        result.numerator /= gcd;
        result.denominator /= gcd;
    }
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
