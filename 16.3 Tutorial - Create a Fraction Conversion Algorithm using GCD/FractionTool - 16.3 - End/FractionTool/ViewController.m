//
//  ViewController.m
//  FractionTool
//
//  Created by Paul on 4/24/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "Fraction.h"
#import "FractionHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    // 1. Create fraction
    Fraction *f1 = [[Fraction alloc] initWithNumerator:625 denominator:1000];
    NSLog(@"Fraction: %@", f1);
    
    // a. Test gcd
    NSLog(@"gcd(1000, 625): %ld", [FractionHelper gcd:1000 n:625]);
    NSLog(@"gcd(625, 1000): %ld", [FractionHelper gcd:625 n:1000]);

    // 2. Reduce the fraction

    

}


@end
