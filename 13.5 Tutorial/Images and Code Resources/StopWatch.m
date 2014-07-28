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

- (id)init {
    self = [super init];
    if(self) {
       
        // do work
        _dateFormatString = @"HH:mm:ss.SS";
        
    }
    return self;
}

- (void)updateTime:(NSTimer *)timer {
    
    _currentDate = [NSDate date];
    
    [self updateStopWatch];
}

- (void)startTimer {
    if(!_myTimer) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        
        _didStart = YES;
        
        // store a start date
        if(!_startDate) { // First run
            _startDate = [NSDate date];
        } else {
            // resume timer
            NSTimeInterval duration = [_stopDate timeIntervalSinceDate:_startDate];
            _startDate = [NSDate dateWithTimeInterval:-duration sinceDate:[NSDate date]];
            
        }
    }
}

- (void)stopTimer {
    
    if(_myTimer) {
        [_myTimer invalidate];
        _myTimer = nil;

        _didStart = NO;
        
        // store an stop date
        _stopDate = [NSDate date];
        
        [self updateStopWatch];
    }
}

- (void)resetTimer {
    
    [self stopTimer];
    
    _didStart = NO;
    
    _startDate = nil;
    _stopDate = nil;
    _currentDate = nil;
    
    // update the timer
    [self updateStopWatch];
}

- (void)updateStopWatch {
    
    _currentDate = [NSDate date];
    
    [self.delegate stopWatchDidUpdate:self];
}

- (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval {
    // Shift a date using the elapsedSeconds back to 1970
    
    NSDate *startDate1970 = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:_dateFormatString];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSString *dateString = [dateFormatter stringFromDate:startDate1970];
    return dateString;
}

- (NSTimeInterval)duration {
    NSTimeInterval elapsedSeconds = 0;

    if(_currentDate && _startDate) {
        elapsedSeconds = [_currentDate timeIntervalSinceDate:_startDate];
    }

    return elapsedSeconds;
}


@end
