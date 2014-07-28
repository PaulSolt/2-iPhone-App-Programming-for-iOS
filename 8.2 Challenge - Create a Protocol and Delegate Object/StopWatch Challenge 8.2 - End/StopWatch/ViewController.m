//
//  ViewController.m
//  StopWatch
//
//  Created by Paul on 2/4/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "StopWatch.h"

@interface ViewController () <StopWatchDelegate> {
    StopWatch *_stopWatch;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _stopWatch = [[StopWatch alloc] init];
    _stopWatch.delegate = self;
//    _stopWatch.dateFormatString = @"HH:ss";
    
    [_stopWatch resetTimer];
}

- (void)startTimer {
    [_stopWatch startTimer];
}

- (void)stopTimer {
    [_stopWatch stopTimer];
}

- (void)resetTimer {
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

#pragma mark - StopWatchDelegate

- (void)stopWatchDidUpdate:(StopWatch *)stopWatch {
    
    NSTimeInterval duration = [stopWatch duration];
    
    self.timeLabel.text = [stopWatch formatTimeInterval:duration];
    
}


@end
