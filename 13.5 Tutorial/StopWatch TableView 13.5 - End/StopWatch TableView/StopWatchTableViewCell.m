//
//  StopWatchTableViewCell.m
//  StopWatch TableView 13.2
//
//  Created by Paul on 3/18/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "StopWatchTableViewCell.h"

@implementation StopWatchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    // iOS 7 - UIScrollView
    for(UIView *subview in self.subviews) {
        if([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)subview;
            [scrollView setDelaysContentTouches:NO];
            break;
        }
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startStopButtonPressed:(id)sender {
    NSLog(@"startStop");
    
    if(self.stopWatch.didStart) {
        [self.stopWatch stopTimer];
        
        self.iconImageView.image = [UIImage imageNamed:@"StartButton.png"];
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        
    } else {
        [self.stopWatch startTimer];
        
        self.iconImageView.image = [UIImage imageNamed:@"StopButton.png"];
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];

    }
}

- (IBAction)resetButtonPressed:(id)sender {
    NSLog(@"reset");
    
    [self.stopWatch resetTimer];
    
    self.iconImageView.image = [UIImage imageNamed:@"StartButton.png"];
    [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
}

#pragma mark - StopWatchDelegate
- (void)stopWatchDidUpdate:(StopWatch *)stopWatch {
    
//    NSLog(@"StopWatch");
    NSTimeInterval duration = stopWatch.duration;
    self.timeLabel.text = [stopWatch formatTimeInterval:duration];
}
@end
