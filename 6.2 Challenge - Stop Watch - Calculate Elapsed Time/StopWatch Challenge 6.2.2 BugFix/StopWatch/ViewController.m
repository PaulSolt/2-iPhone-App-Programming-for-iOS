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
//    NSLog(@"Timer: %@", timer); //_currentDate);
    
    [self updateDisplayTime];
}

- (void)startTimer {
    if(!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    
    
        // store a start date
        if(!_startDate) { // First run
            _startDate = [NSDate date];
        } else {
            // resume
            NSTimeInterval duration = [_stopDate timeIntervalSinceDate:_startDate];
            _startDate = [NSDate dateWithTimeInterval:-duration sinceDate:[NSDate date]];
            
        }

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
        NSString *startDateString = [dateFormatter stringFromDate:_startDate];

        NSLog(@"Start: %@", startDateString);
    }
}

- (void)stopTimer {
    [_myTimer invalidate];
    _myTimer = nil;
    
    if(_startDate) {

        // store an stop date
        _stopDate = [NSDate date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
        NSString *stopDateString = [dateFormatter stringFromDate:_stopDate];
        
        NSLog(@"Stop: %@", stopDateString);

    //    self.timeLabel.text = stopDateString;
        
        [self updateDisplayTime];
    }
}

- (void)resetTimer {
    
    [self stopTimer];
    
    _startDate = nil;
    _stopDate = nil;
    
    self.timeLabel.text = @"00:00:00.000";
    
}

- (void)updateDisplayTime {
    
    _currentDate = [NSDate date];
    
    NSTimeInterval elapsedSeconds = [_currentDate timeIntervalSinceDate:_startDate];
    
//    NSLog(@"elapsedSeconds: %f", elapsedSeconds);
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags fromDate:_startDate toDate:_currentDate options:0];
    
    NSInteger hours = [dateComponents hour];
    NSInteger minutes = [dateComponents minute];
    NSInteger seconds = [dateComponents second];
    
//    NSLog(@"%d:%d:%d", hours, minutes, seconds);
    
    // Grab the decimal places to the right side of elapsed time
    double intPart;
    double milliseconds = modf(elapsedSeconds, &intPart);
    
    // 2.3    ->   intPart = 2.0  milliseconds = 0.3
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%06.3f", hours, minutes, seconds + milliseconds];
    
    NSLog(@"self.timeLabel.text: %@", self.timeLabel.text);
    
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
