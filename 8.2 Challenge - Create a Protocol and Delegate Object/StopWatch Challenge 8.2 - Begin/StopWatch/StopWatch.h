//
//  StopWatch.h
//  StopWatch Challenge 7.2
//
//  Created by Paul on 2/11/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StopWatch : NSObject

@property (readonly, nonatomic, strong) NSDate *startDate;
@property (readonly, nonatomic, strong) NSDate *stopDate;

- (void)startTimer;
- (void)stopTimer;
- (void)resetTimer;

- (NSString *)formatTimeInterval:(NSTimeInterval)timeInterval;

@end
