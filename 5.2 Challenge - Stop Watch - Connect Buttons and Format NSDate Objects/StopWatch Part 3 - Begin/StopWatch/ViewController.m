//
//  ViewController.m
//  StopWatch
//
//  Created by Paul on 2/4/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSTimer *_myTimer;
    NSDate *_currentDate;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Test the timer
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    
}

- (void)updateTime:(NSTimer *)timer {
    
    _currentDate = [NSDate date];
    NSLog(@"Date: %@", _currentDate);
    
}

- (void)stopTimer {
    
    [_myTimer invalidate];
    _myTimer = nil;
}


@end
