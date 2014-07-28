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
    
    NSDate *_startDate;
    NSDate *_stopDate;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)updateTime:(NSTimer *)timer {
    
    _currentDate = [NSDate date];
    NSLog(@"Timer: %@", timer); //_currentDate);
    
}

- (void)startTimer {
    if(!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    }
    
    // store a start date
    _startDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *startDateString = [dateFormatter stringFromDate:_startDate];
    
    NSLog(@"Start: %@", startDateString);
}

- (void)stopTimer {
    [_myTimer invalidate];
    _myTimer = nil;
    
    // store an stop date
    _stopDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *stopDateString = [dateFormatter stringFromDate:_stopDate];
    
    NSLog(@"Stop: %@", stopDateString);

    self.timeLabel.text = stopDateString;
}

- (void)resetTimer {
    
    [self stopTimer];
    
    _startDate = nil;
    _stopDate = nil;
    
    self.timeLabel.text = @"00:00:00";
    
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
