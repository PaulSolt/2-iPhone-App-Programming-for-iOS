//
//  ViewController.m
//  StopWatch
//
//  Created by Paul on 2/4/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "StopWatch.h"

@interface ViewController () {
    StopWatch *_stopWatch;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _stopWatch = [[StopWatch alloc] init];
}

- (void)startTimer {
    [_stopWatch startTimer];
}

- (void)stopTimer {
    [_stopWatch stopTimer];
}

- (void)resetTimer {
    self.timeLabel.text = @"00:00:00.000";
    [_stopWatch resetTimer];
}

- (IBAction)startButtonPressed:(id)sender {
    NSLog(@"start");
    [self startTimer];
}
- (IBAction)stopButtonPressed:(id)sender {
    NSLog(@"stop");
    
    [self stopTimer];
}
- (IBAction)resetButtonPressed:(id)sender {
    NSLog(@"reset");
    
    [self resetTimer];
}

@end
