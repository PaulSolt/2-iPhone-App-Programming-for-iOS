//
//  ViewController.m
//  FractionTool
//
//  Created by Paul on 4/24/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "Fraction.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    // 1. Create fraction
    Fraction *f1 = [[Fraction alloc] initWithNumerator:625 denominator:1000];
    NSLog(@"Fraction: %@", f1);
    
    // 2. Reduce the fraction

    

}


@end
