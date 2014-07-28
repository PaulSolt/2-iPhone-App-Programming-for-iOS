//
//  StopWatch.m
//  StopWatch Challenge 7.2
//
//  Created by Paul on 2/11/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "StopWatch.h"

@interface StopWatch() {
    NSTimer *_myTimer;
    NSDate *_currentDate;
}

@end

@implementation StopWatch

- (void)updateTime:(NSTimer *)timer {
    
    _currentDate = [NSDate date];
    //    NSLog(@"Timer: %@", timer); //_currentDate);
    
    [self updateStopWatch];
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
        
        NSLog(@"Stop: %@", [self formatTimeInterval:(60 * 60 * 23) + (60 * 2) + 23.541]);
        
        [self updateStopWatch];
    }
}

- (void)resetTimer {
    
    [self stopTimer];
    
    _startDate = nil;
    _stopDate = nil;
    
    // TODO: update the timer
}

- (void)updateStopWatch {
    
    _currentDate = [NSDate date];
    
    NSTimeInterval elapsedSeconds = [_currentDate timeIntervalSinceDate:_startDate];
    NSString *stopWatchString = [self formatTimeInterval:elapsedSeconds];
    NSLog(@"Timer: %@", stopWatchString);
}

- (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval {
    // Shift a date using the elapsedSeconds back to 1970
    
    NSDate *startDate1970 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSString *dateString = [dateFormatter stringFromDate:startDate1970];
    return dateString;
}




@end
